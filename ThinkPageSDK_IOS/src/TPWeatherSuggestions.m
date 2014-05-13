/*!
 @file		TPWeatherSuggestions.m
 @brief		TPWeatherSuggestions
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import "TPWeatherSuggestions.h"

@implementation TPWeatherSuggestions
- (NSString *)description
{
	return [NSString stringWithFormat:@"%@:%@, %@:%@, %@:%@, %@:%@, %@:%@, %@:%@,", self.dressingBrief, self.dressingDetails, self.uvBrief, self.uvDetails, self.carwashBrief, self.carwashDetails, self.travelBrief, self.travelDetails, self.fluBrief, self.fluDetails, self.sportBrief, self.sportDetails];
}
@end
