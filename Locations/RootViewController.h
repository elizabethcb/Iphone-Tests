//
//  RootViewController.h
//  Locations
//
//  Created by Brandon Coston on 11/16/09.
//  Copyright 2009 Slate Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>



@interface RootViewController : UITableViewController <CLLocationManagerDelegate> {

    NSMutableArray *eventsArray;
    NSManagedObjectContext *managedObjectContext;
	
    CLLocationManager *locationManager;
    UIBarButtonItem *addButton;
}

@property (nonatomic, retain) NSMutableArray *eventsArray;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@property (nonatomic, retain) CLLocationManager *locationManager;
@property (nonatomic, retain) UIBarButtonItem *addButton;

- (void)addEvent;

@end