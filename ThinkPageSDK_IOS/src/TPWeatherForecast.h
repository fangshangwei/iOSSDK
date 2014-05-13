/*!
 @file		TPWeatherForecast.h
 @brief		The response we got from thinkpage server, include everything the server can give you
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import <Foundation/Foundation.h>
@class TPCity;
@class TPWeatherNow;
@class TPSuggestionsOfToday;

@interface TPWeatherForecast : NSObject
/*!
 *
 * Initializes a new TPWeatherForecast with the given json string from http://thinkpage.cn
 * @param jsonString the json response get from http://thinkpage.cn
 * @returns A TPWeatherForecast instance
 **/
- (id)initWithJSONString:(NSString *)jsonString;

/*!
 *
 * Is this a valid response from server
 * @returns whether this is a valid response from server, YES or NO
 **/
- (BOOL)isValid;

@property (nonatomic, retain) NSString *status;
@property (nonatomic, retain) TPCity *city;
@property (nonatomic, retain) NSDate *lastUpdate;
@property (nonatomic, retain) TPWeatherNow *weatherOfNow;
@property (nonatomic, retain) NSArray *airQualities;
@property (nonatomic, retain) TPSuggestionsOfToday *suggestionsOfToday;
@property (nonatomic, retain) NSArray *weatherOfFuture;
@property (nonatomic, retain) NSString *sunriseTimeOfToday;
@property (nonatomic, retain) NSString *sunsetTimeOfToday;
@end
