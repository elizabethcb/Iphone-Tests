//
//  heruhoiAppDelegate.m
//  heruhoi
//
//  Created by Brandon Coston on 9/16/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import "heruhoiAppDelegate.h"
#import "RootViewController.h"


@implementation heruhoiAppDelegate

@synthesize window;
@synthesize navigationController;


#pragma mark -
#pragma mark Application lifecycle

- (void)applicationDidFinishLaunching:(UIApplication *)application {    
    
    // Override point for customization after app launch    
	
	[window addSubview:[navigationController view]];
    [window makeKeyAndVisible];
}


- (void)applicationWillTerminate:(UIApplication *)application {
	// Save data if appropriate
}


#pragma mark -
#pragma mark Memory management

- (void)dealloc {
	[navigationController release];
	[window release];
	[super dealloc];
}


@end

