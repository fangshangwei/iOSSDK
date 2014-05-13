//
//  TPModelController.m
//  TPSDKTestApp
//
//  Created by fangshangwei on 2/12/14.
//  Copyright (c) 2014 ThinkPage. All rights reserved.
//

#import "TPModelController.h"

#import "TPDataViewController.h"

/*
 A controller object that manages a simple model -- a collection of month names.
 
 The controller serves as the data source for the page view controller; it therefore implements pageViewController:viewControllerBeforeViewController: and pageViewController:viewControllerAfterViewController:.
 It also implements a custom method, viewControllerAtIndex: which is useful in the implementation of the data source methods, and in the initial configuration of the application.
 
 There is no need to actually create view controllers for each page in advance -- indeed doing so incurs unnecessary overhead. Given the data model, these methods create, configure, and return a new view controller on demand.
 */

static NSString *gCityNames[] = {@"Beijing", @"Shanghai", @"Chengdu", @"Seattle", @"SanFrancisco"};
static int CCityNames = (sizeof(gCityNames)/sizeof(NSString*));

@interface TPModelController()
@property (readonly, strong, nonatomic) NSMutableDictionary *pageData;
@end

@implementation TPModelController
@synthesize manager = _manager;
- (id)init
{
    self = [super init];
    if (self) {
		_pageData = [[NSMutableDictionary alloc] initWithCapacity:CCityNames];
		for (int i=0; i<CCityNames; ++i)
			{
				[_pageData setObject:[[[TPWeatherForecast alloc] initWithJSONString:nil] autorelease] forKey:[NSString stringWithFormat:@"%@", gCityNames[i]]];
			}
		
        _manager = [[TPWeatherManager alloc] initWithAccessCode:@"TPCLIENTIOS" delegate:self];
        [_manager fetchCurrentWeatherofCity:[TPCity cityWithName:@"Beijing"]
                                 inLanguage:kSimplifiedChinese
                                       unit:kCelsius];
        [_manager fetchFutureWeatherofCity:[TPCity cityWithName:@"Shanghai"]
                                 inLanguage:kSimplifiedChinese
                                       unit:kCelsius];
        
        [_manager fetchAirQualityofCity:[TPCity cityWithName:@"Chengdu"]
                                 inLanguage:kEnglish
                                       unit:kCelsius
                                        aqi:kAQICity];
        [_manager fetchSuggestionsofCity:[TPCity cityWithName:@"SanFrancisco"]
                                inLanguage:kSimplifiedChinese
                                      unit:kCelsius];
        [_manager fetchAllWeatherInformationofCity:[TPCity cityWithName:@"Seattle"]
                                 inLanguage:kSimplifiedChinese
                                       unit:kCelsius
                                        aqi:kAQICity];
    }
    return self;
}

- (void) requestDidCompleteForCity:(TPCity *)city withReport:(TPWeatherForecast *)report
{
    [self.pageData setObject:report forKey:city.displayName];
}

- (void) requestDidFailForCity:(TPCity *)city error:(NSString *)errorString
{
    NSLog(@"%@",errorString);
}

- (TPDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard
{   
    // Return the data view controller for the given index.
    if (([self.pageData count] == 0) || (index >= [self.pageData count])) {
        return nil;
    }
    
    // Create a new view controller and pass suitable data.
    TPDataViewController *dataViewController = [storyboard instantiateViewControllerWithIdentifier:@"TPDataViewController"];
    dataViewController.weather = [self.pageData objectForKey:gCityNames[index]];
    return dataViewController;
}

- (NSUInteger)indexOfViewController:(TPDataViewController *)viewController
{   
     // Return the index of the given data view controller.
     // For simplicity, this implementation uses a static array of model objects and the view controller stores the model object; you can therefore use the model object to identify the index.
	NSArray *temp = [self.pageData allKeysForObject:viewController.weather];
	if (!temp || [temp count] <= 0)
		return 0;
	int index;
	NSString *cityName = [temp objectAtIndex:0];
	for (index = 0; index < CCityNames; ++index)
	{
		if([cityName isEqualToString:gCityNames[index]])
			break;
	}
    return index;
}

#pragma mark - Page View Controller Data Source

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(TPDataViewController *)viewController];
    if ((index == 0) || (index == NSNotFound)) {
        return nil;
    }
    
    index--;
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController
{
    NSUInteger index = [self indexOfViewController:(TPDataViewController *)viewController];
    if (index == NSNotFound) {
        return nil;
    }
    
    index++;
    if (index == [self.pageData count]) {
        return nil;
    }
    return [self viewControllerAtIndex:index storyboard:viewController.storyboard];
}

@end
