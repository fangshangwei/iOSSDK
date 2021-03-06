/*!
 @file		TPWeather.m
 @brief		The response we got from thinkpage server, include everything the server can give you
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */
#import "TPWeather.h"
#import "TPCity.h"
#import "TPWeatherFuture.h"
#import "TPWeatherNow.h"
#import "TPWeatherSuggestions.h"
#import "TPAirQuality.h"
#import "NSDate+InternetDateTime.h"


// internal utils for casting objects
static inline id TPObjectCast(Class cls, id obj)
{
	if ([obj isKindOfClass:cls])
	{
		return obj;
	}
	else
	{
		return nil;
	}
}

#define TPRequiredCast(cls, obj) ((cls*)TPObjectCast([cls class], obj))

@implementation TPWeather
- (id)initWithJSONString:(NSString *)jsonString
{
    if (self = [super init])
        {
		_weatherSuggestions = nil;
		_currentWeather = nil;
		_futureWeathers = nil;
		_airQualities = nil;
		_lastUpdate = nil;
		_city = nil;
		_sunriseTimeOfToday = nil;
		_sunsetTimeOfToday = nil;
        
        //NSLog(@"jsonString :%@", jsonString);
        NSError *error = nil;
		@try
			{
			NSDictionary *result = [TPRequiredCast(NSDictionary, [NSJSONSerialization JSONObjectWithData:[jsonString dataUsingEncoding:NSUTF8StringEncoding] options:kNilOptions error:&error]) retain];
			_status = TPRequiredCast(NSString,[result objectForKey:@"status"]);
			
			NSArray *weatherCollection = TPRequiredCast(NSArray, [result objectForKey:@"weather"]);
			if ([weatherCollection count] > 0)
				{
				NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
				[dateFormatter setDateFormat:@"yyyy-MM-dd'T'hh:mm:ssZ"];
				NSDictionary *weatherItem = [weatherCollection objectAtIndex:0];    // only support one city per request for now
					
				_city = [[TPCity cityWithName:TPRequiredCast(NSString,[weatherItem objectForKey:@"city_name"])
									   cityid:TPRequiredCast(NSString, [weatherItem objectForKey:@"city_id"])] retain];
					
                _lastUpdate = [[NSDate dateFromInternetDateTimeString:TPRequiredCast(NSString, [weatherItem objectForKey:@"last_update"]) formatHint:DateFormatHintNone] retain];
				id weatherForNow = TPRequiredCast(NSDictionary, [weatherItem objectForKey:@"now"]);
				
				if (weatherForNow)
					{
					[self weatherOfNowFromDictionary:weatherForNow];
					} // end weather for now
					
				id suggestion = TPRequiredCast(NSDictionary, [weatherItem objectForKey:@"suggestions"]);
				if (suggestion)
					{
					[self suggestionsOfTodayFromDictionary:suggestion];
					}
				
				id todayInfo = TPRequiredCast(NSDictionary, [weatherItem objectForKey:@"today"]);
				if (todayInfo)
					{
					[self weatherOfTodayFromDictionary:todayInfo];
					}
					
				id airquality = TPRequiredCast(NSDictionary, [weatherItem objectForKey:@"air_quality"]);
				if (airquality && !_airQualities)
					{
					[self airqualityFromDictionary:airquality];
					}
				id futureInfo = TPRequiredCast(NSArray, [weatherItem objectForKey:@"future"]);
				if (futureInfo)
					{
					[dateFormatter setDateFormat:@"yyyy-MM-dd"];
					[self weatherOfFutureFromArray:futureInfo];
					}
				}//if ([weatherCollection count] > 0)
			}
			@catch (NSException *exception)
			{
				NSLog(@"Exception encountered: %@", [exception description]);
			}
			@finally
			{
		
			}
        }
    return self;
}

- (void)dealloc
{
	[_weatherSuggestions release];
	[_currentWeather release];
	[_futureWeathers release];
	[_airQualities release];;
	[_lastUpdate release];
	[_city release];
	[_sunriseTimeOfToday release];
	[_sunsetTimeOfToday release];
	[super dealloc];
}

- (BOOL)isValid
{
	return [self.status isEqualToString:@"OK"];
}

- (void)weatherOfTodayFromDictionary:(NSDictionary *)weatherToday
{
    if ([weatherToday count] == 0)
	{
        return;
	}
	_sunriseTimeOfToday = [TPRequiredCast(NSString, [weatherToday objectForKey:@"sunrise"]) retain];
	_sunsetTimeOfToday = [TPRequiredCast(NSString, [weatherToday objectForKey:@"sunset"]) retain];
	id futureInfo = TPRequiredCast(NSArray, [weatherToday objectForKey:@"future"]);
	if (futureInfo)
	{
		[self weatherOfFutureFromArray:futureInfo];
	}
	id suggestion = TPRequiredCast(NSDictionary, [weatherToday objectForKey:@"suggestion"]);
	if (suggestion)
	{
		[self suggestionsOfTodayFromDictionary:suggestion];
	}
}

