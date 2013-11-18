//
//  GEViewController.h
//  GOEURO
//
//  Created by Mohamed Mokhles Waly on 11/15/13.
//  Copyright (c) 2013 MOKH. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WYPopoverController.h"
#import "GEAutoCompleteViewController.h"
@import CoreLocation;

@interface GEViewController : UIViewController <UITextFieldDelegate, CLLocationManagerDelegate ,WYPopoverControllerDelegate ,autoCompleteDelegate>

@property (weak, nonatomic) IBOutlet UITextField *fromTextField;
@property (weak, nonatomic) IBOutlet UITextField *toTextField;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *fromAc;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *toAc;
- (IBAction)searchAction:(id)sender;
- (IBAction)valueChangedForTextfield:(UITextField *)sender;

@end
