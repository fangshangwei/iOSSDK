//
//  ViewController.h
//  ThinkPageTestApp
//
//  Created by Shangwei Fang on 2/19/14.
//  Copyright (c) 2014 ThinkPage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPSDK.h"
#import "CoreLocation/CoreLocation.h"

@interface ViewController : UIViewController<TPWeatherManagerDelegate, CLLocationManagerDelegate>
@property (nonatomic, retain) IBOutlet UITextField *cityNameTextfield;
@property (nonatomic, retain) IBOutlet UILabel *cityNameLabel;
@property (nonatomic, retain) IBOutlet UILabel *temperatureLabel;
@property (nonatomic, retain) IBOutlet UILabel *humidityLabel;
@property (nonatomic, retain) IBOutlet UILabel *winddirLabel;
@property (nonatomic, retain) IBOutlet UILabel *windscaleLabel;
@property (nonatomic, retain) IBOutlet UILabel *pm25Label;
@property (nonatomic, retain) IBOutlet UILabel *dressingLabel;
@property (nonatomic, retain) IBOutlet UILabel *carwashLabel;
@property (nonatomic, retain) IBOutlet UIImageView *weatherImage;
@property (nonatomic, retain) IBOutlet UISegmentedControl *options;
@property (nonatomic, retain) IBOutlet UILabel *lastUpdateLabel;
@property (nonatomic, retain) TPWeatherManager *weatherManager;
@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) TPCity *city;

-(IBAction)getWeatherDidPressed:(id)sender;
-(IBAction)getCurrentWeatherDidPressed:(id)sender;
@end