- (void)weatherOfNowFromDictionary:(NSDictionary *)weatherForNow
{
    if ([weatherForNow count] == 0)
        {
        return;
        }
    if (_currentWeather != nil)
        [_currentWeather release];
    _currentWeather = [[TPWeatherNow alloc] init];
    _currentWeather.text = TPRequiredCast(NSString, [weatherForNow objectForKey:@"text"]);
    _currentWeather.code = TPRequiredCast(NSString, [weatherForNow objectForKey:@"code"]);
    _currentWeather.temperature = [TPRequiredCast(NSString, [weatherForNow objectForKey:@"temperature"]) doubleValue];
    _currentWeather.feelsLikeTemperature = [TPRequiredCast(NSString, [weatherForNow objectForKey:@"feels_like"]) doubleValue];
    _currentWeather.windDirection = TPRequiredCast(NSString, [weatherForNow objectForKey:@"wind_direction"]);
    _currentWeather.windSpeed = [TPRequiredCast(NSString, [weatherForNow objectForKey:@"wind_speed"]) doubleValue];
    _currentWeather.windScale = [TPRequiredCast(NSString, [weatherForNow objectForKey:@"wind_scale"]) doubleValue];
    _currentWeather.humidity = [TPRequiredCast(NSString, [weatherForNow objectForKey:@"humidity"]) doubleValue];
    _currentWeather.visibility = [TPRequiredCast(NSString, [weatherForNow objectForKey:@"visibility"]) doubleValue];
    _currentWeather.pressure = [TPRequiredCast(NSString, [weatherForNow objectForKey:@"pressure"]) doubleValue];
    _currentWeather.pressureRising = TPRequiredCast(NSString, [weatherForNow objectForKey:@"pressure_rising"]);
    id airQualities = TPRequiredCast(NSDictionary, [weatherForNow objectForKey:@"air_quality"]);
    if (airQualities)
        {
        [self airqualityFromDictionary:airQualities];
        } // end air quality
}

- (void)suggestionsOfTodayFromDictionary:(NSDictionary *)suggestionDict
{
    if ([suggestionDict count] == 0)
        {
        return;
        }
    if (_weatherSuggestions != nil)
        [_weatherSuggestions release];
    _weatherSuggestions = [[TPWeatherSuggestions alloc] init];
    _weatherSuggestions.dressingBrief = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"dressing"]) objectForKey:@"brief"]);
    _weatherSuggestions.dressingDetails = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"dressing"]) objectForKey:@"details"]);
    _weatherSuggestions.uvBrief = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"uv"]) objectForKey:@"brief"]);
    _weatherSuggestions.uvDetails = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"uv"]) objectForKey:@"details"]);
    _weatherSuggestions.carwashBrief = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"car_washing"]) objectForKey:@"brief"]);
    _weatherSuggestions.carwashDetails = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"car_washing"]) objectForKey:@"details"]);
    _weatherSuggestions.travelBrief = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"travel"]) objectForKey:@"brief"]);
    _weatherSuggestions.travelDetails = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"travel"]) objectForKey:@"details"]);
    _weatherSuggestions.fluBrief = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"flu"]) objectForKey:@"brief"]);
    _weatherSuggestions.fluDetails = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"flu"]) objectForKey:@"details"]);
    _weatherSuggestions.sportBrief = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"sport"]) objectForKey:@"brief"]);
    _weatherSuggestions.sportDetails = TPRequiredCast(NSString, [TPRequiredCast(NSDictionary, [suggestionDict objectForKey:@"sport"]) objectForKey:@"details"]);
}

