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
		dataPages = [[NSMutableArray alloc] initWithObjects:
			[NSDictionary dictionaryWithObjectsAndKeys:
				@"Page 1", @"pageName",
				@"Some text for page 1", @"pageText",
			    [NSArray arrayWithObjects:@"page one", nil], @"pageData",
				nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
				@"Page 2", @"pageName",
			    @"Some text for page 2", @"pageText",
			    [NSArray arrayWithObjects:@"page two", @"page two", nil], @"pageData",
				nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
				@"Page 3", @"pageName",
			    @"Some text for page 3", @"pageText",
			    [NSArray arrayWithObjects:@"page three", @"page three", @"page three", nil], @"pageData",
				nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
				@"Page 4", @"pageName",
			    @"Some text for page 4", @"pageText",
			    [NSArray arrayWithObjects:@"page four", @"page four", @"page four", @"page four", nil], @"pageData",
				nil],
			[NSDictionary dictionaryWithObjectsAndKeys:
				@"Page 5", @"pageName",
			    @"Some text for page 5", @"pageText",
			    [NSArray arrayWithObjects:@"page five", @"page five", @"page five", @"page five", @"page five", nil], @"pageData",
				nil],
			nil];
	}
	return self;
}

- (NSInteger)numDataPages
{
	return [dataPages count];
}

- (NSDictionary *)dataForPage:(NSInteger)pageIndex
{
	return [dataPages objectAtIndex:pageIndex];
}

- (void)insertDictionary:(NSDictionary *)data AtIndex:(NSInteger)index
{
	[dataPages insertObject:data atIndex:index];
}
	

@end
