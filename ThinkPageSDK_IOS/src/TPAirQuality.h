/*!
 @file		TPAirQuality.h
 @brief		TPAirQuality, air quality information
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface TPAirQuality : NSObject
@property (nonatomic, retain) NSString *stationName;
@property (nonatomic, assign) double aqi;
@property (nonatomic, assign) double pm25;
@property (nonatomic, assign) double pm10;
@property (nonatomic, assign) double so2;
@property (nonatomic, assign) double no2;
@property (nonatomic, assign) double co;
@property (nonatomic, assign) double o3;
@property (nonatomic, retain) NSString *quality;
@property (nonatomic, retain) NSDate *lastUpdate;
@end
