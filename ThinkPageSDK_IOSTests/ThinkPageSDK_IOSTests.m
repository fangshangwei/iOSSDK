//
//  ThinkPageSDK_IOSTests.m
//  ThinkPageSDK_IOSTests
//
//  Created by Shangwei Fang on 2/12/14.
//  Copyright (c) 2014 ThinkPage. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "TPSDK.h"

@interface ThinkPageSDK_iOSTests : XCTestCase

@end

const static NSString *kStrFutureJSON = @"{\"status\":\"OK\",\"weather\":[{\"city_name\":\"西雅图\",\"city_id\":\"USWA0395\",\"last_update\":\"2014-02-20T01:05:00-08:00\",\"future\":[{\"text\":null,\"code\":\"44\",\"day\":\"周三\",\"date\":\"2014-02-19\",\"high\":null,\"low\":\"5\",\"cop\":\"60%\",\"wind\":\"未知\"},{\"text\":\"阵雨\",\"code\":\"11\",\"day\":\"周四\",\"date\":\"2014-02-20\",\"high\":\"8\",\"low\":\"3\",\"cop\":\"40%\",\"wind\":\"未知\"},{\"text\":\"晴间多云\",\"code\":\"30\",\"day\":\"周五\",\"date\":\"2014-02-21\",\"high\":\"7\",\"low\":\"0\",\"cop\":\"10%\",\"wind\":\"未知\"},{\"text\":\"晴间多云\",\"code\":\"30\",\"day\":\"周六\",\"date\":\"2014-02-22\",\"high\":\"7\",\"low\":\"3\",\"cop\":\"10%\",\"wind\":\"未知\"},{\"text\":\"阵雨\",\"code\":\"11\",\"day\":\"周日\",\"date\":\"2014-02-23\",\"high\":\"7\",\"low\":\"3\",\"cop\":\"50%\",\"wind\":\"未知\"},{\"text\":\"多云\",\"code\":\"26\",\"day\":\"周一\",\"date\":\"2014-02-24\",\"high\":\"7\",\"low\":\"2\",\"cop\":\"20%\",\"wind\":\"未知\"},{\"text\":\"晴时多云\",\"code\":\"34\",\"day\":\"周二\",\"date\":\"2014-02-25\",\"high\":\"11\",\"low\":\"3\",\"cop\":\"20%\",\"wind\":\"未知\"},{\"text\":\"晴间多云\",\"code\":\"30\",\"day\":\"周三\",\"date\":\"2014-02-26\",\"high\":\"12\",\"low\":\"4\",\"cop\":\"10%\",\"wind\":\"未知\"},{\"text\":\"阵雨\",\"code\":\"11\",\"day\":\"周四\",\"date\":\"2014-02-27\",\"high\":\"11\",\"low\":\"4\",\"cop\":\"60%\",\"wind\":\"未知\"},{\"text\":\"阵雨\",\"code\":\"11\",\"day\":\"周五\",\"date\":\"2014-02-28\",\"high\":\"9\",\"low\":\"3\",\"cop\":\"60%\",\"wind\":\"未知\"}]}]}";

const static NSString *kStrSuggestionJSON = @"{\"status\":\"OK\",\"weather\":[{\"city_name\":\"成都\",\"city_id\":\"101270101\",\"last_update\":\"2014-02-20T16:56:42+08:00\",\"suggestions\":{\"dressing\":{\"brief\":\"毛衣类\",\"details\":\"风衣、大衣、夹大衣、外套、毛衣、毛套装、西服套装、薄棉外套\"},\"uv\":{\"brief\":\"弱\",\"details\":\"紫外线弱\"},\"car_washing\":{\"brief\":\"非常适宜\",\"details\":\"洗车后至少未来4天内没有降水、大风、沙尘天气，保洁时间长，非常适宜洗车。注意洗车当日气温不能太低以免结冰。\"},\"travel\":{\"brief\":\"不太适宜\",\"details\":\"尽管透过白可见蓝天，旅游时会感到很凉；\"},\"flu\":{\"brief\":\"易发期\",\"details\":\"天气很凉，季节转换的气候，慎重增加衣服；较易引起感冒；\"},\"sport\":{\"brief\":\"不适宜\",\"details\":\"虽然晴空万里，但是户外运动时会感到很凉；\"}}}]}";

