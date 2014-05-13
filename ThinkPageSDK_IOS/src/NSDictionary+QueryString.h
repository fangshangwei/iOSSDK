//
//  NSDictionary+QueryString.h
//  ThinkPageSDK
//
//  Created by Shangwei Fang on 2/11/14.
//  Copyright (c) 2014 ThinkPage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDictionary (QueryString)

/*!
 *
 * Initializes a new dictionary containing the keys and values from the
 * specified query string.
 *
 * @param queryString The query parameters to parse
 *
 * @returns A new dictionary containing the specified query parameters.
 *
 *
 **/
+ (NSDictionary *)dictionaryWithQueryString:(NSString *)queryString;

/*!
 *
 * Returns the dictionary as a query string.
 *
 *
 **/
- (NSString *)queryStringValue;

@end