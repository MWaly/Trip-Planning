//
//  GEGeoPosition.m
//
//  Created by Mac Book Pro on 11/17/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GEGeoPosition.h"


NSString *const kGEGeoPositionLongitude = @"longitude";
NSString *const kGEGeoPositionLatitude = @"latitude";


@interface GEGeoPosition ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GEGeoPosition

@synthesize longitude = _longitude;
@synthesize latitude = _latitude;


+ (GEGeoPosition *)modelObjectWithDictionary:(NSDictionary *)dict {
	GEGeoPosition *instance = [[GEGeoPosition alloc] initWithDictionary:dict];
	return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
	self = [super init];
    
	// This check serves to make sure that a non-NSDictionary object
	// passed into the model class doesn't break the parsing.
	if (self && [dict isKindOfClass:[NSDictionary class]]) {
		self.longitude = [[self objectOrNilForKey:kGEGeoPositionLongitude fromDictionary:dict] doubleValue];
		self.latitude = [[self objectOrNilForKey:kGEGeoPositionLatitude fromDictionary:dict] doubleValue];
	}
    
	return self;
}

- (NSDictionary *)dictionaryRepresentation {
	NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	[mutableDict setValue:[NSNumber numberWithDouble:self.longitude] forKey:kGEGeoPositionLongitude];
	[mutableDict setValue:[NSNumber numberWithDouble:self.latitude] forKey:kGEGeoPositionLatitude];
    
	return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description {
	return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict {
	id object = [dict objectForKey:aKey];
	return [object isEqual:[NSNull null]] ? nil : object;
}

#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super init];
    
	self.longitude = [aDecoder decodeDoubleForKey:kGEGeoPositionLongitude];
	self.latitude = [aDecoder decodeDoubleForKey:kGEGeoPositionLatitude];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeDouble:_longitude forKey:kGEGeoPositionLongitude];
	[aCoder encodeDouble:_latitude forKey:kGEGeoPositionLatitude];
}

@end
