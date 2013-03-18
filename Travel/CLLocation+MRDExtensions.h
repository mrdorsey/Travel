//
//  CLLocation+MRDExtensions.h
//  Travel
//
//  Created by Michael Dorsey on 3/17/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import <CoreLocation/CoreLocation.h>

@interface CLLocation (MRDExtensions)

- (NSString *)coordinateString;
- (NSString *)timestampString;

@end
