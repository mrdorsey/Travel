//
//  MRDTripManager.h
//  Travel
//
//  Created by Michael Dorsey on 3/11/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import <Foundation/Foundation.h>

@class MRDTrip;

@interface MRDTripManager : NSObject

+ (MRDTripManager *)sharedManager;

- (void)addTrip:(MRDTrip *)trip;
- (void)removeTrip:(MRDTrip *)trip;

- (NSArray *)allTrips;

@end