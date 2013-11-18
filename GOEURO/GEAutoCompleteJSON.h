//
//  GEAutoCompleteJSON.h
//
//  Created by Mac Book Pro on 11/17/13
//  Copyright (c) 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>



@interface GEAutoCompleteJSON : NSObject <NSCoding>

@property (nonatomic, strong) NSArray *results;

+ (GEAutoCompleteJSON *)modelObjectWithDictionary:(NSDictionary *)dict;
- (instancetype)initWithDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end
