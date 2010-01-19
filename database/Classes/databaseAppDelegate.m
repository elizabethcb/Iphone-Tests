//
//  databaseAppDelegate.m
//  database
//
//  Created by Brandon Coston on 6/11/09.
//  Copyright 2009 Slate Technologies LLC. All rights reserved.
//

#import "databaseAppDelegate.h"
#import "contact.h"

@interface databaseAppDelegate (private)
- (void) checkAndCreateDatabase;
- (void) readDataFromDatabase;
@end

@implementation databaseAppDelegate

@synthesize window, inController, outController, tabBarController, contactArray;


- (void)applicationDidFinishLaunching:(UIApplication *)application {
	
	//initialize count info with 0
	contactCount = 0;
	currentContact = 0;
	
	//set database name
	databaseName = @"data.sql";
	
	
	// Get the path to the documents directory and append databaseName
	NSArray *documentPaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *documentsDir = [documentPaths objectAtIndex:0];
	databasePath = [documentsDir stringByAppendingPathComponent:databaseName];
	
	//set up and initialize databse
	[self checkAndCreateDatabase];
	[self readDataFromDatabase];
	contactCount = [contactArray count];
	
	//set up Tab Bar
	tabBarController = [[UITabBarController alloc] init];
	
	//prepare each veiw for the tabBarController
	inController = [[inputController alloc] init];
	UINavigationController *tableNavController = [[[UINavigationController alloc] initWithRootViewController:inController] autorelease];
	[inController release];
	outController = [[outputController alloc] init];
	UINavigationController *table2NavController = [[[UINavigationController alloc] initWithRootViewController:outController] autorelease];
	[outController release];
	 
	//set views for each tab in tabBarController
	tabBarController.viewControllers = [NSArray arrayWithObjects:tableNavController, table2NavController, nil];
	 
	//make current window the tabBarController
	[window addSubview:tabBarController.view];
	
    // Override point for customization after application launch
    [window makeKeyAndVisible];
}


- (void)dealloc {
	[contactArray release];
    [window release];
    [super dealloc];
}

//checks if database is in filesystem and creates it if isn't
-(void) checkAndCreateDatabase{
	BOOL success;
	
	// Create a FileManager object to check the status of database and copy if required
	NSFileManager *fileManager = [NSFileManager defaultManager];
	
	// Check if the database has already been created in the users filesystem
	success = [fileManager fileExistsAtPath:databasePath];
	
	if(success) return;
	
	// If not, copy the database to filesystem
	
	// Get the path to the database in the application package
	NSString *databasePathFromApp = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:databaseName];
	
	// Copy the database from the package to the users filesystem
	[fileManager copyItemAtPath:databasePathFromApp toPath:databasePath error:nil];
	[fileManager release];
}

//Put database in Array in memory
-(void) readDataFromDatabase{
	sqlite3 *database;
	
	// Init the Array
	contactArray = [[NSMutableArray alloc] init];
	
	// Open the database from the users filessytem
	if(sqlite3_open([databasePath UTF8String], &database) == SQLITE_OK) {
		// Setup the SQL Statement and compile it for faster access
		const char *sqlStatement = "select * from contacts";
		sqlite3_stmt *compiledStatement;
		if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
			// Loop through the results and add them to the feeds array
			while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
				// Read the data from the result row
				NSString *fName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 1)];
				NSString *lname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 2)];
				NSString *address = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 3)];
				NSString *city = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 4)];
				NSString *state = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 5)];
				NSString *zip = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 6)];
				NSString *phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(compiledStatement, 7)];
				
				// Create a new contact object with the data from the database
				contact *curr = [[contact alloc] initWithName:fName last:lname address:address city:city state:state zipcode:zip phone:phone];

				// Add the contact object to contactArray
				[contactArray addObject:curr];
				[curr release];
			}
		}
		// Release the compiled statement from memory
		sqlite3_finalize(compiledStatement);
		
	}
	sqlite3_close(database);
}

@end
