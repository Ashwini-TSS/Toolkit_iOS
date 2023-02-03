//
//    GetOwnCalendarActivity.m
//
//    Create by thabresh thabu on 27/7/2018
//    Copyright © 2018. All rights reserved.



#import "GetOwnCalendarActivity.h"

NSString *const kGetOwnCalendarActivityAdvocateProcessIndex = @"AdvocateProcessIndex";
NSString *const kGetOwnCalendarActivityAppliedAdvocateProcessId = @"AppliedAdvocateProcessId";
NSString *const kGetOwnCalendarActivityCreatedBy = @"CreatedBy";
NSString *const kGetOwnCalendarActivityCreatedOn = @"CreatedOn";
NSString *const kGetOwnCalendarActivityDescriptionField = @"Description";
NSString *const kGetOwnCalendarActivityDueTime = @"DueTime";
NSString *const kGetOwnCalendarActivityIdField = @"Id";
NSString *const kGetOwnCalendarActivityLocation = @"Location";
NSString *const kGetOwnCalendarActivityModifiedBy = @"ModifiedBy";
NSString *const kGetOwnCalendarActivityModifiedOn = @"ModifiedOn";
NSString *const kGetOwnCalendarActivityPercentComplete = @"PercentComplete";
NSString *const kGetOwnCalendarActivityPriority = @"Priority";
NSString *const kGetOwnCalendarActivityRecurrenceIndex = @"RecurrenceIndex";
NSString *const kGetOwnCalendarActivityRecurringActivityId = @"RecurringActivityId";
NSString *const kGetOwnCalendarActivityRollOver = @"RollOver";
NSString *const kGetOwnCalendarActivityStartTime = @"StartTime";
NSString *const kGetOwnCalendarActivityStatus = @"Status";
NSString *const kGetOwnCalendarActivitySubject = @"Subject";
NSString *const kGetOwnCalendarActivityActivity = @"Activity";
NSString *const kGetOwnCalendarActivityAttendees = @"Attendees";
NSString *const kGetOwnCalendarActivityType = @"Type";
NSString *const kGetOwnCalendarActivityEndTime = @"EndTime";
NSString *const kGetOwnCalendarActivityAllDay = @"AllDay";
NSString *const kGetOwnCalendarActivityComplete = @"Complete";

