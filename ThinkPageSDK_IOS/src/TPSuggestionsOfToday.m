/*!
 @file		TPSuggestionsOfToday.m
 @brief		TPSuggestionsOfToday
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import "TPSuggestionsOfToday.h"

@implementation TPSuggestionsOfToday
- (NSString *)description
{
	return [NSString stringWithFormat:@"%@:%@, %@:%@, %@:%@, %@:%@, %@:%@, %@:%@,", self.dressing_brief, self.dressing_details, self.uv_brief, self.uv_details, self.carwash_brief, self.carwash_details, self.travel_brief, self.travel_details, self.flu_brief, self.flu_details, self.sport_brief, self.sport_details];
}
@end