const static NSString *kStrAirQualityJSON = @"{\"status\":\"OK\",\"weather\":[{\"city_name\":\"上海\",\"city_id\":\"101020100\",\"last_update\":\"2014-02-20T17:25:04+08:00\",\"air_quality\":{\"city\":{\"aqi\":\"173\",\"pm25\":\"131\",\"pm10\":\"142\",\"so2\":\"52\",\"no2\":\"39\",\"co\":\"0.931\",\"o3\":\"97\",\"quality\":\"中度污染\",\"last_update\":\"2014-02-20T16:00:00+08:00\"},\"stations\":null}}]}";

const static NSString *kStrNowJSON = @"{\"status\":\"OK\",\"weather\":[{\"city_name\":\"上海\",\"city_id\":\"101020100\",\"last_update\":\"2014-02-20T17:25:04+08:00\",\"now\":{\"text\":\"晴\",\"code\":\"32\",\"temperature\":\"7\",\"feel_like\":\"6\",\"wind_direction\":\"东北\",\"wind_speed\":\"3.01\",\"wind_scale\":\"1\",\"humidity\":\"43\",\"visibility\":\"4.5\",\"pressure\":\"1031.2\",\"rising\":\"升高\",\"air_quality\":null}}]}";

const static NSString *kStrAllJSON = @"{\"status\":\"OK\",\"weather\":[{\"city_name\":\"北京\",\"city_id\":\"101010100\",\"last_update\":\"2014-02-20T17:16:23+08:00\",\"now\":{\"text\":\"阴/晴\",\"code\":\"26\",\"temperature\":\"1\",\"feel_like\":\"-3\",\"wind_direction\":\"南\",\"wind_speed\":\"3.01\",\"wind_scale\":\"1\",\"humidity\":\"74\",\"visibility\":\"0.8\",\"pressure\":\"1026.4\",\"rising\":\"未知\",\"air_quality\":{\"city\":{\"aqi\":\"314\",\"pm25\":\"263\",\"pm10\":\"282\",\"so2\":\"48\",\"no2\":\"85\",\"co\":\"2.275\",\"o3\":\"22\",\"quality\":\"严重污染\",\"last_update\":\"2014-02-20T16:00:00+08:00\"},\"stations\":null}},\"today\":{\"sunrise\":\"7:01 AM\",\"sunset\":\"5:56 PM\",\"suggestion\":{\"dressing\":{\"brief\":\"薄冬衣\",\"details\":\"棉衣、冬大衣、皮夹克、内着衬衫或羊毛内衣、毛衣、外罩大衣\"},\"uv\":{\"brief\":\"弱\",\"details\":\"紫外线弱\"},\"car_washing\":{\"brief\":\"非常适宜\",\"details\":\"洗车后至少未来4天内没有降水、大风、沙尘天气，保洁时间长，非常适宜洗车。注意洗车当日气温不能太低以免结冰。\"},\"travel\":{\"brief\":\"不太适宜\",\"details\":\"天气较冷，不太适宜旅游；\"},\"flu\":{\"brief\":\"多发期\",\"details\":\"天气较冷，室内外温差较大，较易引起感冒；\"},\"sport\":{\"brief\":\"不适宜\",\"details\":\"天气较冷，多数人不适宜户外运动；\"}}},\"future\":[{\"text\":\"阴/晴\",\"code\":\"26\",\"day\":\"周四\",\"date\":\"2014-02-20\",\"high\":\"5\",\"low\":\"-4\",\"cop\":\"0%\",\"wind\":\"微风小于3级\"},{\"text\":\"晴\",\"code\":\"32\",\"day\":\"周五\",\"date\":\"2014-02-21\",\"high\":\"7\",\"low\":\"-3\",\"cop\":\"0%\",\"wind\":\"微风小于3级\"},{\"text\":\"晴/多云\",\"code\":\"32\",\"day\":\"周六\",\"date\":\"2014-02-22\",\"high\":\"8\",\"low\":\"-2\",\"cop\":\"20%\",\"wind\":\"微风小于3级\"},{\"text\":\"多云/阴\",\"code\":\"28\",\"day\":\"周日\",\"date\":\"2014-02-23\",\"high\":\"7\",\"low\":\"-2\",\"cop\":\"10%\",\"wind\":\"微风小于3级\"},{\"text\":\"阴/晴\",\"code\":\"26\",\"day\":\"周一\",\"date\":\"2014-02-24\",\"high\":\"6\",\"low\":\"-2\",\"cop\":\"20%\",\"wind\":\"微风小于3级\"},{\"text\":\"晴/多云\",\"code\":\"32\",\"day\":\"周二\",\"date\":\"2014-02-25\",\"high\":\"8\",\"low\":\"-1\",\"cop\":\"0%\",\"wind\":\"微风小于3级\"},{\"text\":\"多云/阴\",\"code\":\"28\",\"day\":\"周三\",\"date\":\"2014-02-26\",\"high\":\"8\",\"low\":\"0\",\"cop\":\"10%\",\"wind\":\"微风小于3级\"},{\"text\":\"零星阵雨\",\"code\":\"39\",\"day\":\"周四\",\"date\":\"2014-02-27\",\"high\":\"9\",\"low\":\"-3\",\"cop\":\"40%\",\"wind\":\"未知\"},{\"text\":\"大部多云\",\"code\":\"28\",\"day\":\"周五\",\"date\":\"2014-02-28\",\"high\":\"7\",\"low\":\"-3\",\"cop\":\"0%\",\"wind\":\"未知\"},{\"text\":\"晴间多云\",\"code\":\"30\",\"day\":\"周六\",\"date\":\"2014-03-01\",\"high\":\"9\",\"low\":\"-3\",\"cop\":\"0%\",\"wind\":\"未知\"}]}]}";

