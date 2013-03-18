//
//  CLLocation+MRDExtensions.m
//  Travel
//
//  Created by Michael Dorsey on 3/17/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import "CLLocation+MRDExtensions.h"

@implementation CLLocation (MRDExtensions)

- (NSString *)coordinateString;
{
	return [NSString stringWithFormat:@"(%f, %f)", self.coordinate.latitude, self.coordinate.longitude];
}

- (NSString *)timestampString;
{
	static NSDateFormatter *dateFormatter;
	static dispatch_once_t onceToken;
	dispatch_once(&onceToken, ^{
		dateFormatter = [[NSDateFormatter alloc] init];
		dateFormatter.dateStyle = NSDateFormatterShortStyle;
		dateFormatter.timeStyle = NSDateFormatterMediumStyle;
	});
	
	return [dateFormatter stringFromDate:self.timestamp];
}

@end
