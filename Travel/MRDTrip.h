//
//  MRDTrip.h
//  Travel
//
//  Created by Michael Dorsey on 3/11/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MRDTrip : NSObject

- (NSArray *)allLocations;
- (void)addLocation:(CLLocation *)location;

- (NSString *)displayName;

- (CLLocationDistance)totalDistance;
- (NSString *)totalDistanceStr;

@end
