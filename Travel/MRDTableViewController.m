//
//  MRDTableViewController.m
//  Travel
//
//  Created by Michael Dorsey on 3/10/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDTableViewController.h"
#import "MRDTrip.h"
#import "MRDTripDetailViewController.h"
#import "MRDTripManager.h"

@interface MRDTableViewController ()

@end

@implementation MRDTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
	if (!(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
		return nil;
	}
	
	self.title = NSLocalizedString(@"Trips", nil);
	
	return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

	self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
	
	[self.tableView reloadData];
}

#pragma mark - Table View Data Source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
	return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
	return [[[MRDTripManager sharedManager] allTrips] count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
	static NSString *CellIdentifier = @"Cell";
	UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
	if (cell == nil) {
		cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
		cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
	}
	
	MRDTrip *trip = [[[MRDTripManager sharedManager] allTrips] objectAtIndex:indexPath.row];
	cell.textLabel.text = trip.displayName;
	cell.detailTextLabel.text = trip.totalDistanceStr;
	
	return cell;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath;
{
	if (editingStyle == UITableViewCellEditingStyleInsert) {
		return; // no insert operation
	}
	
	[[MRDTripManager sharedManager] removeTrip:[[MRDTripManager sharedManager] allTrips][indexPath.row]];
	 
	[tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
}
	 
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
	MRDTripDetailViewController *detailViewController = [[MRDTripDetailViewController alloc]
													initWithNibName:@"MRDTripDetailViewController" bundle:nil];
	detailViewController.trip = [[MRDTripManager sharedManager] allTrips][indexPath.row];
	[self.navigationController pushViewController:detailViewController animated:YES];
}

@end
