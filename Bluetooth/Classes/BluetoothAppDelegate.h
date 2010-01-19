//
//  BluetoothAppDelegate.h
//  Bluetooth
//
//  Created by Brandon Coston on 9/10/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class BluetoothViewController;

@interface BluetoothAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    BluetoothViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet BluetoothViewController *viewController;

@end

