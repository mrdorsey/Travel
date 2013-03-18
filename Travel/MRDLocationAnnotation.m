//
//  MRDLocationAnnotation.m
//  Travel
//
//  Created by Michael Dorsey on 3/17/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDLocationAnnotation.h"
#import "CLLocation+MRDExtensions.h"

@interface MRDLocationAnnotation ()

@property (nonatomic, strong, readwrite) CLLocation *location;

@end

@implementation MRDLocationAnnotation

- (id)initWithLocation:(CLLocation *)location;
{
	if (!(self = [super init])) {
		return nil;
	}
	
	if (location == nil) {
		return nil;
	}
	
	self.location = location;
	
	return self;
}

#pragma mark - MKAnnotation
- (CLLocationCoordinate2D)coordinate;
{
	return self.location.coordinate;
}

- (NSString *)title;
{
	return self.location.coordinateString;
}

- (NSString *)subtitle;
{
	return self.location.timestampString;
}

@end