- (void)airqualityFromDictionary:(NSDictionary *)airQualities
{
    if ([airQualities count] == 0)
        {
        return;
        }
    
    if (_airQualities != nil)
        {
        [_airQualities release];
        }
    
    // have air quality data
    NSMutableArray *airQualityCollection = [[NSMutableArray alloc] initWithCapacity:1];
    //
    NSDictionary *airQualityCity = TPRequiredCast(NSDictionary, [airQualities objectForKey:@"city"]);
    if (airQualityCity)
        {
        TPAirQuality *aq = [[[TPAirQuality alloc] init] autorelease];
        aq.stationName = TPRequiredCast(NSString,[NSString stringWithFormat:@"city"]);
        aq.aqi = [TPRequiredCast(NSString,[airQualityCity objectForKey:@"aqi"]) doubleValue];
        aq.pm25 = [TPRequiredCast(NSString,[airQualityCity objectForKey:@"pm25"]) doubleValue];
        aq.pm10 = [TPRequiredCast(NSString,[airQualityCity objectForKey:@"pm10"]) doubleValue];
        aq.so2 = [TPRequiredCast(NSString,[airQualityCity objectForKey:@"so2"]) doubleValue];
        aq.no2 = [TPRequiredCast(NSString,[airQualityCity objectForKey:@"no2"]) doubleValue];
        aq.co = [TPRequiredCast(NSString,[airQualityCity objectForKey:@"co"]) doubleValue];
        aq.o3 = [TPRequiredCast(NSString,[airQualityCity objectForKey:@"o3"]) doubleValue];
        aq.quality = TPRequiredCast(NSString,[airQualityCity objectForKey:@"quality"]);
        aq.lastUpdate = [NSDate dateFromInternetDateTimeString:TPRequiredCast(NSString,[airQualityCity objectForKey:@"last_update"]) formatHint:DateFormatHintNone];
        [airQualityCollection addObject:aq];
        }
    
    NSArray *airQualityOthers = [airQualityCity objectForKey:@"stations"];
    if (airQualityOthers)
        {
        for (NSDictionary *airQualityItem in airQualityOthers)
            {
            TPAirQuality *aq = [[[TPAirQuality alloc] init] autorelease];
            aq.stationName = TPRequiredCast(NSString,[airQualityItem objectForKey:@"station"]);
            aq.aqi = [TPRequiredCast(NSString,[airQualityItem objectForKey:@"aqi"]) doubleValue];
            aq.pm25 = [TPRequiredCast(NSString,[airQualityItem objectForKey:@"pm25"]) doubleValue];
            aq.pm10 = [TPRequiredCast(NSString,[airQualityItem objectForKey:@"pm10"]) doubleValue];
            aq.so2 = [TPRequiredCast(NSString,[airQualityItem objectForKey:@"so2"]) doubleValue];
            aq.no2 = [TPRequiredCast(NSString,[airQualityItem objectForKey:@"no2"]) doubleValue];
            aq.co = [TPRequiredCast(NSString,[airQualityItem objectForKey:@"co"]) doubleValue];
            aq.o3 = [TPRequiredCast(NSString,[airQualityItem objectForKey:@"o3"]) doubleValue];
            aq.quality = TPRequiredCast(NSString,[airQualityItem objectForKey:@"quality"]);
            aq.lastUpdate = [NSDate dateFromInternetDateTimeString:TPRequiredCast(NSString,[airQualityItem objectForKey:@"last_update"]) formatHint:DateFormatHintNone];
            [airQualityCollection addObject:aq];
            }
        }
    //
    _airQualities = airQualityCollection;
}

- (void)weatherOfFutureFromArray:(NSArray *)futureInfo
{
    if ([futureInfo count] == 0)
        {
        return;
        }
    
    if (_futureWeathers != nil)
        {
        [_futureWeathers release];
        }
    NSMutableArray *tempWeatherCollection = [[NSMutableArray alloc] initWithCapacity:1];
    for (NSDictionary *weatherOfaDay in futureInfo)
        {
        TPWeatherFuture *weather = [[[TPWeatherFuture alloc] init] autorelease];
        weather.text = TPRequiredCast(NSString,[weatherOfaDay objectForKey:@"text"]);
        weather.code1 = TPRequiredCast(NSString,[weatherOfaDay objectForKey:@"code1"]);
        weather.code2 = TPRequiredCast(NSString,[weatherOfaDay objectForKey:@"code2"]);
        weather.day = TPRequiredCast(NSString,[weatherOfaDay objectForKey:@"day"]);
		weather.date = [NSDate dateFromInternetDateTimeString:TPRequiredCast(NSString,[weatherOfaDay objectForKey:@"date"]) formatHint:DateFormatHintNone];
        weather.temperatureHigh = [TPRequiredCast(NSString,[weatherOfaDay objectForKey:@"high"]) doubleValue];
        weather.temperatureLow = [TPRequiredCast(NSString,[weatherOfaDay objectForKey:@"low"]) doubleValue];
        weather.chanceOfPrecipitation = TPRequiredCast(NSString,[weatherOfaDay objectForKey:@"cop"]);
        weather.wind = TPRequiredCast(NSString,[weatherOfaDay objectForKey:@"wind"]);
        [tempWeatherCollection addObject:weather];
        }
    
    _futureWeathers = tempWeatherCollection;
}

- (NSString *)description
{
	if (![self isValid])
	{
		return [NSString stringWithFormat:@"Invalid Weather Forecast"];
	}
	return [NSString stringWithFormat:@"City:%@, Laste Update:%@, Now:%@, Future:%@, Air Qualities:%@, Suggestions:%@, Sunrise Time:%@, Sunset Time:%@", self.city, self.lastUpdate, self.currentWeather, self.futureWeathers, self.airQualities, self.weatherSuggestions, self.sunriseTimeOfToday, self.sunsetTimeOfToday];
}
@end
