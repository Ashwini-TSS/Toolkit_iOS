//
//  MonthListAppointmentCell.h
//  SSCalendar
//
//  Created by Test Technologies PVT LTD on 27/07/18.
//

#import <UIKit/UIKit.h>

@interface MonthListAppointmentCell : UITableViewCell
@property (nonatomic, strong) IBOutlet UILabel *lblFromTime;
@property (nonatomic, strong) IBOutlet UILabel *lblToTime;
@property (nonatomic, strong) IBOutlet UILabel *lblSubject;
@property (nonatomic, strong) IBOutlet UILabel *lblDesc;
@end
