//
//  MRDTripManager.m
//  Travel
//
//  Created by Michael Dorsey on 3/11/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "MRDTripManager.h"

@interface MRDTripManager ()

@property (nonatomic, strong) NSMutableArray *trips;

@end

@implementation MRDTripManager

+ (MRDTripManager *)sharedManager;
{
	static MRDTripManager *_manager;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		_manager = [[MRDTripManager alloc] init];
	});
	
	return _manager;
}

- (id)init;
{
	if (!(self = [super init])) {
		return nil;
	}
	
	self.trips = [NSMutableArray array];
	
	return self;
}

- (void)addTrip:(MRDTrip *)trip;
{
	[self.trips addObject:trip];
}

- (void)removeTrip:(MRDTrip *)trip;
{
	[self.trips removeObject:trip];
}

- (NSArray *)allTrips;
{
	return [self.trips copy];
}

@end
