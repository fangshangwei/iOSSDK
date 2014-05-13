//
//  TPDataViewController.m
//  TPSDKTestApp
//
//  Created by fangshangwei on 2/12/14.
//  Copyright (c) 2014 ThinkPage. All rights reserved.
//

#import "TPDataViewController.h"
#import "TPCity.h"
#import "TPWeatherNow.h"
#import "TPAirQuality.h"
#import "TPSuggestionsOfToday.h"

@interface TPDataViewController ()

@end

@implementation TPDataViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
	[self updateUI];
}

- (void) updateUI
{
	self.dataLabel.text = self.weather.city.displayName;
	self.temperatureLabel.text = [NSString stringWithFormat:@"%d", self.weather.weatherOfNow.temperature];
	self.wind_directionLabel.text = self.weather.weatherOfNow.wind_direction;
	self.wind_speedLabel.text = [NSString stringWithFormat:@"%f", self.weather.weatherOfNow.wind_speed];
	self.wind_ScaleLabel.text = [NSString stringWithFormat:@"%f", self.weather.weatherOfNow.wind_scale];
	self.dressLabel.text = self.weather.suggestionsOfToday.dressing_brief;
	if (self.weather.airQualities && [self.weather.airQualities count] > 0)
		{
		self.pm25Label.text = [NSString stringWithFormat:@"%f", self.weather.weatherOfNow.wind_scale];
		}
	
}
@end
