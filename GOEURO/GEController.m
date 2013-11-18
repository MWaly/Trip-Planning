//
//  GEController.m
//  GOEURO
//
//  Created by Mohamed Mokhles Waly on 11/17/13.
//  Copyright (c) 2013 MOKH. All rights reserved.
//

#import "GEController.h"
#import "GEPlace.h"
#import "DataModels.h"
#import "GENetworkManager.h"

@interface GEController ()

- (void)didRetrieveNetworkResponse:(NSNotification *)notf;

@end

@implementation GEController
static GEController *appController = nil;

#pragma mark - Initilization -
+ (GEController *)appController {
	@synchronized(self)
	{
		if (appController == nil) {
			appController = [[GEController alloc] init];
			[[NSNotificationCenter defaultCenter] addObserver:appController selector:@selector(didRetrieveNetworkResponse:) name:GENetworkDidRetrieveLocations object:nil];
			[[NSNotificationCenter defaultCenter] addObserver:appController selector:@selector(didRetrieveNetworkResponseError:) name:GENetworkDidRetrieveLocationsError object:nil];
		}
	}
	return appController;
}

- (void)dealloc {
	[[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (void)didRetrieveNetworkResponseError:(NSNotification *)notf {
	NSLog(@"The error is %@", [[notf userInfo] valueForKey:@"error"]);
	[[NSNotificationCenter defaultCenter] postNotificationName:GEVCDidRetrieveLocationsError object:nil userInfo:notf.userInfo];
}

- (void)didRetrieveNetworkResponse:(NSNotification *)notf {
	GEAutoCompleteJSON *jsonObject = [GEAutoCompleteJSON modelObjectWithDictionary:notf.userInfo];
    
	NSMutableArray *arrayOfPlaces = [@[] mutableCopy];
	for (GEResults *locJSONObject in jsonObject.results) {
		GEPlace *appModel = [self convertJSONtoAppModel:locJSONObject];
		[arrayOfPlaces addObject:appModel];
	}
    NSSortDescriptor *descriptor = [[NSSortDescriptor alloc]initWithKey:@"distanceFromCurrentLocation" ascending:YES];
   
	[[NSNotificationCenter defaultCenter] postNotificationName:GEVCDidRetrieveLocations object:nil userInfo:@{ @"value":[arrayOfPlaces sortedArrayUsingDescriptors:@[descriptor]]}];
}

- (GEPlace *)convertJSONtoAppModel:(GEResults *)jsonObject {
	GEPlace *dataObject = [[GEPlace alloc]init];
	dataObject.placeName = jsonObject.name;
	dataObject.lat = @(jsonObject.geoPosition.latitude);
	dataObject.lng = @(jsonObject.geoPosition.longitude);
	double x = [GEController distanceFromCurrentLocation:dataObject andCurrentLocation:_currentLocation];
	dataObject.distanceFromCurrentLocation = @(x);
	return dataObject;
}

+ (double)distanceFromCurrentLocation:(GEPlace *)newLocation andCurrentLocation:(CLLocation *)currentLocation {
	CLLocation *loc = [[CLLocation alloc] initWithLatitude:[newLocation.lat doubleValue] longitude:[newLocation.lng doubleValue]];
    
	CLLocationDistance distance = [currentLocation distanceFromLocation:loc] / 1000;
	return distance;
}

- (void)getNearbyList:(NSString *)keyword {
	[[[GENetworkManager globalNetworkManager] getListOfNearbyPlace:keyword] start];
}

@end
