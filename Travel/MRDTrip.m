//
//  MRDTrip.m
//  Travel
//
//  Created by Michael Dorsey on 3/11/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDTrip.h"

@interface MRDTrip ()

@property (nonatomic, strong) NSMutableArray *locations;

@end

@implementation MRDTrip

- (id)init;
{
	if (!(self = [super init])) {
		return nil;
	}
	
	self.locations = [NSMutableArray array];
	
	return self;
}

- (NSArray *)allLocations;
{
	return [self.locations copy];
}

- (void)addLocation:(CLLocation *)location;
{
	[self.locations addObject:location];
}

- (NSString *)displayName;
{
	CLLocation *lastLocation = [self.locations lastObject];
	if (lastLocation == nil) {
		return NSLocalizedString(@"Trip", nil);
	}
	
	return [NSString stringWithFormat:NSLocalizedString(@"Trip %@", nil), [[self _dateFormatter] stringFromDate:lastLocation.timestamp]];
}

- (CLLocationDistance)totalDistance;
{
	CLLocationDistance result = 0.0;
	for (NSUInteger idx = 1; idx < self.locations.count; idx++) {
		result += [self.locations[idx] distanceFromLocation:self.locations[idx - 1]];
	}
	
	return result;
}

- (NSString *)totalDistanceStr;
{
	return [NSString stringWithFormat:@"%.2f m", self.totalDistance];
}

#pragma mark - private helpers
- (NSDateFormatter *)_dateFormatter;
{
	static NSDateFormatter *_sharedFormatter;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_sharedFormatter = [[NSDateFormatter alloc] init];
		_sharedFormatter.timeStyle = NSDateFormatterNoStyle;
		_sharedFormatter.dateStyle = NSDateFormatterMediumStyle;
	});
	
	return _sharedFormatter;
}

@end
