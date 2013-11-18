//
//  GEAutoCompleteJSON.m
//
//  Created by Mac Book Pro on 11/17/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import "GEAutoCompleteJSON.h"
#import "GEResults.h"


NSString *const kGEAutoCompleteJSONResults = @"results";


@interface GEAutoCompleteJSON ()

- (id)objectOrNilForKey:(id)aKey fromDictionary:(NSDictionary *)dict;

@end

@implementation GEAutoCompleteJSON

@synthesize results = _results;


+ (GEAutoCompleteJSON *)modelObjectWithDictionary:(NSDictionary *)dict {
	GEAutoCompleteJSON *instance = [[GEAutoCompleteJSON alloc] initWithDictionary:dict];
	return instance;
}

- (instancetype)initWithDictionary:(NSDictionary *)dict {
	self = [super init];
    
	// This check serves to make sure that a non-NSDictionary object
	// passed into the model class doesn't break the parsing.
	if (self && [dict isKindOfClass:[NSDictionary class]]) {
		NSObject *receivedGEResults = [dict objectForKey:kGEAutoCompleteJSONResults];
		NSMutableArray *parsedGEResults = [NSMutableArray array];
		if ([receivedGEResults isKindOfClass:[NSArray class]]) {
			for (NSDictionary *item in(NSArray *) receivedGEResults) {
				if ([item isKindOfClass:[NSDictionary class]]) {
					[parsedGEResults addObject:[GEResults modelObjectWithDictionary:item]];
				}
			}
		}
		else if ([receivedGEResults isKindOfClass:[NSDictionary class]]) {
			[parsedGEResults addObject:[GEResults modelObjectWithDictionary:(NSDictionary *)receivedGEResults]];
		}
        
		self.results = [NSArray arrayWithArray:parsedGEResults];
	}
    
	return self;
}

- (NSDictionary *)dictionaryRepresentation {
	NSMutableDictionary *mutableDict = [NSMutableDictionary dictionary];
	NSMutableArray *tempArrayForResults = [NSMutableArray array];
	for (NSObject *subArrayObject in self.results) {
		if ([subArrayObject respondsToSelector:@selector(dictionaryRepresentation)]) {
			// This class is a model object
			[tempArrayForResults addObject:[subArrayObject performSelector:@selector(dictionaryRepresentation)]];
		}
		else {
			// Generic object
			[tempArrayForResults addObject:subArrayObject];
		}
	}
	[mutableDict setValue:[NSArray arrayWithArray:tempArrayForResults] forKey:@"kGEAutoCompleteJSONResults"];
    
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
    
	self.results = [aDecoder decodeObjectForKey:kGEAutoCompleteJSONResults];
	return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder {
	[aCoder encodeObject:_results forKey:kGEAutoCompleteJSONResults];
}

@end
