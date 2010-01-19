//
//  inputController.m
//  simple database
//
//  Created by Brandon Coston on 6/11/09.
//  Copyright 2009 Slate Technologies LLC. All rights reserved.
//

#import "inputController.h"


@implementation inputController


//hides keyboard when done is pressed
-(BOOL)textFieldShouldReturn:(UITextField *)textField {
	if( textField == txtZip) {
		CGRect rc = [textField bounds];
		UIScrollView* v = (UIScrollView*) self.view ;
		rc = [textField convertRect:rc toView:v];
		CGPoint pt = rc.origin ;
		pt.x = 0 ;
		[v setContentOffset:pt animated:YES];
	}
	[textField resignFirstResponder];
	return YES;
}


- (IBAction) btnBackground_clicked:(id)sender{
	[txtFirstName resignFirstResponder];
	[txtLastName resignFirstResponder];
	[txtAddress resignFirstResponder];
	[txtCity resignFirstResponder];
	[txtState resignFirstResponder];
	[txtZip resignFirstResponder];
	[txtPhone resignFirstResponder];
}

-(IBAction) btnSubmit_clicked:(id)sender
{
	NSString *firstName = txtFirstName.text;
	NSString *lastName = txtLastName.text;
	NSString *address = txtAddress.text;
	NSString *city = txtCity.text;
	NSString *state = txtState.text;
	NSString *zip = txtZip.text;
	NSString *phone = txtPhone.text;
	NSString *testMsg = nil;
	
	if([firstName length] > 0 && [lastName length] > 0 && [address length] > 0 && [city length] > 0 && [state length] == 2 && [zip length] == 5 && [phone length] == 10)
		testMsg = [[NSString alloc] initWithFormat:@"accepted",firstName, lastName];
	else
		testMsg = [[NSString alloc] initWithFormat:@"please enter info correctly",firstName, lastName];
	lblMessage.text = testMsg;
	
	//release testmsg
	[testMsg release];
}


// The designated initializer. Override to perform setup that is required before the view is loaded.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
		self.title = @"input";
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
	self.title = @"input";
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
	[txtFirstName release];
	[txtLastName release];
	[txtAddress release];
	[txtCity release];
	[txtState release];
	[txtZip release];
	[txtPhone release];
	[lblMessage release];
    [super dealloc];
}


@end
