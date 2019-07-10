//
//  SSCalendarDayView.h
//  Pods
//
//  Created by Steven Preston on 7/26/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@class SSDayNode;

@interface SSCalendarDayViewController : NSObject <UICollectionViewDataSource,UICollectionViewDelegate>
{
    NSDate *startDate;
}

@property (nonatomic, strong) SSDayNode *day;
@property (nonatomic, copy) NSArray *days;
@property (nonatomic, strong) NSMutableArray *visibleDays;
@property (nonatomic, weak) UICollectionView *view;
@property NSDictionary *listAppointments;

- (id)initWithView:(UICollectionView *)view andDict:(NSDictionary*)result;
- (void)scrollToDay:(SSDayNode *)day animated:(BOOL)animated;
- (void)reloadDay;

@end