@interface GetOwnCalendarActivity ()
@end
@implementation GetOwnCalendarActivity




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kGetOwnCalendarActivityAdvocateProcessIndex] isKindOfClass:[NSNull class]]){
        self.advocateProcessIndex = [dictionary[kGetOwnCalendarActivityAdvocateProcessIndex] integerValue];
    }
    
    if(![dictionary[kGetOwnCalendarActivityAppliedAdvocateProcessId] isKindOfClass:[NSNull class]]){
        self.appliedAdvocateProcessId = dictionary[kGetOwnCalendarActivityAppliedAdvocateProcessId];
    }
    if(![dictionary[kGetOwnCalendarActivityCreatedBy] isKindOfClass:[NSNull class]]){
        self.createdBy = dictionary[kGetOwnCalendarActivityCreatedBy];
    }
    if(![dictionary[kGetOwnCalendarActivityCreatedOn] isKindOfClass:[NSNull class]]){
        self.createdOn = dictionary[kGetOwnCalendarActivityCreatedOn];
    }
    if(![dictionary[kGetOwnCalendarActivityDescriptionField] isKindOfClass:[NSNull class]]){
        self.descriptionField = dictionary[kGetOwnCalendarActivityDescriptionField];
    }
    if(![dictionary[kGetOwnCalendarActivityEndTime] isKindOfClass:[NSNull class]]){
        self.endTime = dictionary[kGetOwnCalendarActivityEndTime];
    }
    if(![dictionary[kGetOwnCalendarActivityDueTime] isKindOfClass:[NSNull class]]){
        self.dueTime = dictionary[kGetOwnCalendarActivityDueTime];
    }
    if(![dictionary[kGetOwnCalendarActivityIdField] isKindOfClass:[NSNull class]]){
        self.idField = dictionary[kGetOwnCalendarActivityIdField];
    }
    if(![dictionary[kGetOwnCalendarActivityLocation] isKindOfClass:[NSNull class]]){
        self.location = dictionary[kGetOwnCalendarActivityLocation];
    }
    if(![dictionary[kGetOwnCalendarActivityModifiedBy] isKindOfClass:[NSNull class]]){
        self.modifiedBy = dictionary[kGetOwnCalendarActivityModifiedBy];
    }
    if(![dictionary[kGetOwnCalendarActivityModifiedOn] isKindOfClass:[NSNull class]]){
        self.modifiedOn = dictionary[kGetOwnCalendarActivityModifiedOn];
    }
    if(![dictionary[kGetOwnCalendarActivityPercentComplete] isKindOfClass:[NSNull class]]){
        self.percentComplete = [dictionary[kGetOwnCalendarActivityPercentComplete] integerValue];
    }
    
    if(![dictionary[kGetOwnCalendarActivityPriority] isKindOfClass:[NSNull class]]){
        self.priority = dictionary[kGetOwnCalendarActivityPriority];
    }
    if(![dictionary[kGetOwnCalendarActivityRecurrenceIndex] isKindOfClass:[NSNull class]]){
        self.recurrenceIndex = [dictionary[kGetOwnCalendarActivityRecurrenceIndex] integerValue];
    }
    
    if(![dictionary[kGetOwnCalendarActivityRecurringActivityId] isKindOfClass:[NSNull class]]){
        self.recurringActivityId = dictionary[kGetOwnCalendarActivityRecurringActivityId];
    }
    if(![dictionary[kGetOwnCalendarActivityRollOver] isKindOfClass:[NSNull class]]){
        self.rollOver = [dictionary[kGetOwnCalendarActivityRollOver] boolValue];
    }
    
    if(![dictionary[kGetOwnCalendarActivityStartTime] isKindOfClass:[NSNull class]]){
        self.startTime = dictionary[kGetOwnCalendarActivityStartTime];
    }
    if(![dictionary[kGetOwnCalendarActivityStatus] isKindOfClass:[NSNull class]]){
        self.status = dictionary[kGetOwnCalendarActivityStatus];
    }
    if(![dictionary[kGetOwnCalendarActivitySubject] isKindOfClass:[NSNull class]]){
        self.subject = dictionary[kGetOwnCalendarActivitySubject];
    }
