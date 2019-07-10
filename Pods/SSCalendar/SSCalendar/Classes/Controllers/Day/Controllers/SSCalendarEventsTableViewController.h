//
//  SSCalendarEventsTableViewController.h
//  Pods
//
//  Created by Steven Preston on 7/28/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@interface SSCalendarEventsTableViewController : NSObject  <UITableViewDataSource, UITableViewDelegate,UISearchDisplayDelegate> {
    NSMutableArray *allEvents;
    NSMutableArray *normalEvents;
}

@property (nonatomic, copy) NSArray *events;
@property (nonatomic, weak) UITableView *tableView;

@property NSArray *calActivity;


- (id)initWithTableView:(UITableView *)tableView andDict:(NSDictionary*)dict;

//- (id)initWithTableView:(UITableView *)tableView;
@property NSDictionary *listAppointments;

@end
