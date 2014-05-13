/*!
 @file		TPWeatherNow.m
 @brief		TPWeatherNow
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */
#import "TPWeatherNow.h"

@implementation TPWeatherNow
- (NSString *)description
{
	return [NSString stringWithFormat:@"Weather:%@, code:%@, temperature:%ld, feel like temperature:%ld, wind direction:%@, wind speed:%f, wind scale:%f, humidity: %f, visibility: %f, air pressure:%f, pressure rising :%@", self.text, self.code, (long)self.temperature, (long)self.feelsLikeTemperature, self.windDirection, self.windSpeed, self.windScale, self.humidity, self.visibility, self.pressure, self.pressureRising];
}
@end
