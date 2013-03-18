//
//  MRDViewController.m
//  Travel
//
//  Created by Michael Dorsey on 3/9/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDViewController.h"

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MRDAnnotation : NSObject <MKAnnotation>

@property (nonatomic, assign) CLLocationCoordinate2D coordinate;
@property (nonatomic, copy) NSDate *dateCreated;

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

@end

@implementation MRDAnnotation

- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;
{
    if (!(self = [super init]))
        return nil;
    
    self.coordinate = coordinate;
    self.dateCreated = [NSDate date];
    
    return self;
}

@end

@interface MRDViewController () <CLLocationManagerDelegate>

@property (nonatomic, weak) IBOutlet UILabel *latitudeLabel;
@property (nonatomic, weak) IBOutlet UILabel *longitudeLabel;
@property (nonatomic, weak) IBOutlet MKMapView *mapView;

@property (nonatomic, strong) CLLocationManager *locationManager;
@property (nonatomic, copy) CLLocation *lastLocation;

@end

@implementation MRDViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if ([CLLocationManager locationServicesEnabled] &&
        ([CLLocationManager authorizationStatus] != kCLAuthorizationStatusRestricted &&
         [CLLocationManager authorizationStatus] != kCLAuthorizationStatusDenied)) {
            self.locationManager = [[CLLocationManager alloc] init];
            self.locationManager.delegate = self;
            self.locationManager.distanceFilter = kCLDistanceFilterNone;
            self.locationManager.desiredAccuracy = kCLLocationAccuracyBest;
            [self.locationManager startUpdatingLocation];
        }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (IBAction)findMe:(id)sender;
{
    self.mapView.showsUserLocation = YES;
    self.mapView.userTrackingMode = MKUserTrackingModeFollow;
}

- (IBAction)annotate:(id)sender;
{
    MRDAnnotation *annotation = [[MRDAnnotation alloc] initWithCoordinate:self.lastLocation.coordinate];
    [self.mapView addAnnotation:annotation];
}

#pragma mark - CLLocationManagerDelegate

- (void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations;
{
    CLLocation *location = [locations lastObject];
    self.latitudeLabel.text = [NSString stringWithFormat:@"%.6f", location.coordinate.latitude];
    self.longitudeLabel.text = [NSString stringWithFormat:@"%.6f", location.coordinate.longitude];
    self.lastLocation = location;
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error;
{
    self.latitudeLabel.text = @"Error";
    self.longitudeLabel.text = @"Error";
    NSLog(@"error: %@", [error localizedDescription]);
    [self.locationManager stopUpdatingLocation];
}

@end
