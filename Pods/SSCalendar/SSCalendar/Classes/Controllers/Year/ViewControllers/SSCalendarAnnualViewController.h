//
//  SSCalendarAnnualViewController.h
//  Pods
//
//  Created by Steven Preston on 7/19/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

//#import "SSContentViewController.h"

@class SSCalendarAnnualDataSource;

@interface SSCalendarAnnualViewController : UIViewController <UICollectionViewDelegate>
{
    NSString *selectedYear;
    NSArray *getAppointmentList;
    NSArray *recipes;
    NSArray *searchResults;
    NSArray *addEvents;
    CGFloat lastContentOffset;
    

}
@property (nonatomic, strong) IBOutlet UISearchBar *searchBar;
@property (nonatomic, strong) IBOutlet UIView *whiteBG;

@property (nonatomic, strong) IBOutlet UICollectionView *yearView;
@property (nonatomic, strong) SSCalendarAnnualDataSource *dataSource;
@property NSDictionary *listAppointments;
- (id)initWithEvents:(NSArray *)events;

@end
