//
//  GEAutoCompleteViewController.h
//  GOEURO
//
//  Created by Mohamed Mokhles Waly on 11/16/13.
//  Copyright (c) 2013 MOKH. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol autoCompleteDelegate <NSObject>

@required
- (void)neabryPlaceSelected:(NSString *)nearby;
- (void)removeList:(BOOL)actionValue;
- (void)focusOnTable:(BOOL)actionValue;

@end


@interface GEAutoCompleteViewController : UITableViewController<UIGestureRecognizerDelegate>


@property (nonatomic, strong) NSMutableArray *arrayOfNearbyPlaces;
@property (nonatomic, weak) id <autoCompleteDelegate> autoCompleteDelegate;
@end
