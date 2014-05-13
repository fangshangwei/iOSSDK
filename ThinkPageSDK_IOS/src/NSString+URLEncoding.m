//
//  NSString+URLEncoding.m
//  ThinkPageSDK
//
//  Created by Shangwei Fang on 2/11/14.
//  Copyright (c) 2014 ThinkPage. All rights reserved.
//

#import "NSString+URLEncoding.h"

@implementation NSString (URLEncoding)

- (NSString *)URLEncodedString
{
    NSString *encodedString = (NSString *)CFURLCreateStringByAddingPercentEscapes(NULL, (CFStringRef)self, NULL, (CFStringRef)@":!*();@/&?#[]+$,='%’\"", kCFStringEncodingUTF8);
    [encodedString autorelease];
    return encodedString;
}

- (NSString *)URLDecodedString
{
    NSString *decodedString = (NSString *)CFURLCreateStringByReplacingPercentEscapesUsingEncoding(NULL, (CFStringRef)self, CFSTR(""), kCFStringEncodingUTF8);
    [decodedString autorelease];
    return decodedString;
}

@end
