//
//  GEResults.m
//
//  Created by Mac Book Pro on 11/17/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GEResults.h"
#import "GEGeoPosition.h"


NSString *const kGEResultsType = @"_type";
NSString *const kGEResultsGeoPosition = @"geo_position";
NSString *const kGEResultsId = @"_id";
NSString *const kGEResultsName = @"name";



@interface GEResults ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GEResults

@synthesize type = _type;
@synthesize geoPosition = _geoPosition;
@synthesize resultsIdentifier = _resultsIdentifier;
@synthesize name = _name;



+ (GEResults *)modelObjectWithDictionary:(NSDictionary *)dict
{
    GEResults *instance = [[GEResults alloc] initWithDictionary:dict];
    return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict
{
    self = [super init];
    
    // This check serves to make sure that a non-NSDictionary object
    // passed into the model class doesn't break the parsing.
    if(self && [dict isKindOfClass:[NSDictionary class]]) {
            self.type = [self objectOrNilForKey:kGEResultsType fromDictionary:dict];
            self.geoPosition = [GEGeoPosition modelObjectWithDictionary:[dict objectForKey:kGEResultsGeoPosition]];
            self.resultsIdentifier = [[self objectOrNilForKey:kGEResultsId fromDictionary:dict] doubleValue];
            self.name = [self objectOrNilForKey:kGEResultsName fromDictionary:dict];
            self.type = [self objectOrNilForKey:kGEResultsType fromDictionary:dict];

    }
    
    return self;
    
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
    [mutableDict setValue:self.type forKey:kGEResultsType];
    [mutableDict setValue:[self.geoPosition dictionaryRepresentation] forKey:kGEResultsGeoPosition];
    [mutableDict setValue:[NSNumber numberWithDouble:self.resultsIdentifier] forKey:kGEResultsId];
    [mutableDict setValue:self.name forKey:kGEResultsName];
    [mutableDict setValue:self.type forKey:kGEResultsType];

    return [NSDictionary dictionaryWithDictionary:mutableDict];
}

- (NSString *)description 
{
    return [NSString stringWithFormat:@"%@", [self dictionaryRepresentation]];
}

#pragma mark - Helper Method
- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict
{
    id object = [dict objectForKey:aKey];
    return [object isEqual:[NSNull null]] ? nil : object;
}


#pragma mark - NSCoding Methods

- (id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];

    self.type = [aDecoder decodeObjectForKey:kGEResultsType];
    self.geoPosition = [aDecoder decodeObjectForKey:kGEResultsGeoPosition];
    self.resultsIdentifier = [aDecoder decodeDoubleForKey:kGEResultsId];
    self.name = [aDecoder decodeObjectForKey:kGEResultsName];
    self.type = [aDecoder decodeObjectForKey:kGEResultsType];
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{

    [aCoder encodeObject:_type forKey:kGEResultsType];
    [aCoder encodeObject:_geoPosition forKey:kGEResultsGeoPosition];
    [aCoder encodeDouble:_resultsIdentifier forKey:kGEResultsId];
    [aCoder encodeObject:_name forKey:kGEResultsName];
    [aCoder encodeObject:_type forKey:kGEResultsType];
}


@end
