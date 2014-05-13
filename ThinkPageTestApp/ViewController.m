//
//  ViewController.m
//  ThinkPageTestApp
//
//  Created by Shangwei Fang on 2/19/14.
//  Copyright (c) 2014 ThinkPage. All rights reserved.
//

#import "ViewController.h"
#define kThinkPageAPIKey @"TPCLIENTIOS"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
	self.weatherManager = [[TPWeatherManager alloc] initWithAccessCode:kThinkPageAPIKey delegate:self];
    self.locationManager = [[CLLocationManager alloc] init];
    self.locationManager.delegate = self;
    self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    
    [self.locationManager startUpdatingLocation];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)getWeatherDidPressed:(id)sender
{
	[self.cityNameTextfield resignFirstResponder];
    NSUInteger option = [self.options selectedSegmentIndex];
    switch (option)
        {
        case 0:
        [self.weatherManager fetchAllWeatherOfCity:[TPCity cityWithName:self.cityNameTextfield.text]
											   inLanguage:kSimplifiedChinese
													 unit:kCelsius
													  aqi:kAQICity];
        break;
        case 1:
        [self.weatherManager fetchCurrentWeatherOfCity:[TPCity cityWithName:self.cityNameTextfield.text]
                                                           inLanguage:kSimplifiedChinese
                                                                 unit:kCelsius];
        break;
        case 2:
        [self.weatherManager fetchAirQualityOfCity:[TPCity cityWithName:self.cityNameTextfield.text]
                                                       inLanguage:kSimplifiedChinese
                                                             unit:kCelsius
                                                              aqi:kAQICity];
        break;
        case 3:
        [self.weatherManager fetchWeatherSuggestionsOfCity:[TPCity cityWithName:self.cityNameTextfield.text]
                                                       inLanguage:kSimplifiedChinese
                                                             unit:kCelsius];
        break;
        case 4:
        [self.weatherManager fetchFutureWeatherOfCity:[TPCity cityWithName:self.cityNameTextfield.text]
                                                       inLanguage:kSimplifiedChinese
                                                             unit:kCelsius];
        break;
        default:
        [self.weatherManager fetchAllWeatherOfCity:[TPCity cityWithName:self.cityNameTextfield.text]
                                                       inLanguage:kSimplifiedChinese
                                                             unit:kCelsius
                                                              aqi:kAQICity];
        break;
        }
}

- (void) weatherManagerWillStartDownloading:(TPWeatherManager*)manager
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}
- (void) weatherManagerDidFinishDownloading:(TPWeatherManager*)manager
{
	[UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void) requestDidCompleteForCity:(TPCity *)city withReport:(TPWeather *)report
{
	// loading images for weather
	if([report.currentWeather.description rangeOfString:@"晴"].location != NSNotFound)
	{
		self.weatherImage.image = [UIImage imageNamed:@"Sunny.png"];
	}
	else if([report.currentWeather.description rangeOfString:@"多云"].location != NSNotFound)
	{
		self.weatherImage.image = [UIImage imageNamed:@"PartialSunny.png"];
	}
	else if([report.currentWeather.description rangeOfString:@"阴"].location != NSNotFound)
	{
		self.weatherImage.image = [UIImage imageNamed:@"cloudy.png"];
	}
	else if([report.currentWeather.description rangeOfString:@"雷"].location != NSNotFound)
	{
		self.weatherImage.image = [UIImage imageNamed:@"storm.png"];
	}
	else if([report.currentWeather.description rangeOfString:@"雨"].location != NSNotFound)
	{
		self.weatherImage.image = [UIImage imageNamed:@"rain.png"];
	}
	
	self.cityNameLabel.text = report.city.name;
	self.temperatureLabel.text = [NSString stringWithFormat:@"%ld",(long)report.currentWeather.temperature];
	self.humidityLabel.text = [NSString stringWithFormat:@"%f％",report.currentWeather.humidity];
	self.winddirLabel.text = report.currentWeather.windDirection;
	self.windscaleLabel.text = [NSString stringWithFormat:@"%f",report.currentWeather.windScale];
	if (report.airQualities && [report.airQualities count] > 0)
		{
		self.pm25Label.text = [NSString stringWithFormat:@"%f",((TPAirQuality *)[report.airQualities objectAtIndex:0]).pm25];
		}
	self.dressingLabel.text = report.weatherSuggestions.dressingBrief;
	self.carwashLabel.text = report.weatherSuggestions.carwashBrief;
    self.lastUpdateLabel.text = [report.lastUpdate description];
}


- (void) requestDidFailForCity:(TPCity *)city error:(NSString *)errorString
{
	
}

-(IBAction)getCurrentWeatherDidPressed:(id)sender
{
    if (!self.city)
    {
        return;
    }
	[self.cityNameTextfield resignFirstResponder];
    NSUInteger option = [self.options selectedSegmentIndex];
    switch (option)
    {
        case 0:
            [self.weatherManager fetchAllWeatherOfCity:self.city
                                            inLanguage:kSimplifiedChinese
                                                  unit:kCelsius
                                                   aqi:kAQICity];
            break;
        case 1:
            [self.weatherManager fetchCurrentWeatherOfCity:self.city
                                                inLanguage:kSimplifiedChinese
                                                      unit:kCelsius];
            break;
        case 2:
            [self.weatherManager fetchAirQualityOfCity:self.city
                                            inLanguage:kSimplifiedChinese
                                                  unit:kCelsius
                                                   aqi:kAQICity];
            break;
        case 3:
            [self.weatherManager fetchWeatherSuggestionsOfCity:self.city
                                                    inLanguage:kSimplifiedChinese
                                                          unit:kCelsius];
            break;
        case 4:
            [self.weatherManager fetchFutureWeatherOfCity:self.city
                                               inLanguage:kSimplifiedChinese
                                                     unit:kCelsius];
            break;
        default:
            [self.weatherManager fetchAllWeatherOfCity:self.city
                                            inLanguage:kSimplifiedChinese
                                                  unit:kCelsius
                                                   aqi:kAQICity];
            break;
    }
}

#pragma mark - CLLocationManagerDelegate
- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"FAILED: %@", [error description]);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation
{
    self.city = [TPCity cityWithLocation:newLocation];
}
@end
