//
//  contact.m
//  database
//
//  Created by Brandon Coston on 6/11/09.
//  Copyright 2009 Slate Technologies LLC. All rights reserved.
//

#import "contact.h"

static sqlite3 *database = nil;
static sqlite3_stmt *addStmt = nil;

@implementation contact
@synthesize fname, lname, address, city, state, zip, phone, isDirty, isDetailViewHydrated;

-(id)initWithValues:(NSString *)f last:(NSString *)l address:(NSString *)a city:(NSString *)c state:(NSString *)s zipcode:(NSString *)z phone:(NSString *)p{
	fname = f;
	lname = l;
	address = a;
	city = c;
	state = s;
	zip = z;
	phone = p;
	
	isDetailViewHydrated = NO;
	
	return self;
}

+ (void) getInitialDataToDisplay:(NSString *)dbPath {
	
	databaseAppDelegate *appDelegate = (databaseAppDelegate *)[[UIApplication sharedApplication] delegate];
	
	if (sqlite3_open([dbPath UTF8String], &database) == SQLITE_OK) {
		
		const char *sql = "select * from contacts";
		sqlite3_stmt *selectstmt;
		if(sqlite3_prepare_v2(database, sql, -1, &selectstmt, NULL) == SQLITE_OK) {
			
			while(sqlite3_step(selectstmt) == SQLITE_ROW) {
				NSString *fName = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 1)];
				NSString *lname = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 2)];
				NSString *address = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 3)];
				NSString *city = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 4)];
				NSString *state = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 5)];
				NSString *zip = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 6)];
				NSString *phone = [NSString stringWithUTF8String:(char *)sqlite3_column_text(selectstmt, 7)];
				
				// Create a new contact object with the data from the database
				contact *contactObj = [[contact alloc] initWithValues:fName last:lname address:address city:city state:state zipcode:zip phone:phone];
				
				// Add the contact object to contactArray
				[appDelegate.contactArray addObject:contactObj];
				[contactObj release];
				
				contactObj.isDirty = NO;
				
				[appDelegate.contactArray addObject:contactObj];
				[contactObj release];
			}
		}
	}
	else
		sqlite3_close(database); //Even though the open call failed, close the database connection to release all the memory.
}

-(void) addContact{
	if(addStmt == nil){
		const char *sql = "INSERT INTO contacts(fname, lname, address, city, state, zip, phone) VALUES (?, ?, ?, ?, ?, ?, ?)";
		if(sqlite3_prepare_v2(database, sql, -1, &addStmt, NULL) != SQLITE_OK)
			NSAssert1(0, @"Error while creating add statement. '%s'", sqlite3_errmsg(database));
	}
	//replace '?' in addStmt with values
	sqlite3_bind_text(addStmt, 1, [fname UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 2, [lname UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 3, [address UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 4, [city UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 5, [state UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 6, [zip UTF8String], -1, SQLITE_TRANSIENT);
	sqlite3_bind_text(addStmt, 7, [phone UTF8String], -1, SQLITE_TRANSIENT);
	
	if(SQLITE_DONE != sqlite3_step(addStmt))
		NSAssert1(0, @"Error while inserting data. '%s'", sqlite3_errmsg(database));
	//Reset the add statement.
	sqlite3_reset(addStmt);	
}

+ (void) finalizeStatements {
	
	if(database) sqlite3_close(database);
	if(addStmt) sqlite3_finalize(addStmt);
}

- (void) dealloc {
	[fname release];
	[lname release];
	[address release];
	[city release];
	[state release];
	[zip release];
	[phone release];
	[super dealloc];
}

@end
