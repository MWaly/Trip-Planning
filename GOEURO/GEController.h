//
//  GEController.h
//  GOEURO
//
//  Created by Mohamed Mokhles Waly on 11/17/13.
//  Copyright (c) 2013 MOKH. All rights reserved.
//
@import CoreLocation;
#import <Foundation/Foundation.h>
#import "GEPlace.h"
@interface GEController : NSObject

/**
 *  Singelton instance retrieval
 *
 *  @return single intance of the object
 */
+ (GEController *)appController;


// Convert Methods

+ (double)distanceFromCurrentLocation:(GEPlace*)newLocation andCurrentLocation:(CLLocation*)currentLocation;
/**
 * Retrieval Method
 */

- (void) getNearbyList :(NSString*)keyword;


/**
 *  Stored current location for distance purposes
 */
@property (nonatomic,strong) CLLocation* currentLocation;

@end
