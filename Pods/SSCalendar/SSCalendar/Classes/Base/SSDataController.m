//
//  SSDataStore.m
//  eSchoolView
//
//  Created by Steven Preston on 7/2/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSDataController.h"
#import "SSCalendarCache.h"
#import "SSCalendarCountCache.h"
#import "SSYearNode.h"
#import "SSDayNode.h"
#import "SSEvent.h"
#import "SSConstants.h"

@implementation SSDataController

#pragma mark - Lifecycle Methods

- (id)init
{
    self = [super init];
    if (self) {
        self.calendarCache = [[SSCalendarCache alloc] init];
        self.calendarCountCache = [[SSCalendarCountCache alloc] init];
    }
    return self;
}

#pragma mark - Event Request Methods

- (BOOL)areEventsLoadedForYear:(NSInteger)year Month:(NSInteger)month
{
    return [_calendarCache areEventsLoadedForYear:year Month:month];
}

- (BOOL)hasEventsYear:(NSInteger)year Month:(NSInteger)month Date:(NSInteger)day
{
    return [_calendarCountCache hasEventsWithYear:year Month:month Day:day];
}

- (NSArray *)cachedEventsForYear:(NSInteger)year Month:(NSInteger)month Day:(NSInteger)day
{
    return [_calendarCache getEventsForYear:year Month:month Day:day];
}

- (NSArray *)calendarYears
{
    if (_calendarYears == nil) {
        NSString *savedValue = [[NSUserDefaults standardUserDefaults]
                                   stringForKey:@"selectedYear"];
        NSInteger savedYear = [savedValue integerValue];

        NSInteger currentYear = [[NSCalendar currentCalendar] component:NSCalendarUnitYear fromDate:[NSDate date]];
        
           NSInteger startYear = savedYear-1; // 100 years back
//           NSInteger endYear = currentYear ;   // 100 years forward
           NSInteger endYear = savedYear+1 ;   // 100 years forward

           NSMutableArray<SSYearNode *> *yearsArray = [NSMutableArray array];

           for (NSInteger year = startYear; year <= endYear; year++) {
               SSYearNode *yearNode = [[SSYearNode alloc] initWithValue:year];
               [yearsArray addObject:yearNode];
           }

           self.calendarYears = [yearsArray copy];
    }
    return _calendarYears;
}

- (void)updateCalendarYears {
    for (SSYearNode *year in self.calendarYears) {
        for (SSDayNode *day in year.days) {
            day.hasEvents = [self hasEventsYear:day.year Month:day.month Date:day.value];
            day.events = [self cachedEventsForYear:day.year Month:day.month Day:day.value];
        }
    }
}

- (void)setEvents:(NSArray *)events {
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"startDate" ascending:YES];
    NSArray *sortedResultsArray = [events sortedArrayUsingDescriptors:[NSArray arrayWithObject:sortDescriptor]];

    NSMutableArray *dates = [NSMutableArray new];
    for (SSEvent *event in events) {
        [dates addObject:event.startDate];
    }

    [_calendarCountCache putDates:dates];
    [_calendarCache putEvents:sortedResultsArray];
    [self updateCalendarYears];
}

@end
