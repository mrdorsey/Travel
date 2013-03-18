//
//  MRDMapViewController.m
//  Travel
//
//  Created by Michael Dorsey on 3/10/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDLocationAnnotation.h"
#import "MRDMapViewController.h"
#import "MRDTrip.h" 
#import "MRDTripManager.h"

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MRDMapViewController () <CLLocationManagerDelegate, MKMapViewDelegate, UIActionSheetDelegate>

@property (nonatomic, assign) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CLLocationManager *locationManager;

@property (nonatomic, strong) UIBarButtonItem *currentLocationButtonItem;
@property (nonatomic, strong) UIBarButtonItem *startStopButtonItem;

@property (nonatomic, strong) MRDTrip *currentTrip;

@end

@implementation MRDMapViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	self.locationManager = [[CLLocationManager alloc] init];
	self.locationManager.delegate = self;
	self.locationManager.distanceFilter = 10000.0;
	self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
	
	self.mapView.showsUserLocation = YES;

	self.startStopButtonItem = [[UIBarButtonItem alloc]
								initWithTitle:NSLocalizedString(@"Start", nil)
								style:UIBarButtonItemStyleBordered
								target:self
								action:@selector(_startTracking:)];
	self.navigationItem.rightBarButtonItem = self.startStopButtonItem;
	
	self.currentLocationButtonItem = [[UIBarButtonItem alloc]
									  initWithBarButtonSystemItem:UIBarButtonSystemItemRefresh
									  target:self
									  action:@selector(_findLocation:)];
	self.navigationItem.leftBarButtonItem = self.currentLocationButtonItem;
	
	self.navigationController.tabBarItem = [[UITabBarItem alloc] initWithTitle:NSLocalizedString(@"Map", nil) image:nil tag:0];
}

- (void)viewWillAppear:(BOOL)animated;
{
	[super viewWillAppear:animated];
}
- (void)viewDidAppear:(BOOL)animated;
{
	[super viewDidAppear:animated];
	
	[self _findLocation:nil];
}

- (IBAction)refreshLocation:(id)sender;
{
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
{
    NSAssert(locations.count > 0, @"Expected some  locations");
	
	for (CLLocation *location in locations) {
		[self.currentTrip addLocation:location];
		[self.mapView addAnnotation:[[MRDLocationAnnotation alloc] initWithLocation:location]];
	}
	
	self.navigationItem.title = self.currentTrip.totalDistanceStr;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
{
    [self _stopTrackingAndSave:YES];
}

#pragma mark - MKMapViewDelegate

- (MKAnnotationView *)mapView:(MKMapView *)mapView viewForAnnotation:(id<MKAnnotation>)annotation;
{
	if (![(NSObject *)annotation isKindOfClass:[MRDLocationAnnotation class]]) {
		return nil; // don't know this annotation
	}
	
	CLLocation *location = [(MRDLocationAnnotation *)annotation location];
	
	static NSString *MRDAnnotationIdentifier = @"MRDAnnotationIdentifier";
	
	MKAnnotationView *annotationView = [mapView dequeueReusableAnnotationViewWithIdentifier:MRDAnnotationIdentifier];
	if (annotationView == nil) {
		annotationView = [[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:MRDAnnotationIdentifier];
	}
	
	NSAssert([annotationView  isKindOfClass:[MKPinAnnotationView class]], @"Expected a pin annotation");
	MKPinAnnotationView *pinView = (MKPinAnnotationView *)annotationView;
	
	pinView.animatesDrop = YES;
	pinView.pinColor = ([self.currentTrip.allLocations indexOfObject:location] == 0) ?
		MKPinAnnotationColorGreen : MKPinAnnotationColorRed;
	pinView.canShowCallout = YES;
	
	return pinView;
}

#pragma mark - UIActionSheetDelegate

- (void)actionSheet:(UIActionSheet *)actionSheet willDismissWithButtonIndex:(NSInteger)buttonIndex;
{
	if (buttonIndex == actionSheet.cancelButtonIndex) {
		// save data, cancel saves here
		[self _stopTrackingAndSave:YES];
	}
	else if (buttonIndex == actionSheet.destructiveButtonIndex) {
		[self _stopTrackingAndSave:NO];
	}
}

#pragma mark - private helpers
- (void)_findLocation:(id)sender;
{
	[self.mapView setUserTrackingMode:MKUserTrackingModeFollow animated:YES];
}

- (void)_startTracking:(id)sender;
{
	if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted &&
         [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)) {
			[self.locationManager startUpdatingLocation];
		}
	
	self.currentTrip = [[MRDTrip alloc] init];
	
	self.startStopButtonItem.title = NSLocalizedString(@"Stop", nil);
	self.startStopButtonItem.action = @selector(_stopTracking:);
}

- (void)_stopTracking:(id)sender;
{
	[self.locationManager stopUpdatingLocation];
	
	self.startStopButtonItem.title = NSLocalizedString(@"Start", nil);
	self.startStopButtonItem.action = @selector(_startTracking:);
	
	UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:NSLocalizedString(@"Save Trip?", nil)
											  delegate:self
											  cancelButtonTitle:NSLocalizedString(@"Save", nil)
											  destructiveButtonTitle:NSLocalizedString(@"Discard", nil)
											  otherButtonTitles:nil];
	[sheet showFromTabBar:self.tabBarController.tabBar];
}

- (void)_stopTrackingAndSave:(BOOL)save;
{
	if (save) {
		[[MRDTripManager sharedManager] addTrip:self.currentTrip];
	}
	
	self.currentTrip = nil;
	self.navigationItem.title = nil; 
}

@end
