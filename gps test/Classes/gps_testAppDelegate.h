//
//  gps_testAppDelegate.h
//  gps test
//
//  Created by Brandon Coston on 6/26/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class gps_testViewController;

@interface gps_testAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    gps_testViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet gps_testViewController *viewController;

@end

