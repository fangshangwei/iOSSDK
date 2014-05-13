//
//  ThinkPageTestAppTests.m
//  ThinkPageTestAppTests
//
//  Created by Shangwei Fang on 2/19/14.
//  Copyright (c) 2014 ThinkPage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TPSDK.h"

@interface ThinkPageTestAppTests : XCTestCase

@end

@implementation ThinkPageTestAppTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testTPCity
{
    TPCity *city = [TPCity cityWithID:@"12345678"];
    XCTAssertNil(city.name, @"city name should be null");
    XCTAssertTrue([city.cityid isEqualToString:@"12345678"], @"The given json string should have status");
}

@end
