//
//    GetOwnCalendarAttendee.h
//
//    Create by thabresh thabu on 27/7/2018
//    Copyright © 2018. All rights reserved.
//

//    Model file Generated using JSONExport: https://github.com/Ahmed-Ali/JSONExport

#import <UIKit/UIKit.h>

@interface GetOwnCalendarAttendee : NSObject

@property (nonatomic, strong) NSArray * companyIds;
@property (nonatomic, strong) NSArray * contactIds;
@property (nonatomic, strong) NSArray * userIds;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
