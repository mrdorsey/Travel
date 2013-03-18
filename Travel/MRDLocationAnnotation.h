//
//  MRDLocationAnnotation.h
//  Travel
//
//  Created by Michael Dorsey on 3/17/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>

@interface MRDLocationAnnotation : NSObject <MKAnnotation>

- (id)initWithLocation:(CLLocation *)location;

@property (nonatomic, readonly) CLLocation *location;

@end
