//
//  gps_testAppDelegate.m
//  gps test
//
//  Created by Brandon Coston on 6/26/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import "gps_testAppDelegate.h"
#import "gps_testViewController.h"

@implementation gps_testAppDelegate

@synthesize window;
@synthesize viewController;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
    [window addSubview:viewController.view];
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [viewController release];
    [window release];
    [super dealloc];
}


@end
