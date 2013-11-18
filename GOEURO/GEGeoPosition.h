//
//  GEGeoPosition.h
//
//  Created by Mac Book Pro on 11/17/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GEGeoPosition : NSObject <NSCoding>

@property (nonatomic, assign) double longitude;
@property (nonatomic, assign) double latitude;

+ (GEGeoPosition *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
