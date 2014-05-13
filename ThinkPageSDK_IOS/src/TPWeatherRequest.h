/*!
 @file		TPWeatherRequest.h
 @brief		TPWeatherRequest is an internal object designed to cache the URL request
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "TPCity.h"

typedef enum _tpWeatherRequestType
{
    kTPWeatherRequestCurrentWeather,
    kTPWeatherRequestFutureWeather,
    kTPWeatherRequestAirQuality,
    kTPWeatherRequestSuggestions,
    kTPWeatherRequestAllForCity
}TPWeatherRequestType;

@interface TPWeatherRequest : NSObject
@property (nonatomic, assign) TPWeatherRequestType type;
@property (nonatomic, retain) TPCity *city;
@property (nonatomic, retain) NSMutableData *resultData;

- (BOOL) isEqualToRequest:(TPWeatherRequest *)request;
+ (TPWeatherRequest *)currentWeatherForCity:(TPCity *)city;
+ (TPWeatherRequest *)futureWeatherForCity:(TPCity *)city;
+ (TPWeatherRequest *)airQualityForCity:(TPCity *)city;
+ (TPWeatherRequest *)suggestionsForCity:(TPCity *)city;
+ (TPWeatherRequest *)allForCity:(TPCity *)city;
@end
