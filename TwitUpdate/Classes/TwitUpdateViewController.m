//
//  TwitUpdateViewController.m
//  TwitUpdate
//
//  Created by Brandon Trebitowski on 7/8/09.
//  Copyright iCodeBlog.com 2009. All rights reserved.
//

#import "TwitUpdateViewController.h"
#import "TwitterRequest.h"

@implementation TwitUpdateViewController
@synthesize twitterMessageText, updateButton;

- (IBAction) postTweet: (id) sender {
	TwitterRequest * t = [[TwitterRequest alloc] init];
	t.username = @"";
	t.password = @"";

	[twitterMessageText resignFirstResponder];
	
	loadingActionSheet = [[UIActionSheet alloc] initWithTitle:@"Posting To Twitter..." delegate:nil 
											cancelButtonTitle:nil destructiveButtonTitle:nil otherButtonTitles:nil];
	[loadingActionSheet showInView:self.view];
	[t statuses_update:twitterMessageText.text delegate:self requestSelector:@selector(status_updateCallback:)];
}
- (void) status_updateCallback: (NSData *) content {
	[loadingActionSheet dismissWithClickedButtonIndex:0 animated:YES];
	[loadingActionSheet release];
	NSLog(@"%@",[[NSString alloc] initWithData:content encoding:NSASCIIStringEncoding]);
}

/*
// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/

/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/


/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
}
*/



// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationLandscapeLeft);
}


- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}

@end
