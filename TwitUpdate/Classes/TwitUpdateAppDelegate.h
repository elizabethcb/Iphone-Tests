//
//  TwitUpdateAppDelegate.h
//  TwitUpdate
//
//  Created by Brandon Trebitowski on 7/8/09.
//  Copyright iCodeBlog.com 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TwitUpdateViewController;

@interface TwitUpdateAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    TwitUpdateViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet TwitUpdateViewController *viewController;

@end

