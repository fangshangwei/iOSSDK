/*!
 @file		TPWeatherFuture.m
 @brief		TPWeatherFuture
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import "TPWeatherFuture.h"

@implementation TPWeatherFuture
- (NSString *)description
{
	return [NSString stringWithFormat:@"Weather:%@, code:%@,%@, day:%@, date:%@, high temperature:%ld, low temperature:%ld, chance of precipitation:%ld, wind %@", self.text, self.code1, self.code2, self.day, self.date, (long)self.temperatureHigh, (long)self.temperatureLow, (long)self.chanceOfPrecipitation, self.wind];
}
@end
