/*!
 @file		TPWeatherRequest.m
 @brief		TPWeatherRequest is an internal object designed to cache the URL request
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */
#import "TPWeatherRequest.h"

@implementation TPWeatherRequest
@synthesize city = _city, type = _type, resultData = _resultData;

+ (TPWeatherRequest *)currentWeatherForCity:(TPCity *)city
{
    return [[[TPWeatherRequest alloc] initWithCity:city requestType:kTPWeatherRequestCurrentWeather] autorelease];
}

+ (TPWeatherRequest *)futureWeatherForCity:(TPCity *)city
{
    return [[[TPWeatherRequest alloc] initWithCity:city requestType:kTPWeatherRequestFutureWeather] autorelease];
}

+ (TPWeatherRequest *)airQualityForCity:(TPCity *)city
{
   return [[[TPWeatherRequest alloc] initWithCity:city requestType:kTPWeatherRequestAirQuality] autorelease];
}

+ (TPWeatherRequest *)suggestionsForCity:(TPCity *)city
{
   return [[[TPWeatherRequest alloc] initWithCity:city requestType:kTPWeatherRequestSuggestions] autorelease];
}

+ (TPWeatherRequest *)allForCity:(TPCity *)city
{
   return [[[TPWeatherRequest alloc] initWithCity:city requestType:kTPWeatherRequestAllForCity] autorelease];
}

- (id)initWithCity:(TPCity *)city requestType:(TPWeatherRequestType) type
{
    if (self = [super init])
    {
        _city = [city retain];
        _type = type;
        _resultData = [[NSMutableData alloc] init];
    }
    return self;
}

- (void)dealloc
{
    [_city release];
    [_resultData release];
    [super dealloc];
}


- (BOOL) isEqualToRequest:(TPWeatherRequest *)request
{
    return ([self.city isEqualToCity:request.city] && (self.type == request.type));
}
@end
