//
//  SSCalendarEventsTableViewController.m
//  Pods
//
//  Created by Steven Preston on 7/28/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarEventsTableViewController.h"
#import "SSCalendarEventTableViewCell.h"
#import "SSConstants.h"
#import "GetOwnCalendarActivity.h"
#import "SSEvent.h"
#import "AllDayEventCell.h"

@implementation SSCalendarEventsTableViewController

#pragma mark - Lifecycle Methods

- (id)initWithTableView:(UITableView *)tableView andDict:(NSDictionary*)dict
{
    self = [super init];
    if (self)
    {
        _listAppointments = dict;
        self.tableView = tableView;
        
//        NSBundle *podBundle = [NSBundle bundleForClass:[UIViewController class]];
//        id data = [podBundle URLForResource:@"SSCalendar" withExtension:@"bundle"];
//        NSBundle *bundle = [NSBundle bundleWithURL:data];
//
//        UINib *nib = [UINib nibWithNibName:@"AllDayEventCel" bundle:self];
//        [self.tableView registerNib:[UINib nibWithNibName:@"AllDayEventCel" bundle:nil] forCellReuseIdentifier:@"AllDayEventCel"];

    }
    return self;
}


#pragma mark - Setter Methods

- (void)setEvents:(NSArray *)events
{
    _events = [events copy];
    _tableView.scrollEnabled = _events.count > 0;
    allEvents = [NSMutableArray new];
    normalEvents = [NSMutableArray new];
    
    for (int i=0; i<_events.count; i++) {
        SSEvent *event = _events[i];
        if(event.isAllday == YES) {
            [allEvents addObject:event];
        }else{
            [normalEvents addObject:event];
        }
    }
    [_tableView reloadData];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
   if(_events.count > 0) {
       return 2;
   }
    return  1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(_events.count > 0) {
        if(section == 0) {
            return allEvents.count;
        }
        return normalEvents.count;
    }
   
    return _events.count == 0 ? 1 : _events.count;
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_events.count > 0)
    {
        if(indexPath.section == 0) {
            if(allEvents.count > 0){
            return 44;
            }
            return 0;
        }
        return [SSCalendarEventTableViewCell heightForEvent:[_events objectAtIndex:indexPath.row] forWidth:tableView.frame.size.width];
    }
    else
    {
        return LOADING_TABLE_VIEW_CELL_HEIGHT;
    }
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (_events.count == 0)
    {
        static NSString *LoadingCellIdentifier = @"LoadingCell";
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:LoadingCellIdentifier];
        if (cell == nil)
        {
            cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:LoadingCellIdentifier];
            cell.textLabel.backgroundColor = [UIColor whiteColor];
            cell.textLabel.textAlignment = NSTextAlignmentCenter;
            cell.textLabel.textColor = [UIColor colorWithHexString:COLOR_TEXT_DARK];
            cell.textLabel.font = [UIFont systemFontOfSize:15.0f];
            cell.textLabel.text = @"No Events";
        }
        return cell;
    }
    else
    {
        if(indexPath.section == 0) {
            static NSString *EventCellIdentifier = @"EventCell";

            SSCalendarEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EventCellIdentifier];
            if (cell == nil)
            {
                cell = [[SSCalendarEventTableViewCell alloc] initWithReuseIdentifier:EventCellIdentifier];
            }
            SSEvent *ent = [allEvents objectAtIndex:indexPath.row];
            cell.event = ent;

//            SSEvent *ent = [_events objectAtIndex:indexPath.row];
            return cell;

        }
        static NSString *EventCellIdentifier = @"EventCell";
        
        SSCalendarEventTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:EventCellIdentifier];
        if (cell == nil)
        {
            cell = [[SSCalendarEventTableViewCell alloc] initWithReuseIdentifier:EventCellIdentifier];
        }
        SSEvent *ent = [normalEvents objectAtIndex:indexPath.row];
        cell.event = ent;

//        if(indexPath.section == 0) {
//            SSEvent *ent = [allEvents objectAtIndex:indexPath.row];
//
//            [cell.allDayBG setHidden:NO];
//            cell.lblEventTitle.text = ent.name;
//
//            NSString *getStr = ent.startTime;
//
//            NSArray *sep = [getStr componentsSeparatedByString:@"!@#"];
//
//            if (sep.count > 0 ){
//                if (sep.count > 2) {
//                    cell.lblEventTitle.backgroundColor = [UIColor colorWithHexString:[NSString stringWithFormat:@"#%@",sep[2]]];
//                }
//            }
//
//        }else{
//            SSEvent *ent = [_events objectAtIndex:indexPath.row];
//            [cell.allDayBG setHidden:YES];
//            cell.event = ent;
//        }
        return cell;
    }
   


}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
//    strconditio
    
    if([[NSUserDefaults standardUserDefaults]objectForKey:@"userSelectedModel"]){
        
        [[NSUserDefaults standardUserDefaults]setObject:@"yes" forKey:@"nowSelected"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
         GetOwnCalendarModel *model = [NSKeyedUnarchiver unarchiveObjectWithData:[[NSUserDefaults standardUserDefaults]objectForKey:@"userSelectedModel"]];
         
         _calActivity = model.activities;
        SSEvent *event = _events[indexPath.row];

        if(indexPath.section == 0) {
            event = allEvents[indexPath.row];
        }else{
            event = normalEvents[indexPath.row];
        }
//        SSEvent *event = _events[indexPath.row];
        [[NSUserDefaults standardUserDefaults]setObject:event.startDate forKey:@"eventStartDate"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        NSLog(@"AppointmentTypeID : %@",event.contact);

        [[NSUserDefaults standardUserDefaults]setObject:event.contact forKey:@"appointmentTypeID"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        for (int k=0; k<_calActivity.count; k++) {
            GetOwnCalendarActivity *model = _calActivity[k];
            NSString *strType = [NSString stringWithFormat:@"%@",model.type];

            if ([model.activity.idField isEqualToString:event.location]) {
                
                if ([strType isEqualToString:@"Task"]) {
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"pushToActivity"
                     object:model.toDictionary];
                }else{
                    if(event.isAllday){
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"Allday"
                     object:@"true"];
                    }
                    [[NSNotificationCenter defaultCenter]
                     postNotificationName:@"pushToActivity1"
                     object:model.toDictionary];
                   
                }
            }
        }
    }
    
}
@end
