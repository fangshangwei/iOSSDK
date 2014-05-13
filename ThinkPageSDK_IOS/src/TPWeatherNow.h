/*!
 @file		TPWeatherNow.h
 @brief		TPWeatherNow, current weather information
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class TPAirQuality;

@interface TPWeatherNow : NSObject
/*!
 *
 * The general description of the weather (sunny, cloudy, rainning, etc.)
 **/
@property (nonatomic, retain) NSString *text;

/*!
 *
 * The weather code corresponding to description
 **/
@property (nonatomic, retain) NSString *code;

/*!
 *
 * The temperature/feel like temperature of now
 **/
@property (nonatomic, assign) NSInteger temperature;
@property (nonatomic, assign) NSInteger feelsLikeTemperature;

/*!
 *
 * The wind direction/speed/scale
 **/
@property (nonatomic, retain) NSString *windDirection;
@property (nonatomic, assign) double windSpeed;
@property (nonatomic, assign) double windScale;

/*!
 *
 * The humidity, visibility of now
 **/
@property (nonatomic, assign) double humidity;
@property (nonatomic, assign) double visibility;

/*!
 *
 * The air pressure and pressure rising of now
 **/
@property (nonatomic, assign) double pressure;
@property (nonatomic, retain) NSString *pressureRising;
@end