const static NSString *kStrError = @"{\"stfd\"::\"OK\",g,d\"weather\":;'[{\"city_name\":\"上海\",\"city_id\":\"101020100\",\"last_update\":\"2014-02-20T17:25:04+08:00\",\"now\":{\"text\":\"晴\",\"code\":\"32\",\"temperature\":\"7\",\"feel_like\":\"6\",\"wind_direction\":\"东北\",\"wind_speed\":\"3.01\",\"wind_scale\":\"1\",\"humidity\":\"43\"1-,\"visibility\":\"4.5\",\"pressure\":\"1031.2\"fds,\"rising\":\"升高\",\"air_quality\":null}}]}";

@implementation ThinkPageSDK_iOSTests

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

- (void)testParseAllString
{
    TPWeather *result = [[[TPWeather alloc] initWithJSONString:[NSString stringWithFormat:@"%@",kStrAllJSON]] autorelease];
    XCTAssertTrue([result isValid], @"The given json string should be a valid string");
    XCTAssertTrue(result.status != nil, @"The given json string should have status");
    XCTAssertTrue(result.lastUpdate != nil, @"The given json string should have last update date");
    XCTAssertTrue(result.weatherSuggestions != nil, @"The given json string should have suggestions of today field");
    XCTAssertTrue(result.sunriseTimeOfToday != nil, @"The given json string should have sunrise time of today field");
    
    XCTAssertTrue(result.sunsetTimeOfToday != nil, @"The given json string should have sunset time of today field");
    XCTAssertTrue(result.futureWeathers != nil, @"The given json string should have weather forecast");
    XCTAssertTrue([result.futureWeathers count] == 10, @"The given json string should have 10 days of weather forecast");
    
    XCTAssertTrue(result.currentWeather != nil, @"The given json string should have the current weather");
    XCTAssertTrue((int)(result.currentWeather.temperature) == 1, @"The given json string should have the current temperature as 1");
}

- (void)testParseNowString
{
    TPWeather *result = [[[TPWeather alloc] initWithJSONString:[NSString stringWithFormat:@"%@",kStrNowJSON]] autorelease];
    XCTAssertTrue([result isValid], @"The given json string should be a valid string");
    XCTAssertTrue(result.status != nil, @"The given json string should have status");
    XCTAssertTrue(result.lastUpdate != nil, @"The given json string should have last update date");

}

