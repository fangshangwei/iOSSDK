/*!
 @file		TPWeatherManager.m
 @brief		TPWeatherManager communicates with thinkpage server, and returns
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import "TPWeatherManager.h"
#import "TPWeatherRequest.h"
#import "NSString+URLEncoding.h"
#define kTPURLBaseString @"http://api.thinkpage.cn/v2/weather/"
#define kThinkPageSDKVersion @"iOS2.0.1"

@interface TPInternalWeatherRequest : NSObject
@property (nonatomic, retain) TPWeatherRequest *request;
@property (nonatomic, retain) NSURLConnection *connection;
@end

@implementation TPInternalWeatherRequest
@end

@interface TPWeatherManager(Private)
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response;
- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data;
- (NSCachedURLResponse *)connection:(NSURLConnection *)connection willCacheResponse:(NSCachedURLResponse*)cachedResponse;
- (void)connectionDidFinishLoading:(NSURLConnection *)connection;
- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error;
@end

@implementation TPWeatherManager
@synthesize weatherRequests = _weatherRequests, accessCode = _accessCode;
- (id)initWithAccessCode:(NSString*)accessCode delegate:(id)delegate
{
    if(self = [super init])
    {
        _weatherRequests = [[NSMutableArray alloc] init];
        _accessCode = [accessCode retain];
        _delegate = delegate; //weak
    }
    return self;
}

- (void)dealloc
{
    _delegate = nil;
    [self.accessCode release];
    [self.weatherRequests release];
    [super dealloc];
}

- (NSString *)languageStringFromID:(TPWeatherReportLanguage)languageid
{
    switch (languageid)
    {
        case kEnglish:
            return [NSString stringWithFormat:@"en"];
            break;
        case kSimplifiedChinese:
            return [NSString stringWithFormat:@"zh-chs"];
            break;
        case kTraditionalChinese:
            return [NSString stringWithFormat:@"zh-cht"];
            break;
        default:
            return [NSString stringWithFormat:@"zh-chs"];
    }
}

- (NSString *)temperatureUnitStringFromID:(TPTemperatureUnit)unitid
{
    switch (unitid)
    {
        case kCelsius:
            return [NSString stringWithFormat:@"c"];
            break;
        case kFahrenheit:
            return [NSString stringWithFormat:@"f"];
            break;
        default:
            return [NSString stringWithFormat:@"c"];
    }
}

- (NSString *)aqiStringFromID:(TPAirQualitySource)aqi
{
    switch (aqi)
    {
        case kAQINone:
            return [NSString stringWithFormat:@""];
            break;
        case kAQICity:
            return [NSString stringWithFormat:@"city"];
            break;
        case kAQIAll:
            return [NSString stringWithFormat:@"all"];
            break;
        default:
            return [NSString stringWithFormat:@""];
    }
}

- (NSString *)queryStringFromDictionary:(NSDictionary *)dictionary
{
    NSMutableArray *pairs = [NSMutableArray array];
    for (NSString *key in [dictionary keyEnumerator])
    {
        id value = [dictionary objectForKey:key];
        [pairs addObject:[NSString stringWithFormat:@"%@=%@", key, value]];
    }
    
    return [pairs componentsJoinedByString:@"&"];
}

- (void)fetchCurrentWeatherOfCity:(TPCity *)city
                       inLanguage:(TPWeatherReportLanguage)language
                             unit:(TPTemperatureUnit)unit
{
    TPInternalWeatherRequest *internalWeatherRequest = [[[TPInternalWeatherRequest alloc] init] autorelease];
    internalWeatherRequest.request = [TPWeatherRequest currentWeatherForCity:city];
    NSMutableDictionary *paramsDictionary = [[NSMutableDictionary alloc] init];
    [paramsDictionary setObject:[[city description] URLEncodedString] forKey:@"city"];
    [paramsDictionary setObject:[self languageStringFromID:language] forKey:@"language"];
    [paramsDictionary setObject:[self temperatureUnitStringFromID:unit] forKey:@"unit"];
    [paramsDictionary setObject:self.accessCode forKey:@"key"];
    [paramsDictionary setObject:[NSString stringWithFormat:@"%@", kThinkPageSDKVersion] forKey:@"source"];
    [self createURLRequest:internalWeatherRequest withURLString:[NSString stringWithFormat:@"%@now.json?%@", kTPURLBaseString, [self queryStringFromDictionary:paramsDictionary]]];
    
}

- (void)fetchFutureWeatherOfCity:(TPCity *)city
                      inLanguage:(TPWeatherReportLanguage)language
                            unit:(TPTemperatureUnit)unit
{
    TPInternalWeatherRequest *internalWeatherRequest = [[[TPInternalWeatherRequest alloc] init] autorelease];
    internalWeatherRequest.request = [TPWeatherRequest futureWeatherForCity:city];
    NSMutableDictionary *paramsDictionary = [[[NSMutableDictionary alloc] init] autorelease];
    [paramsDictionary setObject:[[city description] URLEncodedString] forKey:@"city"];
    [paramsDictionary setObject:[self languageStringFromID:language] forKey:@"language"];
    [paramsDictionary setObject:[self temperatureUnitStringFromID:unit] forKey:@"unit"];
    [paramsDictionary setObject:self.accessCode forKey:@"key"];
    [paramsDictionary setObject:[NSString stringWithFormat:@"%@", kThinkPageSDKVersion] forKey:@"source"];
    [self createURLRequest:internalWeatherRequest withURLString:[NSString stringWithFormat:@"%@future.json?%@", kTPURLBaseString, [self queryStringFromDictionary:paramsDictionary]]];
}

- (void)fetchAirQualityOfCity:(TPCity *)city
                   inLanguage:(TPWeatherReportLanguage)language
                         unit:(TPTemperatureUnit)unit
                          aqi:(TPAirQualitySource)aqi
{
    TPInternalWeatherRequest *internalWeatherRequest = [[[TPInternalWeatherRequest alloc] init] autorelease];
    internalWeatherRequest.request = [TPWeatherRequest airQualityForCity:city];
    NSMutableDictionary *paramsDictionary = [[[NSMutableDictionary alloc] init] autorelease];

	[paramsDictionary setObject:[[city description] URLEncodedString] forKey:@"city"];
    [paramsDictionary setObject:[self languageStringFromID:language] forKey:@"language"];
    [paramsDictionary setObject:[self temperatureUnitStringFromID:unit] forKey:@"unit"];
	[paramsDictionary setObject:[self aqiStringFromID:aqi] forKey:@"aqi"];
    [paramsDictionary setObject:self.accessCode forKey:@"key"];
    [paramsDictionary setObject:[NSString stringWithFormat:@"%@", kThinkPageSDKVersion] forKey:@"source"];
    [self createURLRequest:internalWeatherRequest withURLString:[NSString stringWithFormat:@"%@air.json?%@", kTPURLBaseString, [self queryStringFromDictionary:paramsDictionary]]];
}

- (void)fetchWeatherSuggestionsOfCity:(TPCity *)city
                    inLanguage:(TPWeatherReportLanguage)language
                          unit:(TPTemperatureUnit)unit
{
    TPInternalWeatherRequest *internalWeatherRequest = [[[TPInternalWeatherRequest alloc] init] autorelease];
    internalWeatherRequest.request = [TPWeatherRequest suggestionsForCity:city];
    NSMutableDictionary *paramsDictionary = [[[NSMutableDictionary alloc] init] autorelease];
    [paramsDictionary setObject:[[city description] URLEncodedString] forKey:@"city"];
    [paramsDictionary setObject:[self languageStringFromID:language] forKey:@"language"];
    [paramsDictionary setObject:[self temperatureUnitStringFromID:unit] forKey:@"unit"];
    [paramsDictionary setObject:self.accessCode forKey:@"key"];
    [paramsDictionary setObject:[NSString stringWithFormat:@"%@", kThinkPageSDKVersion] forKey:@"source"];
    [self createURLRequest:internalWeatherRequest withURLString:[NSString stringWithFormat:@"%@suggestion.json?%@", kTPURLBaseString, [self queryStringFromDictionary:paramsDictionary]]];
}

- (void)fetchAllWeatherOfCity:(TPCity *)city
                              inLanguage:(TPWeatherReportLanguage)language
                                    unit:(TPTemperatureUnit)unit
                                     aqi:(TPAirQualitySource)aqi
{
    TPInternalWeatherRequest *internalWeatherRequest = [[[TPInternalWeatherRequest alloc] init] autorelease];
    internalWeatherRequest.request = [TPWeatherRequest allForCity:city];
    NSMutableDictionary *paramsDictionary = [[[NSMutableDictionary alloc] init] autorelease];
    [paramsDictionary setObject:[[city description] URLEncodedString] forKey:@"city"];
    [paramsDictionary setObject:[self aqiStringFromID:aqi] forKey:@"aqi"];
    [paramsDictionary setObject:[self languageStringFromID:language] forKey:@"language"];
    [paramsDictionary setObject:[self temperatureUnitStringFromID:unit] forKey:@"unit"];
    [paramsDictionary setObject:self.accessCode forKey:@"key"];
    [paramsDictionary setObject:[NSString stringWithFormat:@"%@", kThinkPageSDKVersion] forKey:@"source"];
    [self createURLRequest:internalWeatherRequest withURLString:[NSString stringWithFormat:@"%@all.json?%@", kTPURLBaseString, [self queryStringFromDictionary:paramsDictionary]]];
}

- (BOOL)isRequestInQueue:(TPInternalWeatherRequest *)request
{
    for (TPInternalWeatherRequest* value in self.weatherRequests)
    {
        if ([value.request isEqualToRequest:request.request])
        {
            return YES;
        }
    }
    return NO;
}

- (void) createURLRequest:(TPInternalWeatherRequest *)request withURLString:(NSString *)urlString
{
    if ([self isRequestInQueue:request])
    {
        return;
    }
    // Create the request.
    NSURLRequest *urlrequest = [[NSURLRequest requestWithURL:[NSURL URLWithString:urlString]
                                                            cachePolicy:NSURLCacheStorageNotAllowed timeoutInterval:30.0] autorelease];
    // Create url connection and fire request
    NSURLConnection *conn = [[NSURLConnection alloc] initWithRequest:urlrequest delegate:self];
    
    // queue the connection
    if (conn != nil)
    {
        request.connection = conn;
        
        if ([self.weatherRequests count] == 0)
        {
            if ([self.delegate respondsToSelector:@selector(weatherManagerWillStartDownloading:)])
            {
                [self.delegate weatherManagerWillStartDownloading:self];
            }
        }
        
        [self.weatherRequests addObject:request];
    }
    
}
#pragma mark Request Cache Handling
// deal with the request cache per connection
- (TPInternalWeatherRequest *)requestForConnection:(NSURLConnection *)connection
{
    TPInternalWeatherRequest* cachedRequest = nil;
    // find the TPInternalWeatherRequest for the connection
    for (TPInternalWeatherRequest* value in self.weatherRequests)
    {
        if (value.connection == connection)
        {
            cachedRequest = value;
            break;
        }
    }
    return cachedRequest;
}

- (void)deleteRequestForConnection:(NSURLConnection *)connection
{
    TPInternalWeatherRequest* cachedRequest = [self requestForConnection:connection];
    [self.weatherRequests removeObject:cachedRequest];
}

#pragma mark NSURLConnection Delegate Methods
- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // A response has been received, this is where we initialize the instance var you created
    // so that we can append data to it in the didReceiveData method
    // Furthermore, this method is called each time there is a redirect so reinitializing it
    // also serves to clear it
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    TPInternalWeatherRequest* cachedRequest = [self requestForConnection:connection];
    [cachedRequest.request.resultData appendData:data];
}

- (NSCachedURLResponse *)connection:(NSURLConnection *)connection
                  willCacheResponse:(NSCachedURLResponse*)cachedResponse
{
    // Return nil to indicate not necessary to store a cached response for this connection
    return nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // The request has failed for some reason!
    // Check the error var
    TPInternalWeatherRequest* cachedRequest = [self requestForConnection:connection];
    
    if (cachedRequest && [cachedRequest.request.resultData bytes])
    {
        TPWeather *weather = [[TPWeather alloc] initWithJSONString: [[[NSString alloc] initWithData:cachedRequest.request.resultData encoding:NSUTF8StringEncoding] autorelease]];
        if ([self.delegate respondsToSelector:@selector(requestDidCompleteForCity:withReport:)])
        {
            [self.delegate requestDidCompleteForCity:cachedRequest.request.city withReport:weather];
        }
        //remove cached object
        [self deleteRequestForConnection:connection];
    }
    else
    {
        if ([self.delegate respondsToSelector:@selector(requestDidFailForCity:error:)])
        {
            [self.delegate requestDidFailForCity:cachedRequest.request.city error:[NSString stringWithFormat:@"Nothing returned from server, please try later"]];
        }
    }
    
    if ([self.weatherRequests count] == 0)
    {
        if ([self.delegate respondsToSelector:@selector(weatherManagerDidFinishDownloading:)])
        {
            [self.delegate weatherManagerDidFinishDownloading:self];
        }
    }
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // The request has failed for some reason!
    // Check the error var
    TPInternalWeatherRequest* cachedRequest = [self requestForConnection:connection];
    // notify for error
    if ([self.delegate respondsToSelector:@selector(requestDidFailForCity:error:)])
    {
        [self.delegate requestDidFailForCity:cachedRequest.request.city error:[error localizedDescription]];
    }
    
    //remove cached object
    [self deleteRequestForConnection:connection];
    if ([self.delegate respondsToSelector:@selector(weatherManagerDidFinishDownloading:)])
    {
        [self.delegate weatherManagerDidFinishDownloading:self];
    }
}
@end
