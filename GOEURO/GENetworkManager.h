//
//  GENetworkManager.h
//  GOEURO
//
//  Created by Mohamed Mokhles Waly on 11/16/13.
//  Copyright (c) 2013 MOKH. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AFHttpClient.h"
@interface GENetworkManager : NSObject

/**
 *  Singelton instance retrieval
 *
 *  @return single intance of the object
 */
+ (GENetworkManager *)globalNetworkManager;


/**
 *  List of parsed places retrieved through invoking the keywork typed by the user
 *
 *  @param keyword keyword typed from any of the textfields
 *
 *  @return operation perfromed
 */

- (NSOperation *)getListOfNearbyPlace:(NSString *)keyword;

/**
 *  Stop current requests in the queue , specially for fast typed words
 */
- (void)cancelNetworkRequests;

@property (nonatomic, strong) AFHTTPClient *getJSON;
@end
