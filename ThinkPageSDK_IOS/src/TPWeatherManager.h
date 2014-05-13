/*!
 @file		TPWeatherManager.h
 @brief		TPWeatherManager communicates with thinkpage server in background, and returns the weather fetch result to it's delegate (TPWeatherManagerDelegate) asynchrounously.
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import <Foundation/Foundation.h>
#import "TPCity.h"
#import "TPAirQuality.h"
#import "TPWeather.h"
#import "TPWeatherNow.h"
#import "TPWeatherFuture.h"
#import "TPWeatherManagerDelegate.h"

@class TPWeatherRequest;

/*!
 * The display language of the returned results
 **/
typedef enum _tpWeatherReportLanguage
{
    kEnglish,
    kSimplifiedChinese,
    kTraditionalChinese
}TPWeatherReportLanguage;

/*!
 * The metrics of the returned results
 **/
typedef enum _tpTemperatureUnit
{
    kCelsius,
    kFahrenheit
}TPTemperatureUnit;

/*!
 * The AQI of the returned results
 **/
typedef enum _tpAQI
{
    kAQINone,   //no air quality data
    kAQICity,   //get air quality data of city
    kAQIAll     //get air quality data of all sensors
}TPAirQualitySource;


@interface TPWeatherManager : NSObject<NSURLConnectionDelegate>

/*!
 *
 * Initializes a new TPWeatherManager with the given accessCode and delegate
 * @param accessCode the access code you got from https://api.thinkpage.cn
 * @param delegate the delegate object
 * @returns A TPWeatherManager instance
 **/
- (id)initWithAccessCode:(NSString*)accessCode delegate:(id<TPWeatherManagerDelegate>)delegate;

/*!
 *
 * Fetch current weather information of a City. The registered TPWeatherManagerDelegate will get notified asynchronously once fetch complete.
 * @param city the city you want fetch
 * @param language the language of returned result
 * @param unit Celsius or Fahrenheit
 **/
- (void)fetchCurrentWeatherOfCity:(TPCity *)city
                       inLanguage:(TPWeatherReportLanguage)language
                             unit:(TPTemperatureUnit)unit;

/*!
 *
 * Fetch weather forecast of a City. The registered TPWeatherManagerDelegate will get notified asynchronously once fetch complete.
 * @param city the city you want fetch
 * @param language the language of returned result
 * @param unit Celsius or Fahrenheit
 **/
- (void)fetchFutureWeatherOfCity:(TPCity *)city
                      inLanguage:(TPWeatherReportLanguage)language
                            unit:(TPTemperatureUnit)unit;

/*!
 *
 * Fetch air quality information of a City. The registered TPWeatherManagerDelegate will get notified asynchronously once fetch complete.
 * @param city the city you want fetch
 * @param language the language of returned result
 * @param unit Celsius or Fahrenheit
 * @param aqi air quality information, specify the data source.
 **/
- (void)fetchAirQualityOfCity:(TPCity *)city
                   inLanguage:(TPWeatherReportLanguage)language
                         unit:(TPTemperatureUnit)unit
                          aqi:(TPAirQualitySource)aqi;

/*!
 *
 * Fetch weather related suggestions of a City. The registered TPWeatherManagerDelegate will get notified asynchronously once fetch complete.
 * @param city the city you want fetch
 * @param language the language of returned result
 * @param unit Celsius or Fahrenheit
 **/
- (void)fetchWeatherSuggestionsOfCity:(TPCity *)city
                    inLanguage:(TPWeatherReportLanguage)language
                          unit:(TPTemperatureUnit)unit;

/*!
 *
 * Fetch all weather related information of a City. The registered TPWeatherManagerDelegate will get notified asynchronously once fetch complete.
 * @param city the city you want fetch
 * @param language the language of returned result
 * @param unit Celsius or Fahrenheit
  * @param aqi air quality information, specify the data source.
 **/
- (void)fetchAllWeatherOfCity:(TPCity *)city
                              inLanguage:(TPWeatherReportLanguage)language
                                    unit:(TPTemperatureUnit)unit
                                     aqi:(TPAirQualitySource)aqi;

@property (atomic, retain) NSMutableArray *weatherRequests; //serilized request queue
@property (nonatomic, retain) NSString *accessCode; //unique access code
@property (nonatomic, assign) id<TPWeatherManagerDelegate> delegate;
@end
