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
#import "StringHelper.h"

//cell Constants
#define kTextViewFontSize		14.0
#define kDefaultCellHeight		67.0
#define kDefaultLabelWidth		216.0
#define kDefaultMinLabelHeight	21.0
#define kDefaultAuthorY			33.0
#define kDefaultDateY			59.0

@implementation RootViewController

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	
	[theTextField resignFirstResponder];
	if(myThread)
		[myThread cancel];
	//[NSThread sleepForTimeInterval:.1];
	//myThread = [[NSThread alloc] initWithTarget:self
	//								   selector:@selector(performSearchOnString:)
	//									 object:searchField.text];
	[[DataSource sharedDataSource] empty];
	[newsTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
	[self performSearchOnString:searchField.text];
	[newsTable reloadData];
	//[myThread start];
	//[self performSelector:@selector(refreshData) withObject:nil afterDelay:(NSTimeInterval) .5];
	return YES;
}


- (IBAction)searchPressed:(id)selector{
	[searchField resignFirstResponder];
	if(myThread)
		[myThread cancel];
	//[NSThread sleepForTimeInterval:.1];
	//myThread = [[NSThread alloc] initWithTarget:self
	//								   selector:@selector(performSearchOnString:)
	//									 object:searchField.text];
	[[DataSource sharedDataSource] empty];
	[newsTable scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
	[self performSearchOnString:searchField.text];
	[newsTable reloadData];
	//[myThread start];
	//[self performSelector:@selector(refreshData) withObject:nil afterDelay:(NSTimeInterval) .5];
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


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath  { 
	if([[DataSource sharedDataSource] count] == 0){
		return kDefaultCellHeight + kDefaultMinLabelHeight;
	}
	NSInteger storyIndex = [indexPath indexAtPosition: [indexPath length] - 1];
	NSString *label = [[[DataSource sharedDataSource] objectAtIndex: storyIndex] objectForKey: @"title"];
    CGFloat height = [label ST_textHeightForSystemFontOfSize:kTextViewFontSize AndLabelWidth:kDefaultLabelWidth];
	if(height < kDefaultMinLabelHeight)
		height = kDefaultMinLabelHeight;
    return kDefaultCellHeight + height;
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
		NSString *label = [[[DataSource sharedDataSource] objectAtIndex: storyIndex] objectForKey: @"title"];
		NSLog(label);
		CGFloat offset = [label ST_textHeightForSystemFontOfSize:kTextViewFontSize AndLabelWidth:kDefaultLabelWidth]-kDefaultMinLabelHeight;
		cell.storyAuthor.frame = CGRectMake(cell.storyAuthor.frame.origin.x, kDefaultAuthorY + offset, cell.storyAuthor.frame.size.width, cell.storyAuthor.frame.size.height);
		cell.date.frame = CGRectMake(cell.date.frame.origin.x, kDefaultDateY + offset, cell.date.frame.size.width, cell.date.frame.size.height);
		cell.storyTitle.frame = [[label ST_sizeCellLabelWithSystemFontOfSize:kTextViewFontSize LabelWidth:kDefaultLabelWidth AndOrigin:cell.storyTitle.frame.origin] frame];
		cell.storyTitle.text = label;
		cell.storyAuthor.text = [[[DataSource sharedDataSource] objectAtIndex: storyIndex] objectForKey: @"author"];
		
		
		//NSString *StringDate = [[NSString alloc] initWithFormat:@"%dsec %dmin %dhours %ddays %dmoths",[conversionInfo second], [conversionInfo minute], [conversionInfo hour], [conversionInfo day], [conversionInfo month]];
		
		NSString *StringDate = [[NSString alloc] initWithString:[ self formatDateString:[[[DataSource sharedDataSource] objectAtIndex: storyIndex] objectForKey: @"date"]]];
		
		
		cell.date.text = StringDate;
		cell.storyImage.image = nil;
		//UIImage *tempImage = [[UIImage alloc] initWithData:[[[DataSource sharedDataSource] objectAtIndex: storyIndex] objectForKey: @"imageData"]];
		//cell.storyImage.image = tempImage;
		NSThread *tempThread = [[NSThread alloc] initWithTarget:self
													   selector:@selector(addPicToCell:)
														 object:cell];
		[tempThread start];
		/*//alternate version to be implemented
		// create the request
		NSURLRequest *theRequest=[NSURLRequest requestWithURL:[NSURL URLWithString:@"http://www.apple.com/"]
												  cachePolicy:NSURLRequestUseProtocolCachePolicy
											  timeoutInterval:60.0];
		// create the connection with the request
		// and start loading the data
		NSURLConnection *theConnection=[[NSURLConnection alloc] initWithRequest:theRequest delegate:self];
		 */
		cell.index = storyIndex;
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
	//myThread = [[NSThread alloc] init];
	//[self performSelector:@selector(refreshData) withObject:nil afterDelay:(NSTimeInterval) .5];
	activityIndicator = [[UIActivityIndicatorView alloc] init];
}

- (void)performSearchOnString:(NSString*)string
{
	string = [string stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
	//NSString *path = [NSString stringWithFormat:@"http://search.twitter.com/search.rss?q=%@&rpp=50",string];
	NSString *path = [NSString stringWithFormat:@"http://%@.campdx.com/feed",string];
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

-(void)addPicToCell:(customCell*)theCell {
	NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
	NSArray *tempArray = [[NSArray alloc] initWithArray:[newsTable visibleCells]];
	customCell* tempCell;
	for(id currentCell in tempArray) {
		tempCell = (customCell*)currentCell;
		if(tempCell.index == theCell.index) {
			NSString *string = [[[NSString alloc] initWithString:[[[DataSource sharedDataSource] objectAtIndex: theCell.index] objectForKey: @"imageData"]] autorelease];
			NSData *tempData = [[[NSData alloc] initWithContentsOfURL:[NSURL URLWithString:string]] autorelease];
			if(tempData)
			{
				UIImage *tempImage = [[[UIImage alloc] initWithData:tempData] autorelease];
				theCell.storyImage.image = tempImage;
				//[tempImage release];
			}
			//[tempData release];
			//[string release];
		}
	}
	[pool drain];
}


- (NSString*)formatDateString:(NSString*)date {
	NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
	[dateFormatter setTimeStyle:NSDateFormatterFullStyle];
	[dateFormatter setFormatterBehavior:NSDateFormatterBehavior10_4];
	[dateFormatter setDateFormat:@"EEE, dd LLL yyyy HH:mm:ss Z"];
	date = [date stringByReplacingOccurrencesOfString:@"\n" withString:@""];
	NSDate *StoryDate = [[dateFormatter dateFromString:date] autorelease];
	// Create the NSDates
	NSDate *now = [[[NSDate alloc] init] autorelease]; 
	
	// Get conversion to months, days, hours, minutes
	unsigned int unitFlags = NSSecondCalendarUnit | NSHourCalendarUnit | NSMinuteCalendarUnit | NSDayCalendarUnit | NSMonthCalendarUnit | NSYearCalendarUnit;
	
	// Get the system calendar
	NSCalendar *sysCalendar = [NSCalendar currentCalendar];
	
	NSDateComponents *nowComponents = [sysCalendar components:unitFlags fromDate:[NSDate date]];
	NSDateComponents *timeAgo = [sysCalendar components:unitFlags fromDate:StoryDate  toDate:now  options:0];
	NSDateComponents *storyTime = [sysCalendar components:unitFlags fromDate:StoryDate];
	
	if([timeAgo year])
		return @"over a year ago";
	if([timeAgo month]) {
		if([timeAgo month] == 1)
			return @"about a month ago";
		else
			return [NSString stringWithFormat:@"%d months ago", [timeAgo month]];
	}
	if([nowComponents day] - [storyTime day]) {
		if([nowComponents day] - [storyTime day] == 1){
			if([storyTime hour] > 12)
				return [NSString stringWithFormat:@"yesterday %d:%02d pm", [storyTime hour]-12, [storyTime minute]];
			if([storyTime hour] == 12)
				return [NSString stringWithFormat:@"yesterday 12:%02d pm", [storyTime minute]];
			if([storyTime hour] == 0)
				return [NSString stringWithFormat:@"yesterday 12:%02d am", [storyTime minute]];
			return [NSString stringWithFormat:@"yesterday %d:%02d am", [storyTime hour], [storyTime minute]];
		}
		else{
			if([storyTime hour] > 12)
				return [NSString stringWithFormat:@"%d days ago  %d:%02d pm", [nowComponents day] - [storyTime day], [storyTime hour]-12, [storyTime minute]];
			if([storyTime hour] == 12)
				return [NSString stringWithFormat:@"%d days ago  12:%02d pm", [nowComponents day] - [storyTime day], [storyTime minute]];
			if([storyTime hour] == 0)
				return [NSString stringWithFormat:@"%d days ago  12:%02d am", [nowComponents day] - [storyTime day], [storyTime minute]];
			return [NSString stringWithFormat:@"%d days ago  %d:%02d am", [nowComponents day] - [storyTime day], [storyTime hour], [storyTime minute]];
		}
	}
	if([timeAgo hour]) {
		if([timeAgo hour] == 1)
			return @"about an hour ago";
		else{
			if([storyTime hour] > 12)
				return [NSString stringWithFormat:@"today %d:%02d pm", [storyTime hour]-12, [storyTime minute]];
			if([storyTime hour] == 12)
				return [NSString stringWithFormat:@"today 12:%02d pm", [storyTime minute]];
			if([storyTime hour] == 0)
				return [NSString stringWithFormat:@"today 12:%02d am", [storyTime minute]];
			return [NSString stringWithFormat:@"today %d:%02d am", [storyTime hour], [storyTime minute]];
		}
	}
	if([timeAgo minute]) {
		if([timeAgo minute] == 1)
			return @"about a minute ago";
		else
			return [NSString stringWithFormat:@"%d minutes ago", [timeAgo minute]];
	}
	if([timeAgo second]) {
		if([timeAgo second] == 1)
			return @"about a second ago";
		else
			return @"less than a minute ago";
	}
	return @"less than a second ago";
}


- (void)viewWillDisappear:(BOOL)animated {
}

- (void)viewDidDisappear:(BOOL)animated {
}


#pragma mark parser methods


- (void)parserDidStartDocument:(NSXMLParser *)parser{	
	NSLog(@"found file and started parsing");
	[self.view addSubview:activityIndicator];
	[activityIndicator startAnimating];
	
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
	//NSAutoreleasePool *autoreleasepool = [[NSAutoreleasePool alloc] init];
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
	//[autoreleasepool release];
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
		//[item setObject:[NSData dataWithContentsOfURL:[NSURL URLWithString:currentImageURL]] forKey:@"imageData"];
		[item setObject:currentImageURL forKey:@"imageData"];
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
	[newsTable reloadData];
	//[NSThread exit];
}


#pragma mark NSURLConnection methods

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response
{
    // this method is called when the server has determined that it
    // has enough information to create the NSURLResponse
	
    // it can be called multiple times, for example in the case of a
    // redirect, so each time we reset the data.
    // receivedData is declared as a method instance elsewhere
    picData = [[NSMutableData alloc] initWithCapacity:2048];
}


- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data
{
    // append the new data to the receivedData
    // receivedData is declared as a method instance elsewhere
    [picData appendData:data];
}


- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error
{
    // release the connection, and the data object
    [connection release];
    // receivedData is declared as a method instance elsewhere
    [picData release];
	
    // inform the user
    NSLog(@"Connection failed! Error - %@ %@",
          [error localizedDescription],
          [[error userInfo] objectForKey:NSErrorFailingURLStringKey]);
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    // do something with the data
    // receivedData is declared as a method instance elsewhere
    NSLog(@"Succeeded! Received %d bytes of data",[picData length]);
	
    // release the connection, and the data object
    [connection release];
    [picData release];
}


#pragma mark final class methods


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	// Return YES for supported orientations
	return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning {
	[super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
	// Release anything that's not essential, such as cached data
}


- (void)dealloc {
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

