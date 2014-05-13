/*!
 @file		TPWeatherFuture.h
 @brief		TPWeatherFuture, weather forecast information
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface TPWeatherFuture : NSObject
/*!
 *
 * The general description of the weather (sunny, cloudy, rainning, etc.)
 **/
@property (nonatomic, retain) NSString *text;

/*!
 *
 * The weather code corresponding to text
 **/
@property (nonatomic, retain) NSString *code1;

/*!
 *
 * The weather code corresponding to text
 **/
@property (nonatomic, retain) NSString *code2;

/*!
 *
 * What day is it
 **/
@property (nonatomic, retain) NSString *day;

/*!
 *
 * What date is it
 **/
@property (nonatomic, retain) NSDate *date;

/*!
 *
 * The high and low temperature of the day
 **/
@property (nonatomic, assign) NSInteger temperatureHigh;
@property (nonatomic, assign) NSInteger temperatureLow;

/*!
 *
 * Chance of Precipitation
 **/
@property (nonatomic, retain) NSString *chanceOfPrecipitation;

/*!
 *
 * The wind forecast description
 **/
@property (nonatomic, retain) NSString *wind;
@end
