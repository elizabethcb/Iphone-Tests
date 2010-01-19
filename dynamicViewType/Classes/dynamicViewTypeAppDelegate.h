//
//  dynamicViewTypeAppDelegate.h
//  dynamicViewType
//
//  Created by Brandon Coston on 12/17/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class dynamicViewTypeViewController;

@interface dynamicViewTypeAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    dynamicViewTypeViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet dynamicViewTypeViewController *viewController;

@end

