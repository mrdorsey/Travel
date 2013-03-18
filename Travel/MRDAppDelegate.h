//
//  MRDAppDelegate.h
//  Travel
//
//  Created by Michael Dorsey on 3/9/13.
//  Copyright (c) 2013 Michael Dorsey. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MRDViewController;
@class MRDMapViewController;
@class MRDTableViewController;

@interface MRDAppDelegate : UIResponder <UIApplicationDelegate, UITabBarControllerDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) UITabBarController *tabBarController;
@property (strong, nonatomic) MRDMapViewController *mapViewController;
@property (strong, nonatomic) MRDTableViewController *tableViewController;

@end
