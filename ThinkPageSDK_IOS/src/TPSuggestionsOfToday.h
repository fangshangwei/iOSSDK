/*!
 @file		TPSuggestionsOfToday.h
 @brief		TPSuggestionsOfToday
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import <Foundation/Foundation.h>

@interface TPSuggestionsOfToday : NSObject
/*!
 *
 * The brief and details of the dressing suggestion
 **/
@property (nonatomic, retain) NSString *dressing_brief;
@property (nonatomic, retain) NSString *dressing_details;

/*!
 *
 * The brief and details of the UV suggestion
 **/
@property (nonatomic, retain) NSString *uv_brief;
@property (nonatomic, retain) NSString *uv_details;

/*!
 *
 * The brief and details of the car wash suggestion
 **/
@property (nonatomic, retain) NSString *carwash_brief;
@property (nonatomic, retain) NSString *carwash_details;

/*!
 *
 * The brief and details of the travel suggestion
 **/
@property (nonatomic, retain) NSString *travel_brief;
@property (nonatomic, retain) NSString *travel_details;

/*!
 *
 * The brief and details of the flu-prevention suggestion
 **/
@property (nonatomic, retain) NSString *flu_brief;
@property (nonatomic, retain) NSString *flu_details;

/*!
 *
 * The brief and detailed suggestions for outdoor sports
 **/
@property (nonatomic, retain) NSString *sport_brief;
@property (nonatomic, retain) NSString *sport_details;
@end
