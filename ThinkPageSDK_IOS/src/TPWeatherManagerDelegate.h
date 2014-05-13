/*!
 @file		TPWeatherManagerDelegate.h
 @brief		TPWeatherManagerDelegate defines interfaces that clients need to conform to in order to get the ThinkPage services
 @author	Shangwei Fang
 @date		Copyright (c) 2014 ThinkPage. All rights reserved.
 */

#import <Foundation/Foundation.h>

@class TPCity;
@class TPWeather;
@class TPWeatherManager;

@protocol TPWeatherManagerDelegate <NSObject>
@optional
/*!
 *
 * The weather manager is going download weather data from internet, normally this is the place you set networkActivityIndicatorVisible to YES
 * @param manager the TPWeatherManager instance who is initiating the request
 **/
- (void)weatherManagerWillStartDownloading:(TPWeatherManager *)manager;

/*!
 *
 * The weather manager finished downloading weather data from internet, normally this is the place you set networkActivityIndicatorVisible to NO
 * @param manager the TPWeatherManager instance who just finished downloading
 **/
- (void)weatherManagerDidFinishDownloading:(TPWeatherManager *)manager;

@required
/*!
 *
 *
 * @city manager the TPWeatherManager instance who just finished downloading
 * @report manager the TPWeatherManager instance who just finished downloading
 **/
- (void)requestDidCompleteForCity:(TPCity *)city withReport:(TPWeather *)report;

/*!
 *
 *
 * @city manager the TPWeatherManager instance who just finished downloading
 * @report manager the TPWeatherManager instance who just finished downloading
 **/
- (void)requestDidFailForCity:(TPCity *)city error:(NSString *)errorString;
@end
