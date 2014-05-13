/*!
 @file		TPCity.m
 @brief		TPCity
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */
#import "TPCity.h"

@interface TPCity(Private)
@end

@implementation TPCity
+(TPCity *)cityWithLocation:(CLLocation *)location
{
    TPCity *city = [[[TPCity alloc] initWithLocation:location] autorelease];
    return city;
}

+ (TPCity *)cityWithName:(NSString*)name
{
    return [TPCity cityWithName:name cityid:nil];
}

+ (TPCity *)cityWithName:(NSString*) name cityid:(NSString *)cityid
{
    TPCity *city = [[[TPCity alloc] initWithName:name] autorelease];
    city.cityid = cityid;
    return city;
}

+ (TPCity *)cityWithID:(NSString *)cityid
{
    return [TPCity cityWithName:nil cityid:cityid];
}

-(id)initWithName:(NSString*)name
{
    if(self = [super init])
    {
        _name = [name retain];
        _location = nil;
        _ipAddress = nil;
        _cityid = nil;
    }
    return self;
}

-(id)initWithLocation:(CLLocation*)location
{
    if(self = [super init])
    {
        self.name = nil;
        self.location = location;
        self.ipAddress = nil;
        self.cityid = nil;
    }
    return self;
}

-(id)initWithIPAddress:(NSString*)ipAddress
{
    if(self = [super init])
    {
        self.name = nil;
        self.location = nil;
        self.ipAddress = ipAddress;
        self.cityid = nil;
    }
    return self;
}

- (BOOL)isEqualToCity:(TPCity *)city
{
    if (self.location && [self.location distanceFromLocation:city.location] < 1000.0/* 1km */)
    {
        return YES;
    }
    
    if ([self.ipAddress isEqualToString:city.ipAddress])
    {
        return YES;
    }
    
    if ([self.name isEqualToString:city.name])
    {
        return YES;
    }
    
    return NO;
}

- (NSString *)description
{
    if (self.name != nil)
        return self.name;
    if (self.ipAddress != nil)
        return self.ipAddress;
    if (self.location != nil)
        return [NSString stringWithFormat:@"%f:%f", self.location.coordinate.latitude, self.location.coordinate.longitude];
    return nil;
}
@end
