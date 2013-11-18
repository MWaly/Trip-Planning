//
//  GEResults.h
//
//  Created by Mac Book Pro on 11/17/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class GEGeoPosition;

@interface GEResults : NSObject <NSCoding>

@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) GEGeoPosition *geoPosition;
@property (nonatomic, assign) double resultsIdentifier;
@property (nonatomic, strong) NSString *name;


+ (GEResults *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
