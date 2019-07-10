//
//  SSCalendarEventTableCell.h
//  Pods
//
//  Created by Steven Preston on 7/28/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

@class SSEvent;
@interface SSCalendarEventTableViewCell : UITableViewCell
{
    IBOutlet UILabel *timeLabel;
    IBOutlet UILabel *toLabel;

    IBOutlet UILabel *nameLabel;
    IBOutlet UILabel *descriptionLabel;
    IBOutlet UILabel *locationLabel;
}

@property (weak, nonatomic) IBOutlet UILabel *lblEventTitle;
@property (nonatomic, strong) SSEvent *event;

+ (CGFloat)heightForEvent:(SSEvent *)event forWidth:(CGFloat)width;
- (id)initWithReuseIdentifier:(NSString *)reuseIdentifier;
@property (weak, nonatomic) IBOutlet UIView *allDayBG;

@property (weak, nonatomic) IBOutlet UILabel *fromTime;
@property (weak, nonatomic) IBOutlet UILabel *toTime;
@property (weak, nonatomic) IBOutlet UILabel *lblTitle;
@property (weak, nonatomic) IBOutlet UILabel *lblDesc;
@end
