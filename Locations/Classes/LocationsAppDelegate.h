//
//  LocationsAppDelegate.h
//  Locations
//
//  Created by Brandon Coston on 11/16/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

@interface LocationsAppDelegate : NSObject <UIApplicationDelegate> {

    NSManagedObjectModel *managedObjectModel;
    NSManagedObjectContext *managedObjectContext;	    
    NSPersistentStoreCoordinator *persistentStoreCoordinator;
	
	UINavigationController *navigationController;

    UIWindow *window;
}

@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;

@property (nonatomic, retain) UINavigationController *navigationController;

@property (nonatomic, retain) IBOutlet UIWindow *window;

//- (IBAction)saveAction:sender;

- (NSString *)applicationDocumentsDirectory;

@end

