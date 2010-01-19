//
//  RootViewController.h
//  TAB RSS reader
//
//  Created by Jason Terhorst on 7/28/08.
//  Copyright AstoundingCookie, LLC 2008. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RootViewController : UIViewController {
	
	IBOutlet UITableView *newsTable;
	IBOutlet UITextField *searchField;
	
	//seperate thread used whenever search is performed
	NSThread* myThread;
	UIActivityIndicatorView * activityIndicator;
	NSXMLParser * rssParser;
	NSAutoreleasePool *autoreleasepool;
	
	// a temporary item; added to the "stories" array one at a time, and cleared for the next one
	NSMutableDictionary * item;
	
	// it parses through the document, from top to bottom...
	// we collect and cache each sub-element value, and then save each item to our array.
	// we use these to track each current item, until it's ready to be added to the "stories" array
	NSString * currentElement;
	NSMutableString * currentTitle, * currentDate, * currentSummary, * currentLink, *currentImageURL, *currentAuthor;
}
- (void)parseXMLFileAtURL:(NSString *)URL;
- (IBAction)searchPressed:(id)self;

@end
