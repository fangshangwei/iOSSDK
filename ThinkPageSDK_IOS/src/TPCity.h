/*!
 @file		TPCity.h
 @brief		TPCity, represents a city
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */


#import <Foundation/Foundation.h>
#import "CoreLocation/CLLocation.h"

@interface TPCity : NSObject
@property (nonatomic, retain) NSString *name;
@property (nonatomic, retain) NSString *cityid;
@property (nonatomic, retain) CLLocation *location;
@property (nonatomic, retain) NSString *ipAddress;

+ (TPCity *)cityWithName:(NSString *)name;
+ (TPCity *)cityWithID:(NSString *)cityid;
+ (TPCity *)cityWithName:(NSString *)name cityid:(NSString *)cityid;
+ (TPCity *)cityWithLocation:(CLLocation *)location;
- (id)initWithName:(NSString*)name;
- (BOOL)isEqualToCity:(TPCity *)city;
- (NSString *)description;
@end
