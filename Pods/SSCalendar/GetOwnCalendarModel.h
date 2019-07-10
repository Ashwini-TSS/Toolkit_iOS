//
//    GetOwnCalendarModel.h
//
//    Create by thabresh thabu on 27/7/2018
//    Copyright © 2018. All rights reserved.
//

//    Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>
#import "GetOwnCalendarActivity.h"

@interface GetOwnCalendarModel : NSObject

@property (nonatomic, strong) NSArray * activities;
@property (nonatomic, strong) NSString * responseMessage;
@property (nonatomic, assign) BOOL valid;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
