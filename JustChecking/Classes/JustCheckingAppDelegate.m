//
//  JustCheckingAppDelegate.m
//  JustChecking
//
//  Created by Brandon Coston on 7/14/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import "JustCheckingAppDelegate.h"
#import "JustCheckingViewController.h"

@implementation JustCheckingAppDelegate

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
