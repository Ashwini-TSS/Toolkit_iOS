//
//    GetOwnCalendarModel.m
//
//    Create by thabresh thabu on 27/7/2018
//    Copyright © 2018. All rights reserved.



#import "GetOwnCalendarModel.h"

NSString *const kGetOwnCalendarModelActivities = @"Activities";
NSString *const kGetOwnCalendarModelResponseMessage = @"ResponseMessage";
NSString *const kGetOwnCalendarModelValid = @"Valid";

@interface GetOwnCalendarModel ()
@end
@implementation GetOwnCalendarModel




/**
 * Instantiate the instance using the passed dictionary values to set the properties values
 */

-(instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    self = [super init];
    if(dictionary[kGetOwnCalendarModelActivities] != nil && [dictionary[kGetOwnCalendarModelActivities] isKindOfClass:[NSArray class]]){
        NSArray * activitiesDictionaries = dictionary[kGetOwnCalendarModelActivities];
        NSMutableArray * activitiesItems = [NSMutableArray array];
        for(NSDictionary * activitiesDictionary in activitiesDictionaries){
            GetOwnCalendarActivity * activitiesItem = [[GetOwnCalendarActivity alloc] initWithDictionary:activitiesDictionary];
            [activitiesItems addObject:activitiesItem];
        }
        self.activities = activitiesItems;
    }
    if(![dictionary[kGetOwnCalendarModelResponseMessage] isKindOfClass:[NSNull class]]){
        self.responseMessage = dictionary[kGetOwnCalendarModelResponseMessage];
    }
    if(![dictionary[kGetOwnCalendarModelValid] isKindOfClass:[NSNull class]]){
        self.valid = [dictionary[kGetOwnCalendarModelValid] boolValue];
    }
    
    return self;
}


/**
 * Returns all the available property values in the form of NSDictionary object where the key is the approperiate json key and the value is the value of the corresponding property
 */
-(NSDictionary *)toDictionary
{
    NSMutableDictionary * dictionary = [NSMutableDictionary dictionary];
    if(self.activities != nil){
        NSMutableArray * dictionaryElements = [NSMutableArray array];
        for(GetOwnCalendarActivity * activitiesElement in self.activities){
            [dictionaryElements addObject:[activitiesElement toDictionary]];
        }
        dictionary[kGetOwnCalendarModelActivities] = dictionaryElements;
    }
    if(self.responseMessage != nil){
        dictionary[kGetOwnCalendarModelResponseMessage] = self.responseMessage;
    }
    dictionary[kGetOwnCalendarModelValid] = @(self.valid);
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
    if(self.activities != nil){
        [aCoder encodeObject:self.activities forKey:kGetOwnCalendarModelActivities];
    }
    if(self.responseMessage != nil){
        [aCoder encodeObject:self.responseMessage forKey:kGetOwnCalendarModelResponseMessage];
    }
    [aCoder encodeObject:@(self.valid) forKey:kGetOwnCalendarModelValid];
}

/**
 * Implementation of NSCoding initWithCoder: method
 */
- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    self.activities = [aDecoder decodeObjectForKey:kGetOwnCalendarModelActivities];
    self.responseMessage = [aDecoder decodeObjectForKey:kGetOwnCalendarModelResponseMessage];
    self.valid = [[aDecoder decodeObjectForKey:kGetOwnCalendarModelValid] boolValue];
    return self;
    
}

/**
 * Implementation of NSCopying copyWithZone: method
 */
- (instancetype)copyWithZone:(NSZone *)zone
{
    GetOwnCalendarModel *copy = [GetOwnCalendarModel new];
    
    copy.activities = [self.activities copy];
    copy.responseMessage = [self.responseMessage copy];
    copy.valid = self.valid;
    
    return copy;
}
@end
