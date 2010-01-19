//
//  RootViewController.m
//  TAB RSS reader
//
//  Created by Jason Terhorst on 7/28/08.
//  Copyright AstoundingCookie, LLC 2008. All rights reserved.
//

#import "RootViewController.h"
#import "TAB_RSS_readerAppDelegate.h"
#import "customCell.h"
#import "DataSource.h"


@implementation RootViewController

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	
	[theTextField resignFirstResponder];
	if(myThread)
		[myThread cancel];
	[NSThread sleepForTimeInterval:.1];
	myThread = [[NSThread alloc] initWithTarget:self
									   selector:@selector(performSearchOnString:)
										 object:searchField.text];
	[[DataSource sharedDataSource] empty];
	[myThread start];
	[self performSelector:@selector(refreshData) withObject:nil afterDelay:(NSTimeInterval) .5];	
	return YES;
}


- (IBAction)searchPressed:(id)selector{
	[searchField resignFirstResponder];
	if(myThread)
		[myThread cancel];
	[NSThread sleepForTimeInterval:.1];
	myThread = [[NSThread alloc] initWithTarget:self
									   selector:@selector(performSearchOnString:)
										 object:searchField.text];
	[[DataSource sharedDataSource] empty];
	[myThread start];
	[self performSelector:@selector(refreshData) withObject:nil afterDelay:(NSTimeInterval) .5];
}


- (void)viewDidLoad {
	// Add the following line if you want the list to be editable
	// self.navigationItem.leftBarButtonItem = self.editButtonItem;
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
	return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
	if([[DataSource sharedDataSource] count] == 0)
		return 1;
	else
		return [[DataSource sharedDataSource] count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	if([[DataSource sharedDataSource] count] == 0){
		UITableViewCell *cell = [[UITableViewCell alloc] init];
		cell.textLabel.text = @"No results available";
		return cell;
	}
	else {
		static NSString *myIdentifier = @"customCellID";
		customCell *cell = (customCell*)[tableView dequeueReusableCellWithIdentifier:myIdentifier];
		if (cell == nil) {
			NSLog(@"Cell Created");
			NSArray *topLevelObjects = [[NSBundle mainBundle] loadNibNamed:@"customCell" owner:nil options:nil];
			for(id currentObject in topLevelObjects){
				if([currentObject isKindOfClass:[customCell class]]){
					cell = (customCell *)currentObject;
					break;
				}
			}
		}
		
		// Set up the cell
		NSInteger storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
		cell.storyTitle.text = [[[DataSource sharedDataSource] objectAtIndex: storyIndex] objectForKey: @"title"];
		cell.storyAuthor.text = [[[DataSource sharedDataSource] objectAtIndex: storyIndex] objectForKey: @"author"];
		cell.date.text = [[[DataSource sharedDataSource] objectAtIndex: storyIndex] objectForKey: @"date"];
		UIImage *tempImage = [[UIImage alloc] initWithData:[[[DataSource sharedDataSource] objectAtIndex: storyIndex] objectForKey: @"imageData"]];
		cell.storyImage.image = tempImage;	
		return cell;
	}
}


 - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	 // Navigation logic
	 
	 int storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	 
	 NSString * storyLink = [[[DataSource sharedDataSource] objectAtIndex: storyIndex] objectForKey: @"link"];
	 
	 // clean up the link - get rid of spaces, returns, and tabs...
	 storyLink = [storyLink stringByReplacingOccurrencesOfString:@" " withString:@""];
	 storyLink = [storyLink stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	 storyLink = [storyLink stringByReplacingOccurrencesOfString:@"	" withString:@""];
	 
	 NSLog(@"link: %@", storyLink);
	 // open in Safari
	 [[UIApplication sharedApplication] openURL:[NSURL URLWithString:storyLink]];
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	/*
	if ([[DataSource sharedDataSource] count] == 0) {
		myThread = [[NSThread alloc] initWithTarget:self
													 selector:@selector(performSearchOnString:)
													   object:@"test"];
		[myThread start];
	}
	 */
	autoreleasepool = [[NSAutoreleasePool alloc] init];
	myThread = [[NSThread alloc] init];
	[self performSelector:@selector(refreshData) withObject:nil afterDelay:(NSTimeInterval) .5];
}

- (void)performSearchOnString:(NSString*)string
{
	string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	NSString *path = [NSString stringWithFormat:@"http://search.twitter.com/search.rss?q=%@&rpp=5",string];
	[self parseXMLFileAtURL:path];
}

- (void)refreshData
{
	[newsTable reloadData];
	if(myThread){
		if([myThread isExecuting])
			[self performSelector:@selector(refreshData) withObject:nil afterDelay:(NSTimeInterval) .5];
		else
			[myThread cancel];
	}
}


- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
}




- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"found file and started parsing");
	
}

- (void)parseXMLFileAtURL:(NSString *)URL
{	
	
    //you must then convert the path to a proper NSURL or it won't work
    NSURL *xmlURL = [NSURL URLWithString:URL];
	
    // here, for some reason you have to use NSClassFromString when trying to alloc NSXMLParser, otherwise you will get an object not found error
    // this may be necessary only for the toolchain
    rssParser = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
	
    // Set self as the delegate of the parser so that it will receive the parser delegate methods callbacks.
    [rssParser setDelegate:self];
	
    // Depending on the XML document you're parsing, you may want to enable these features of NSXMLParser.
    [rssParser setShouldProcessNamespaces:NO];
    [rssParser setShouldReportNamespacePrefixes:NO];
    [rssParser setShouldResolveExternalEntities:NO];
	
    [rssParser parse];
	
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
	NSString * errorString = [NSString stringWithFormat:@"Unable to download story feed from web site (Error code %i )", [parseError code]];
	NSLog(@"error parsing XML: %@", errorString);
	
	UIAlertView * errorAlert = [[UIAlertView alloc] initWithTitle:@"Error loading content" message:errorString delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
	[errorAlert show];
}

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{			
	if([[NSThread currentThread] isCancelled]){
		[NSThread exit];
	}
	//NSLog(@"found this element: %@", elementName);
	currentElement = [elementName copy];
	if ([elementName isEqualToString:@"item"]) {
		// clear out our story item caches...
		item = [[NSMutableDictionary alloc] init];
		currentTitle = [[NSMutableString alloc] init];
		currentDate = [[NSMutableString alloc] init];
		currentSummary = [[NSMutableString alloc] init];
		currentLink = [[NSMutableString alloc] init];
		currentImageURL = [[NSMutableString alloc] init];
		currentAuthor = [[NSMutableString alloc] init];
	}
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{     
	if([[NSThread currentThread] isCancelled]){
		[NSThread exit];
	}
	//NSLog(@"ended element: %@", elementName);
	if ([elementName isEqualToString:@"item"]) {
		// save values to an item, then store that item into the array...
		[item setObject:currentTitle forKey:@"title"];
		[item setObject:currentLink forKey:@"link"];
		[item setObject:currentSummary forKey:@"summary"];
		[item setObject:currentDate forKey:@"date"];
		[item setObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentImageURL]] forKey:@"imageData"];
		[item setObject:currentAuthor forKey:@"author"];
		[[DataSource sharedDataSource] insertDictionaryAtTail:[item copy]];
		NSLog(@"adding story: %@", currentTitle);
	}
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
	if([[NSThread currentThread] isCancelled]){
		[NSThread exit];
	}
	//NSLog(@"found characters: %@", string);
	// save the characters for the current item...
	if ([currentElement isEqualToString:@"title"]) {
		[currentTitle appendString:string];
	} else if ([currentElement isEqualToString:@"link"]) {
		[currentLink appendString:string];
	} else if ([currentElement isEqualToString:@"description"]) {
		[currentSummary appendString:string];
	} else if ([currentElement isEqualToString:@"pubDate"]) {
		[currentDate appendString:string];
	} else if ([currentElement isEqualToString:@"google:image_link"]) {
		string = [string stringByReplacingOccurrencesOfString:@" " withString:@""];
		string = [string stringByReplacingOccurrencesOfString:@"\n" withString:@""];
		string = [string stringByReplacingOccurrencesOfString:@"	" withString:@""];
		[currentImageURL appendString:string];
	} else if ([currentElement isEqualToString:@"author"]) {
		[currentAuthor appendString:[[string componentsSeparatedByCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"@"]] objectAtIndex:0]];
	}
}

- (void)parserDidEndDocument:(NSXMLParser *)parser {
	if([[NSThread currentThread] isCancelled]){
		[NSThread exit];
	}
	[activityIndicator stopAnimating];
	[activityIndicator removeFromSuperview];
	
	NSLog(@"all done!");
	NSLog(@"stories array has %d items", [[DataSource sharedDataSource] count]);
	[NSThread exit];
}





- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
	[autoreleasepool release];
	[currentElement release];
	[rssParser release];
	[item release];
	[currentTitle release];
	[currentDate release];
	[currentSummary release];
	[currentLink release];
	
	[super dealloc];
}


@end

