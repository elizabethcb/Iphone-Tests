//
//  BluetoothAppDelegate.m
//  Bluetooth
//
//  Created by Brandon Coston on 9/10/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import "BluetoothAppDelegate.h"
#import "BluetoothViewController.h"

@implementation BluetoothAppDelegate

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
