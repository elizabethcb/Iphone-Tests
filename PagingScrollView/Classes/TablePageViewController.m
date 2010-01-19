//
//  TablePageViewController.m
//  PagingScrollView
//
//  Created by Brandon Coston on 12/14/09.
//  Copyright 2009 Slate Technologies. All rights reserved.
//

#import "TablePageViewController.h"
#import "DataSource.h"
#import <QuartzCore/QuartzCore.h>

const CGFloat TABLE_VIEW_PADDING = 75.0;

@implementation TablePageViewController

@synthesize pageIndex, type;

- (void)setPageIndex:(NSInteger)newPageIndex
{
	pageIndex = newPageIndex;
	
	if (pageIndex >= 0 && pageIndex < [[DataSource sharedDataSource] numDataPages])
	{
		NSDictionary *pageData =
		[[DataSource sharedDataSource] dataForPage:pageIndex];
		label.text = [pageData objectForKey:@"pageName"];
		textView.text = [pageData objectForKey:@"pageText"];
		cellData = [pageData objectForKey:@"pageData"];
		
		CGRect absoluteRect = [self.view.window
							   convertRect:textView.bounds
							   fromView:textView];
		if (!self.view.window ||
			!CGRectIntersectsRect(
								  CGRectInset(absoluteRect, TABLE_VIEW_PADDING, TABLE_VIEW_PADDING),
								  [self.view.window bounds]))
		{
			textViewNeedsUpdate = YES;
		}
	}
}

- (void)updateTextViews:(BOOL)force
{
	if (force ||
		(textViewNeedsUpdate &&
		 self.view.window &&
		 CGRectIntersectsRect(
							  [self.view.window
							   convertRect:CGRectInset(textView.bounds, TABLE_VIEW_PADDING, TABLE_VIEW_PADDING)
							   fromView:textView],
							  [self.view.window bounds])))
	{
		if(type == PanelTypeTwitterSearch)
			[searchTable reloadData];
		else
			[standardTable reloadData];
		for (UIView *childView in textView.subviews)
		{
			[childView setNeedsDisplay];
		}
		textViewNeedsUpdate = NO;
	}
}

/*
- (id)initWithStyle:(UITableViewStyle)style {
    // Override initWithStyle: if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
    if (self = [super initWithStyle:style]) {
    }
    return self;
}
*/

/*
- (void)viewDidLoad {
    [super viewDidLoad];

    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}
*/

/*
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}
*/
/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
}
*/

/*
// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
*/

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


#pragma mark Table view methods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


// Customize the number of rows in the table view.
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [cellData count];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
		cell.textLabel.lineBreakMode = UILineBreakModeWordWrap;
		cell.textLabel.numberOfLines = 0;
		cell.textLabel.font = [UIFont fontWithName:@"American Typewriter" size:17];
    }
    
    // Set up the cell...
	//NSString *cellString = [cellData objectAtIndex:indexPath.row];
	cell.textLabel.text = [cellData objectAtIndex:indexPath.row];
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
	// AnotherViewController *anotherViewController = [[AnotherViewController alloc] initWithNibName:@"AnotherView" bundle:nil];
	// [self.navigationController pushViewController:anotherViewController];
	// [anotherViewController release];
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:YES];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/


/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/


/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


- (void)dealloc {
    [super dealloc];
}


@end

