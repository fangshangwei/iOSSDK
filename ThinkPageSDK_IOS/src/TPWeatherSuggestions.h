/*!
 @file		TPWeatherSuggestions.h
 @brief		TPWeatherSuggestions, weather suggestions.
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface TPWeatherSuggestions : NSObject
/*!
 *
 * The brief and details of the dressing suggestion
 **/
@property (nonatomic, retain) NSString *dressingBrief;
@property (nonatomic, retain) NSString *dressingDetails;

/*!
 *
 * The brief and details of the UV suggestion
 **/
@property (nonatomic, retain) NSString *uvBrief;
@property (nonatomic, retain) NSString *uvDetails;

/*!
 *
 * The brief and details of the car wash suggestion
 **/
@property (nonatomic, retain) NSString *carwashBrief;
@property (nonatomic, retain) NSString *carwashDetails;

/*!
 *
 * The brief and details of the travel suggestion
 **/
@property (nonatomic, retain) NSString *travelBrief;
@property (nonatomic, retain) NSString *travelDetails;

/*!
 *
 * The brief and details of the flu-prevention suggestion
 **/
@property (nonatomic, retain) NSString *fluBrief;
@property (nonatomic, retain) NSString *fluDetails;

/*!
 *
 * The brief and detailed suggestions for outdoor sports
 **/
@property (nonatomic, retain) NSString *sportBrief;
@property (nonatomic, retain) NSString *sportDetails;
@end