//    if let activityData = dictionary["Activity"] as? [String:Any]{
//        activity = GetCalendarListActivity(fromDictionary: activityData)
//    }
    
    if(![dictionary[kGetOwnCalendarActivityActivity] isKindOfClass:[NSNull class]]){
        if (dictionary) {
               self.activity = [[GetOwnCalendarActivity alloc] initWithDictionary:dictionary[kGetOwnCalendarActivityActivity]];
        }
     
    }
    
    if(![dictionary[kGetOwnCalendarActivityAttendees] isKindOfClass:[NSNull class]]){
        self.attendees = [[GetOwnCalendarAttendee alloc] initWithDictionary:dictionary[kGetOwnCalendarActivityAttendees]];
    }
    
    if(![dictionary[kGetOwnCalendarActivityType] isKindOfClass:[NSNull class]]){
        self.type = dictionary[kGetOwnCalendarActivityType];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    dictionary[kGetOwnCalendarActivityAdvocateProcessIndex] = @(self.advocateProcessIndex);
    if(self.appliedAdvocateProcessId != nil){
        dictionary[kGetOwnCalendarActivityAppliedAdvocateProcessId] = self.appliedAdvocateProcessId;
    }
    if(self.createdBy != nil){
        dictionary[kGetOwnCalendarActivityCreatedBy] = self.createdBy;
    }
    if(self.createdOn != nil){
        dictionary[kGetOwnCalendarActivityCreatedOn] = self.createdOn;
    }
    if(self.descriptionField != nil){
        dictionary[kGetOwnCalendarActivityDescriptionField] = self.descriptionField;
    }
    if(self.endTime != nil){
        dictionary[kGetOwnCalendarActivityEndTime] = self.endTime;
    }
    if(self.dueTime != nil){
        dictionary[kGetOwnCalendarActivityDueTime] = self.dueTime;
    }
    if(self.idField != nil){
        dictionary[kGetOwnCalendarActivityIdField] = self.idField;
    }
    if(self.location != nil){
        dictionary[kGetOwnCalendarActivityLocation] = self.location;
    }
    if(self.modifiedBy != nil){
        dictionary[kGetOwnCalendarActivityModifiedBy] = self.modifiedBy;
    }
    if(self.modifiedOn != nil){
        dictionary[kGetOwnCalendarActivityModifiedOn] = self.modifiedOn;
    }
    dictionary[kGetOwnCalendarActivityPercentComplete] = @(self.percentComplete);
    if(self.priority != nil){
        dictionary[kGetOwnCalendarActivityPriority] = self.priority;
    }
    dictionary[kGetOwnCalendarActivityRecurrenceIndex] = @(self.recurrenceIndex);
    if(self.recurringActivityId != nil){
        dictionary[kGetOwnCalendarActivityRecurringActivityId] = self.recurringActivityId;
    }
    dictionary[kGetOwnCalendarActivityAllDay] = @(self.AllDay);
    dictionary[kGetOwnCalendarActivityComplete] = @(self.Complete);

    dictionary[kGetOwnCalendarActivityRollOver] = @(self.rollOver);
    if(self.startTime != nil){
        NSLog(@"%@",self.startTime);
        
        dictionary[kGetOwnCalendarActivityStartTime] = self.startTime;
    }
    if(self.status != nil){
        dictionary[kGetOwnCalendarActivityStatus] = self.status;
    }
    if(self.subject != nil){
        dictionary[kGetOwnCalendarActivitySubject] = self.subject;
    }
    if(self.activity != nil){
        dictionary[kGetOwnCalendarActivityActivity] = [self.activity toDictionary];
    }
    if(self.attendees != nil){
        dictionary[kGetOwnCalendarActivityAttendees] = [self.attendees toDictionary];
    }
    if(self.type != nil){
        dictionary[kGetOwnCalendarActivityType] = self.type;
    }
    return dictionary;
    
}

/**
 * Implementation of NSCoding encoding method
 */
