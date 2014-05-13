//
//  TPDataViewController.h
//  TPSDKTestApp
//
//  Created by fangshangwei on 2/12/14.
//  Copyright (c) 2014 ThinkPage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPWeatherForecast.h"

@interface TPDataViewController : UIViewController

- (void) updateUI;

@property (strong, nonatomic) IBOutlet UILabel *dataLabel;
@property (strong, nonatomic) IBOutlet UILabel *temperatureLabel;
@property (strong, nonatomic) IBOutlet UILabel *wind_directionLabel;
@property (strong, nonatomic) IBOutlet UILabel *wind_speedLabel;
@property (strong, nonatomic) IBOutlet UILabel *wind_ScaleLabel;
@property (strong, nonatomic) IBOutlet UILabel *pm25Label;
@property (strong, nonatomic) IBOutlet UILabel *dressLabel;
@property (nonatomic, retain) TPWeatherForecast *weather;
@end
