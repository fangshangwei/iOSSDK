/*!
 @file		TPAirQuality.m
 @brief		TPAirQuality
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */
#import "TPAirQuality.h"

@implementation TPAirQuality
- (NSString *)description
{
	return [NSString stringWithFormat:@"Station Name %@, aqi:%f, pm2.5:%f, pm1.0:%f, so2:%f, no2:%f, co:%f, o3:%f, last update :%@", self.stationName, self.aqi, self.pm25, self.pm10, self.so2, self.no2, self.co, self.o3, self.lastUpdate];
}
@end
