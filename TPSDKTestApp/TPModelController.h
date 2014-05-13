//
//  TPModelController.h
//  TPSDKTestApp
//
//  Created by fangshangwei on 2/12/14.
//  Copyright (c) 2014 ThinkPage. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TPWeatherManager.h"
@class TPDataViewController;

@interface TPModelController : NSObject <UIPageViewControllerDataSource, TPWeatherManagerDelegate>

- (TPDataViewController *)viewControllerAtIndex:(NSUInteger)index storyboard:(UIStoryboard *)storyboard;
- (NSUInteger)indexOfViewController:(TPDataViewController *)viewController;
@property (nonatomic, retain) TPWeatherManager *manager;
@end
