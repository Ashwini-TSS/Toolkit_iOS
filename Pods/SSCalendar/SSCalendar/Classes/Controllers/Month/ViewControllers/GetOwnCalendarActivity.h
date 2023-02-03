//
//    GetOwnCalendarActivity.h
//
//    Create by thabresh thabu on 27/7/2018
//    Copyright © 2018. All rights reserved.
//


#import <UIKit/UIKit.h>
#import "GetOwnCalendarModel.h"
#import "GetOwnCalendarAttendee.h"

@interface GetOwnCalendarActivity : NSObject

@property (nonatomic, strong) GetOwnCalendarActivity * getOwnCalendarActivity;
//@property (nonatomic, strong) GetOwnCalendarModel * getOwnCalendarModel;
@property (nonatomic, strong) GetOwnCalendarActivity * activity;
@property (nonatomic, strong) GetOwnCalendarAttendee * attendees;
@property (nonatomic, strong) NSArray * type;

@property (nonatomic, assign) NSInteger advocateProcessIndex;
@property (nonatomic, strong) NSObject * appliedAdvocateProcessId;
@property (nonatomic, strong) NSString * createdBy;
@property (nonatomic, strong) NSString * createdOn;
@property (nonatomic, strong) NSString * descriptionField;
@property (nonatomic, strong) NSString * dueTime;
@property (nonatomic, strong) NSString * idField;
@property (nonatomic, strong) NSString * location;
@property (nonatomic, strong) NSString * modifiedBy;
@property (nonatomic, strong) NSString * modifiedOn;
@property (nonatomic, assign) NSInteger percentComplete;
@property (nonatomic, strong) NSString * priority;
@property (nonatomic, assign) NSInteger recurrenceIndex;
@property (nonatomic, strong) NSObject * recurringActivityId;
@property (nonatomic, assign) BOOL rollOver;
@property (nonatomic, assign) BOOL Complete;
@property (nonatomic, assign) BOOL AllDay;

@property (nonatomic, strong) NSString * startTime;
@property (nonatomic, strong) NSString * status;
@property (nonatomic, strong) NSString * subject;
@property (nonatomic, strong) NSString * endTime;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

-(NSDictionary *)toDictionary;
@end
