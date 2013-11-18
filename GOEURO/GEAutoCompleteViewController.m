//
//  GEAutoCompleteViewController.m
//  GOEURO
//
//  Created by Mohamed Mokhles Waly on 11/16/13.
//  Copyright (c) 2013 MOKH. All rights reserved.
//

#import "GEAutoCompleteViewController.h"
#import "GEPlace.h"
@interface GEAutoCompleteViewController ()
@property (nonatomic,strong)UIPanGestureRecognizer *pan;
@end

@implementation GEAutoCompleteViewController

- (id)initWithStyle:(UITableViewStyle)style {
	self = [super initWithStyle:style];
	if (self) {
    self.arrayOfNearbyPlaces = [@[] mutableCopy];
	}
	return self;
}

- (void)viewDidLoad {
	[super viewDidLoad];
    //required to detect when user begins to touch the tableview to dismiss keyboard
   _pan = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(didPanOnTableView:)];
    _pan.delegate=self;

	
	[self.tableView reloadData];
}

-(void)viewWillAppear:(BOOL)animated
{
    if (![self.tableView.gestureRecognizers containsObject:_pan]) {
        [self.tableView addGestureRecognizer:_pan];
    }
}
- (void)viewWillDisappear:(BOOL)animated
{
    if ([self.tableView.gestureRecognizers containsObject:_pan]) {
        [self.tableView removeGestureRecognizer:_pan];
    }
}
- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning];
	// Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source - 

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	// Return the number of rows in the section.
	return [self.arrayOfNearbyPlaces count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"CELL"];
    
    if (cell==nil) {
        cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"CELL"];
    }
    
	GEPlace *place=[self.arrayOfNearbyPlaces objectAtIndex:indexPath.row];
    cell.textLabel.text=place.placeName;
    cell.detailTextLabel.text=[NSString stringWithFormat:@"%0.1f KM",[place.distanceFromCurrentLocation doubleValue]];
    
	return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
	NSString *nearbyPlace = [[self.arrayOfNearbyPlaces objectAtIndex:indexPath.row] placeName];
	[self.autoCompleteDelegate neabryPlaceSelected:nearbyPlace];
	[self.autoCompleteDelegate removeList:YES];
}


- (void) didPanOnTableView:(UIPanGestureRecognizer*)panGesture
{
    [self.autoCompleteDelegate focusOnTable:YES];
    [self.tableView removeGestureRecognizer:panGesture];
}
@end
