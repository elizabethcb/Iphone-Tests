//
//  heruhoiAppDelegate.h
//  heruhoi
//
//  Created by Brandon Coston on 9/16/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

@interface heruhoiAppDelegate : NSObject <UIApplicationDelegate> {
    
    UIWindow *window;
    UINavigationController *navigationController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

@end

