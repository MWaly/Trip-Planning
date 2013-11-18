//
//  GEPlace.h
//  GOEURO
//
//  Created by Mohamed Mokhles Waly on 11/17/13.
//  Copyright (c) 2013 MOKH. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface GEPlace : NSObject

@property (nonatomic,strong) NSNumber *lng;
@property (nonatomic,strong) NSNumber *lat;
@property (nonatomic,strong) NSNumber *distanceFromCurrentLocation;
@property (nonatomic,strong  ) NSString *placeName;

@end
