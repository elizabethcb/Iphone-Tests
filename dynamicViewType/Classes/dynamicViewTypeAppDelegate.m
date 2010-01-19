//
//  dynamicViewTypeAppDelegate.m
//  dynamicViewType
//
//  Created by Brandon Coston on 12/17/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import "dynamicViewTypeAppDelegate.h"
#import "dynamicViewTypeViewController.h"

@implementation dynamicViewTypeAppDelegate

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
