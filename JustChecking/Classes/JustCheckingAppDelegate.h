//
//  JustCheckingAppDelegate.h
//  JustChecking
//
//  Created by Brandon Coston on 7/14/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class JustCheckingViewController;

@interface JustCheckingAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    JustCheckingViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet JustCheckingViewController *viewController;

@end

