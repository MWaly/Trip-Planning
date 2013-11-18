//
//  GENetworkManager.m
//  GOEURO
//
//  Created by Mohamed Mokhles Waly on 11/16/13.
//  Copyright (c) 2013 MOKH. All rights reserved.
//

#import "GENetworkManager.h"
#import "AFNetworking.h"
#import "GENotifications.h"



@implementation GENetworkManager

static GENetworkManager *networkManager = nil;


#pragma mark - Initilization - 
+ (GENetworkManager *) globalNetworkManager
{
    
    @synchronized(self) {
        if (networkManager == nil) {
            networkManager = [[GENetworkManager alloc] init];
        
        }
    }
    return networkManager;

}

#pragma mark - Operations -

- (NSOperation *) getListOfNearbyPlace:(NSString*)keyword
{
    [self cancelNetworkRequests];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",LocationsURL,keyword]]];
    
    
    
    return [_getJSON HTTPRequestOperationWithRequest:request success:^(AFHTTPRequestOperation *operation, id responseObject)
    {
        if ([operation hasAcceptableStatusCode]) {
            
       
        id responseObject = [NSJSONSerialization JSONObjectWithData:operation.responseData options:NSJSONReadingAllowFragments error:NULL];

        NSLog(@"Operation response is %@",responseObject);
        NSLog(@"Operation response string is %@",operation.responseString);
        [[NSNotificationCenter defaultCenter] postNotificationName:GENetworkDidRetrieveLocations object:nil userInfo:(NSDictionary*)responseObject];
        }
    } failure:^(AFHTTPRequestOperation *operation, NSError *error)
    {
    NSLog(@"Operation error string is %@",error.localizedDescription);
    NSLog(@"Operation error string is %@",operation.error.localizedFailureReason);

}];
    

}
- (void) cancelNetworkRequests
{

    [[self.getJSON operationQueue] cancelAllOperations];
}

- (AFHTTPClient *)getJSON {
    
    if (!_getJSON)
    {
        _getJSON=[[AFHTTPClient alloc]initWithBaseURL:[NSURL URLWithString:LocationsURL]];
        [_getJSON registerHTTPOperationClass:[AFJSONRequestOperation class]];
        [_getJSON setDefaultHeader:@"Accept" value:@"text/html,application/xhtml+xml,application/xml,application/json;charset=utf-8;q=0.9,*/*;q=0.8"];
        [_getJSON setDefaultHeader:@"Content-Type" value:@"application/json"];
        [_getJSON setDefaultHeader:@"Accept-Charset" value:@"utf-8"];
    }
    
    return _getJSON;
}

@end
