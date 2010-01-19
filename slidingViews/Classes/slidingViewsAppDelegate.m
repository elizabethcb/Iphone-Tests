//
//  slidingViewsAppDelegate.m
//  slidingViews
//
//  Created by Brandon Coston on 12/10/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import "slidingViewsAppDelegate.h"

@implementation slidingViewsAppDelegate

@synthesize window;


- (void)applicationDidFinishLaunching:(UIApplication *)application {    

    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
    [window release];
    [super dealloc];
}


@end