/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeObject:@(self.advocateProcessIndex) forKey:kGetOwnCalendarActivityAdvocateProcessIndex];    if(self.appliedAdvocateProcessId != nil){
        [aCoder encodeObject:self.appliedAdvocateProcessId forKey:kGetOwnCalendarActivityAppliedAdvocateProcessId];
    }
    if(self.createdBy != nil){
        [aCoder encodeObject:self.createdBy forKey:kGetOwnCalendarActivityCreatedBy];
    }
    if(self.createdOn != nil){
        [aCoder encodeObject:self.createdOn forKey:kGetOwnCalendarActivityCreatedOn];
    }
    if(self.descriptionField != nil){
        [aCoder encodeObject:self.descriptionField forKey:kGetOwnCalendarActivityDescriptionField];
    }
    if(self.endTime != nil){
        [aCoder encodeObject:self.endTime forKey:kGetOwnCalendarActivityEndTime];
    }
    if(self.dueTime != nil){
        [aCoder encodeObject:self.dueTime forKey:kGetOwnCalendarActivityDueTime];
    }
    if(self.idField != nil){
        [aCoder encodeObject:self.idField forKey:kGetOwnCalendarActivityIdField];
    }
    if(self.location != nil){
        [aCoder encodeObject:self.location forKey:kGetOwnCalendarActivityLocation];
    }
    if(self.modifiedBy != nil){
        [aCoder encodeObject:self.modifiedBy forKey:kGetOwnCalendarActivityModifiedBy];
    }
    if(self.modifiedOn != nil){
        [aCoder encodeObject:self.modifiedOn forKey:kGetOwnCalendarActivityModifiedOn];
    }
    [aCoder encodeObject:@(self.percentComplete) forKey:kGetOwnCalendarActivityPercentComplete];    if(self.priority != nil){
        [aCoder encodeObject:self.priority forKey:kGetOwnCalendarActivityPriority];
    }
    [aCoder encodeObject:@(self.recurrenceIndex) forKey:kGetOwnCalendarActivityRecurrenceIndex];    if(self.recurringActivityId != nil){
        [aCoder encodeObject:self.recurringActivityId forKey:kGetOwnCalendarActivityRecurringActivityId];
    }
    [aCoder encodeObject:@(self.rollOver) forKey:kGetOwnCalendarActivityRollOver];    if(self.startTime != nil){
        [aCoder encodeObject:self.startTime forKey:kGetOwnCalendarActivityStartTime];
    }
    if(self.status != nil){
        [aCoder encodeObject:self.status forKey:kGetOwnCalendarActivityStatus];
    }
    if(self.subject != nil){
        [aCoder encodeObject:self.subject forKey:kGetOwnCalendarActivitySubject];
    }
    if(self.activity != nil){
        [aCoder encodeObject:self.activity forKey:kGetOwnCalendarActivityActivity];
    }
    if(self.attendees != nil){
        [aCoder encodeObject:self.attendees forKey:kGetOwnCalendarActivityAttendees];
    }
    if(self.type != nil){
        [aCoder encodeObject:self.type forKey:kGetOwnCalendarActivityType];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.advocateProcessIndex = [[aDecoder decodeObjectForKey:kGetOwnCalendarActivityAdvocateProcessIndex] integerValue];
    self.appliedAdvocateProcessId = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityAppliedAdvocateProcessId];
    self.createdBy = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityCreatedBy];
    self.createdOn = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityCreatedOn];
    self.descriptionField = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityDescriptionField];
    self.dueTime = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityDueTime];
    self.endTime = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityEndTime];

    self.idField = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityIdField];
    self.location = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityLocation];
    self.modifiedBy = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityModifiedBy];
    self.modifiedOn = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityModifiedOn];
    self.percentComplete = [[aDecoder decodeObjectForKey:kGetOwnCalendarActivityPercentComplete] integerValue];
    self.priority = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityPriority];
    self.recurrenceIndex = [[aDecoder decodeObjectForKey:kGetOwnCalendarActivityRecurrenceIndex] integerValue];
    self.recurringActivityId = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityRecurringActivityId];
    self.rollOver = [[aDecoder decodeObjectForKey:kGetOwnCalendarActivityRollOver] boolValue];
    self.startTime = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityStartTime];
    self.status = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityStatus];
    self.subject = [aDecoder decodeObjectForKey:kGetOwnCalendarActivitySubject];
    self.activity = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityActivity];
    self.attendees = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityAttendees];
    self.type = [aDecoder decodeObjectForKey:kGetOwnCalendarActivityType];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetOwnCalendarActivity *copy = [GetOwnCalendarActivity new];
    
    copy.advocateProcessIndex = self.advocateProcessIndex;
    copy.appliedAdvocateProcessId = [self.appliedAdvocateProcessId copy];
    copy.createdBy = [self.createdBy copy];
    copy.createdOn = [self.createdOn copy];
    copy.descriptionField = [self.descriptionField copy];
    copy.dueTime = [self.dueTime copy];
    copy.idField = [self.idField copy];
    copy.location = [self.location copy];
    copy.modifiedBy = [self.modifiedBy copy];
    copy.modifiedOn = [self.modifiedOn copy];
    copy.percentComplete = self.percentComplete;
    copy.priority = [self.priority copy];
    copy.recurrenceIndex = self.recurrenceIndex;
    copy.recurringActivityId = [self.recurringActivityId copy];
    copy.rollOver = self.rollOver;
    copy.startTime = [self.startTime copy];
    copy.status = [self.status copy];
    copy.subject = [self.subject copy];
    copy.activity = [self.activity copy];
    copy.attendees = [self.attendees copy];
    copy.type = [self.type copy];
    
    return copy;
}
@end
