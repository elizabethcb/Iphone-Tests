//
//  databaseAppDelegate.h
//  database
//
//  Created by Brandon Coston on 6/11/09.
//  Copyright 2009 Slate Technologies LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>
@class inputController;
@class outputController;

@interface databaseAppDelegate : NSObject <UIApplicationDelegate> {
	//interface items
    UIWindow *window;
	UITabBarController *tabBarController;
	inputController *inController;
	outputController *outController;
	
	//Database variables
	NSString *databaseName;
	NSString *databasePath;
	
	//Array to store contact objects and ints to keep track of contacts
	NSMutableArray *contactArray;
	int contactCount;
	int currentContact;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) inputController *inController;
@property (nonatomic, retain) outputController *outController;
@property (nonatomic, retain) NSMutableArray *contactArray;



@end

