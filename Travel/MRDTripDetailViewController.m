//
//  MRDTripDetailViewController.m
//  Travel
//
//  Created by Michael Dorsey on 3/17/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDTripDetailViewController.h"

#import "CLLocation+MRDExtensions.h"
#import "MRDTrip.h"

@interface MRDTripDetailViewController ()

@end

@implementation MRDTripDetailViewController

- (void)setTrip:(MRDTrip *)trip;
{
	_trip = trip;
	[self.tableView reloadData];
}

#pragma mark - UIViewController subclass
- (void)viewDidLoad
{
    [super viewDidLoad];
    
	self.title = self.trip.displayName;
}

# pragma mark - NSTableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
	return self.trip.allLocations.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
	}
	
	static NSDateFormatter *dateFormatter;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		dateFormatter = [[NSDateFormatter alloc] init];
		dateFormatter.dateStyle = NSDateFormatterShortStyle;
		dateFormatter.timeStyle = NSDateFormatterMediumStyle;
	});
	
	CLLocation *location = [self.trip allLocations][indexPath.row];
	cell.textLabel.text = [location coordinateString];
	cell.detailTextLabel.text = [dateFormatter stringFromDate:location.timestamp];
	
	return cell;
}

- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	return nil;  // no selection
}

@end
