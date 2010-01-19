//
//  contact.h
//  database
//
//  Created by Brandon Coston on 6/11/09.
//  Copyright 2009 Slate Technologies LLC. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface contact : NSObject {
	NSString *fname;
	NSString *lname;
	NSString *address;
	NSString *city;
	NSString *state;
	NSString *zip;
	NSString *phone;
	
	//Internal variables keep track of state of object.
	BOOL isDirty;
	BOOL isDetailViewHydrated;

}
@property (nonatomic, retain) NSString *fname;
@property (nonatomic, retain) NSString *lname;
@property (nonatomic, retain) NSString *address;
@property (nonatomic, retain) NSString *city;
@property (nonatomic, retain) NSString *state;
@property (nonatomic, retain) NSString *zip;
@property (nonatomic, retain) NSString *phone;

@property (nonatomic, readwrite) BOOL isDirty;
@property (nonatomic, readwrite) BOOL isDetailViewHydrated;

//instance methods
-(id)initWithName:(NSString *)f last:(NSString *)l address:(NSString *)a city:(NSString *)c state:(NSString *)s zipcode:(NSString *)z phone:(NSString *)p;

//static methods
+(void) addContact;
+(void) finalizeStatements;
@end
