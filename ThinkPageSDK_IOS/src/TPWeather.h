/*!
 @file		TPWeather.h
 @brief		The response we got from ThinkPage server, include everything the server can give you
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import <Foundation/Foundation.h>
@class TPCity;
@class TPWeatherNow;
@class TPWeatherSuggestions;

@interface TPWeather : NSObject
/*!
 *
 * Initializes a new TPWeather with the given json string from https://api.thinkpage.cn
 * @param jsonString the json response get from https://api.thinkpage.cn
 * @returns A TPWeather instance
 **/
- (id)initWithJSONString:(NSString *)jsonString;

/*!
 *
 * Is this a valid response from server
 * @returns whether this is a valid response from server, YES or NO
 **/
- (BOOL)isValid;

@property (nonatomic, retain) NSString *status;

/*!
 the city this weather report belongs to
  **/
@property (nonatomic, retain) TPCity *city;

/*!
 the last update date/time of this weather report
 **/
@property (nonatomic, retain) NSDate *lastUpdate;

/*!
 current weather informationt
 **/
@property (nonatomic, retain) TPWeatherNow *currentWeather;

/*!
 air quality information. TPAirQuality in the NSArray
 **/
@property (nonatomic, retain) NSArray *airQualities;

/*!
 weather suggestions
 **/
@property (nonatomic, retain) TPWeatherSuggestions *weatherSuggestions;

/*!
 future weather information, TPWeatherFuture in the NSArray
 **/
@property (nonatomic, retain) NSArray *futureWeathers;

@property (nonatomic, retain) NSString *sunriseTimeOfToday;
@property (nonatomic, retain) NSString *sunsetTimeOfToday;
@end
