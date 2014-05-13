//
//  NSString+URLEncoding.h
//  ThinkPageSDK
//
//  Created by Shangwei Fang on 2/11/14.
//  Copyright (c) 2014 ThinkPage. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (URLEncoding)

/*!
 *
 * Encodes the string for use in a URL.
 *
 * @returns The string encoded for use in a URL
 *
 *
 **/
- (NSString *)URLEncodedString;

/*!
 *
 * Decodes the string if it was encoded for us in a URL.
 *
 * @returns The decoded string
 *
 *
 **/
- (NSString *)URLDecodedString;

@end
