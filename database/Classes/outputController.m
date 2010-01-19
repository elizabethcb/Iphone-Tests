//
//  outputController.m
//  simple database
//
//  Created by Brandon Coston on 6/10/09.
//  Copyright 2009 Slate Technologies LLC. All rights reserved.
//

#import "outputController.h"


@implementation outputController

-(BOOL)textFieldShouldReturn:(UITextField *)theTextField {
	
	[theTextField resignFirstResponder];
	return YES;
}

- (IBAction) btnRetrieve_clicked:(id)sender{
	NSString *first = txtContactFirstName.text;
	NSString *last = txtContactLastName.text;
	NSString *address = nil;
	NSString *city = nil;
	NSString *state = nil;
	NSString *zip = nil;
	NSString *phone = nil;
}
	
	


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"output";
    }
    return self;
}


/*
// Implement loadView to create a view hierarchy programmatically, without using a nib.
- (void)loadView {
}
*/

/*
// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
	self.title = @"output";
    [super viewDidLoad];
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
    [super didReceiveMemoryWarning]; // Releases the view if it doesn't have a superview
    // Release anything that's not essential, such as cached data
}


- (void)dealloc {
    [super dealloc];
}


@end
