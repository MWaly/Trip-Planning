//
//  GEViewController.m
//  GOEURO
//
//  Created by Mohamed Mokhles Waly on 11/15/13.
//  Copyright (c) 2013 MOKH. All rights reserved.
//

#import "GEViewController.h"
#import "AFNetworking.h"
#import "Constants.h"
#import "AFHTTPRequestOperation.h"
#import "GENetworkManager.h"
#import "GEAutoCompleteViewController.h"

@interface GEViewController ()


@property (nonatomic, strong) WYPopoverController *popover;
@property (nonatomic, strong) GEAutoCompleteViewController *autoController;

/**
 *  Initialization method to get current location of user as a default value for the "TO" textfield
 */
- (void)setupGeocoding;
@end

@implementation GEViewController
UITextField *currentTextField;
- (void)viewDidLoad {
	[super viewDidLoad];
	/**
	 *  Get the current location and make it the default value for the FROM textfield
	 */
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRetrieveLocations:) name:GEVCDidRetrieveLocations object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(didRetrieveLocationsError:) name:GEVCDidRetrieveLocationsError object:nil];
	[self setupGeocoding];
	_autoController = [[GEAutoCompleteViewController alloc]initWithStyle:UITableViewStylePlain];
	_autoController.autoCompleteDelegate = self;
	_popover = [[WYPopoverController alloc]initWithContentViewController:_autoController];
	_popover.delegate = self;
}

- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

- (IBAction)searchAction:(id)sender {
	UIAlertView *alertView = [[UIAlertView alloc]initWithTitle:@"Trip Planner" message:NSLocalizedString(@"Search Not Implemented Yet", @"Search Not Implemented Yet") delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[alertView show];
}

#pragma mark - Geocoding stuff -

- (void)setupGeocoding {
	CLLocationManager *locationManager = [[CLLocationManager alloc]init];
	[_fromAc startAnimating];
	locationManager.delegate = self;
    
	[locationManager startUpdatingLocation];
	[[GEController appController] setValue:locationManager.location forKey:@"currentLocation"];
	CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    
	[geocoder reverseGeocodeLocation:locationManager.location
	               completionHandler: ^(NSArray *placemarks, NSError *error) {
                       [_fromAc stopAnimating];
                       if (error) {
                           NSLog(@"Geocode failed with error: %@", error);
                           [_fromAc stopAnimating];
                           return;
                       }
                       if (placemarks.count > 0) {
                           CLPlacemark *placeMark = [placemarks firstObject];
                           _fromTextField.text = [NSString stringWithFormat:@"%@,%@", placeMark.administrativeArea, placeMark.country];
                       }
                       else
                           _fromTextField.text = @"";
                   }];
}

#pragma mark - Textfield Stuff -

- (void)startSearching:(UITextField *)textField {
	if (textField == _toTextField)
		[_toAc startAnimating];
	else
		[_fromAc startAnimating];
    
	[[GEController appController] getNearbyList:textField.text];
}

- (IBAction)valueChangedForTextfield:(UITextField *)sender {
	[self startSearching:sender];
	// Making sure that popover is visible
	if (![_popover isPopoverVisible] && [_autoController.arrayOfNearbyPlaces count] > 0) {
		[_popover presentPopoverFromRect:currentTextField.frame inView:sender.superview permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
	}
	if ([sender.text length] <= 1) {
		[_popover dismissPopoverAnimated:YES];
	}
}

- (void)textFieldDidBeginEditing:(UITextField *)textField {
	currentTextField = textField;
	if ([textField.text length]>1) {
        [self startSearching:textField];
	}
    else{
        [_autoController.arrayOfNearbyPlaces removeAllObjects];
        [_autoController.tableView reloadData];
    }
	[_popover presentPopoverFromRect:textField.frame inView:textField.superview permittedArrowDirections:WYPopoverArrowDirectionAny animated:YES];
}

- (void)textFieldDidEndEditing:(UITextField *)textField {
	[currentTextField resignFirstResponder];
}

#pragma mark - Handling Locations Updates -

- (void)didRetrieveLocations:(NSNotification *)notif {
	NSArray *arrayOfSuggestedPlaces = [[notif userInfo] objectForKey:@"value"];
	[_autoController.arrayOfNearbyPlaces setArray:arrayOfSuggestedPlaces];
	[_autoController.tableView reloadData];
	NSLog(@"The retrieved array are %@", arrayOfSuggestedPlaces);
	[_toAc stopAnimating];
	[_fromAc stopAnimating];
}

- (void)didRetrieveLocationsError:(NSNotification *)notif {
	//No actual handling currently
	[_autoController.tableView reloadData];
	[_toAc stopAnimating];
	[_fromAc stopAnimating];
}

#pragma mark - Auto complete Delegate -
- (void)neabryPlaceSelected:(NSString *)nearby {
	currentTextField.text = nearby;
}

- (void)removeList:(BOOL)actionValue {
	[_autoController.arrayOfNearbyPlaces removeAllObjects];
	[_autoController.tableView reloadData];
	[_popover dismissPopoverAnimated:YES];
}

- (void)focusOnTable:(BOOL)actionValue {
	[currentTextField resignFirstResponder];
}

#pragma mark - Popover delegate -

- (void)popoverControllerDidDismissPopover:(WYPopoverController *)popoverController {
	//Handling dismissal and cancellation of popover
	[self removeList:YES];
}

- (BOOL)popoverControllerShouldDismissPopover:(WYPopoverController *)popoverController {
	return YES;
}

@end