- (void)testParseFutureString
{
    TPWeather *result = [[[TPWeather alloc] initWithJSONString:[NSString stringWithFormat:@"%@",kStrFutureJSON]] autorelease];
    XCTAssertTrue([result isValid], @"The given json string should be a valid string");
    XCTAssertTrue(result.status != nil, @"The given json string should have status");
    XCTAssertTrue(result.lastUpdate != nil, @"The given json string should have last update date");
    XCTAssertNil(result.sunriseTimeOfToday, @"No sunrise time in future string");
    XCTAssertNil(result.airQualities, @"No airquality info");
    XCTAssertNil(result.currentWeather, @"No now info");
    XCTAssertNotNil(result.futureWeathers, @"Future String shouldn't be null");
    XCTAssertTrue([result.futureWeathers count] == 10, @"should have 10 elements in future report");
    
    TPWeatherFuture *futureWeather = [result.futureWeathers objectAtIndex:[result.futureWeathers count] - 1]; // last day
    XCTAssertTrue(futureWeather.temperatureHigh == 9, @"Temp high for the last day is 9");
    XCTAssertNotNil(futureWeather.date, @"Date shouldn't be null");
    
}

- (void)testParseAirQualityString
{
    TPWeather *result = [[[TPWeather alloc] initWithJSONString:[NSString stringWithFormat:@"%@",kStrAirQualityJSON]] autorelease];
    XCTAssertTrue([result isValid], @"The given json string should be a valid string");
    XCTAssertTrue(result.status != nil, @"The given json string should have status");
    XCTAssertTrue(result.lastUpdate != nil, @"The given json string should have last update date");
    XCTAssertNil(result.sunriseTimeOfToday, @"No sunrise time in future string");
    XCTAssertNil(result.futureWeathers, @"No future info");
    XCTAssertNil(result.currentWeather, @"No now info");
    XCTAssertNotNil(result.airQualities, @"Air Quality String shouldn't be null");
    XCTAssertTrue([result.airQualities count] == 1, @"1 air quality result");
    TPAirQuality *airquality = [result.airQualities objectAtIndex:0];
    XCTAssertTrue(airquality.aqi == 173, @"aqi = 173");
    XCTAssertNotNil(airquality.lastUpdate, @"lastUpdate shouldn't be null");
    XCTAssertTrue(airquality.pm25 == 131, @"pm25 == 131");
}

- (void)testParseSuggestionsString
{
    TPWeather *result = [[[TPWeather alloc] initWithJSONString:[NSString stringWithFormat:@"%@",kStrSuggestionJSON]] autorelease];
    XCTAssertTrue([result isValid], @"The given json string should be a valid string");
    XCTAssertTrue(result.status != nil, @"The given json string should have status");
    XCTAssertTrue(result.lastUpdate != nil, @"The given json string should have last update date");
    XCTAssertNil(result.sunriseTimeOfToday, @"No sunrise time in future string");
    XCTAssertNil(result.futureWeathers, @"No future info");
    XCTAssertNil(result.currentWeather, @"No now info");
    XCTAssertNil(result.airQualities, @"No air quality info");
    XCTAssertNotNil(result.weatherSuggestions, @"Should have suggestions info");
}

- (void)testParseErrorJSONString
{
    TPWeather *result = [[[TPWeather alloc] initWithJSONString:[NSString stringWithFormat:@"%@",kStrError]] autorelease];
    XCTAssertFalse([result isValid], @"The given json string should be a valid string");
    XCTAssertNil(result.sunriseTimeOfToday, @"No sunrise time in future string");
    XCTAssertNil(result.futureWeathers, @"No future info");
    XCTAssertNil(result.currentWeather, @"No now info");
    XCTAssertNil(result.airQualities, @"No air quality info");
    XCTAssertNil(result.weatherSuggestions, @"No suggestion quality info");
}

- (void)testTPCity
{
    TPCity *city = [TPCity cityWithID:@"12345678"];
    XCTAssertNil(city.name, @"city name should be null");
    XCTAssertTrue([city.cityid isEqualToString:@"12345678"], @"The given json string should have status");
}
@end
