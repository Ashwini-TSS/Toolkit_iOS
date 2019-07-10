//
//  SSCalendarYearHeaderView.m
//  Pods
//
//  Created by Steven Preston on 7/23/13.
//  Copyright (c) 2013 Stellar16. All rights reserved.
//

#import "SSCalendarAnnualHeaderView.h"
#import "SSConstants.h"

@implementation SSCalendarAnnualHeaderView

- (void)awakeFromNib
{
    [super awakeFromNib];
    _label.textColor = [UIColor colorWithRed:10.0/255.0 green:64.0/255.0 blue:128.0/255.0 alpha:1.0];
    separatorView.backgroundColor = [UIColor colorWithHexString:COLOR_SEPARATOR];
    separatorViewHeightConstraint.constant = [SSDimensions onePixel];
}

@end
