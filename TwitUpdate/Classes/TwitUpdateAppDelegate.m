//
//  TwitUpdateAppDelegate.m
//  TwitUpdate
//
//  Created by Brandon Trebitowski on 7/8/09.
//  Copyright iCodeBlog.com 2009. All rights reserved.
//

#import "TwitUpdateAppDelegate.h"
#import "TwitUpdateViewController.h"

@implementation TwitUpdateAppDelegate

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
