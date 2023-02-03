//
//    GetOwnCalendarAttendee.m
//
//    Create by thabresh thabu on 27/7/2018
//    Copyright © 2018. All rights reserved.



#import "GetOwnCalendarAttendee.h"

NSString *const kGetOwnCalendarAttendeeCompanyIds = @"CompanyIds";
NSString *const kGetOwnCalendarAttendeeContactIds = @"ContactIds";
NSString *const kGetOwnCalendarAttendeeUserIds = @"UserIds";

@interface GetOwnCalendarAttendee ()
@end
@implementation GetOwnCalendarAttendee




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(![dictionary[kGetOwnCalendarAttendeeCompanyIds] isKindOfClass:[NSNull class]]){
        self.companyIds = dictionary[kGetOwnCalendarAttendeeCompanyIds];
    }
    if(![dictionary[kGetOwnCalendarAttendeeContactIds] isKindOfClass:[NSNull class]]){
        self.contactIds = dictionary[kGetOwnCalendarAttendeeContactIds];
    }
    if(![dictionary[kGetOwnCalendarAttendeeUserIds] isKindOfClass:[NSNull class]]){
        self.userIds = dictionary[kGetOwnCalendarAttendeeUserIds];
    }
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.companyIds != nil){
        dictionary[kGetOwnCalendarAttendeeCompanyIds] = self.companyIds;
    }
    if(self.contactIds != nil){
        dictionary[kGetOwnCalendarAttendeeContactIds] = self.contactIds;
    }
    if(self.userIds != nil){
        dictionary[kGetOwnCalendarAttendeeUserIds] = self.userIds;
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
    if(self.companyIds != nil){
        [aCoder encodeObject:self.companyIds forKey:kGetOwnCalendarAttendeeCompanyIds];
    }
    if(self.contactIds != nil){
        [aCoder encodeObject:self.contactIds forKey:kGetOwnCalendarAttendeeContactIds];
    }
    if(self.userIds != nil){
        [aCoder encodeObject:self.userIds forKey:kGetOwnCalendarAttendeeUserIds];
    }
    
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.companyIds = [aDecoder decodeObjectForKey:kGetOwnCalendarAttendeeCompanyIds];
    self.contactIds = [aDecoder decodeObjectForKey:kGetOwnCalendarAttendeeContactIds];
    self.userIds = [aDecoder decodeObjectForKey:kGetOwnCalendarAttendeeUserIds];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetOwnCalendarAttendee *copy = [GetOwnCalendarAttendee new];
    
    copy.companyIds = [self.companyIds copy];
    copy.contactIds = [self.contactIds copy];
    copy.userIds = [self.userIds copy];
    
    return copy;
}
@end
