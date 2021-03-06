//
//  DataSource.m
//  PagingScrollView
//
//  Created by Matt Gallagher on 24/01/09.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import "DataSource.h"
#import "SynthesizeSingleton.h"

@implementation DataSource

SYNTHESIZE_SINGLETON_FOR_CLASS(DataSource);

//
// init
//
// Init method for the object.
//
- (id)init
{
	self = [super init];
	if (self != nil)
	{
		dataPages = [[NSMutableArray alloc] init];
	}
	return self;
}

- (NSInteger)count
{
	return [dataPages count];
}

- (NSDictionary *)objectAtIndex:(NSInteger)pageIndex
{
	return [dataPages objectAtIndex:pageIndex];
}

- (void)insertDictionary:(NSDictionary *)data AtIndex:(NSInteger)index
{
	[dataPages insertObject:data atIndex:index];
}

- (void)insertDictionaryAtTail:(NSDictionary *)data
{
	[dataPages insertObject:data atIndex:[dataPages count]];
}
	
- (void)empty{
	[dataPages release];
	dataPages = [[NSMutableArray alloc] init];
}

@end
