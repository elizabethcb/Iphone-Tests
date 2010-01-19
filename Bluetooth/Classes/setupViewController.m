//
//  setupViewController.m
//  iConcur
//
//  Created by Brandon Coston on 9/10/09.
//  Copyright 2009 Slate Technologies. All rights reserved.
//

#import "setupViewController.h"


@implementation setupViewController
@synthesize user;


-(IBAction) Address_clicked:(id)sender{
	[self presentModalViewController:picker animated:YES];
	userView.hidden = NO;
}


-(IBAction) input_clicked:(id)sender{
	userView.hidden = NO;
}


-(IBAction) edit_clicked:(id)sender{
	
}


#pragma mark ABPeoplePickerNavigationControllerDelegate Methods

- (void)peoplePickerNavigationControllerDidCancel:(ABPeoplePickerNavigationController *)peoplePicker {
	[self dismissModalViewControllerAnimated:YES];
}


- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person {
	user = person;
//	if(ABPersonHasImageData(user)){
//		userImageData = [NSData dataWithData:(NSData*)ABPersonCopyImageData(person)];
//		userImage.image = [UIImage imageWithData:(NSData *)ABPersonCopyImageData(person)];
//	}
//	else
//	userImage.image = [UIImage imageNamed:@"contact_image.gif"];
//	
	txtUserName.text = [NSString stringWithString:(NSString*)ABRecordCopyCompositeName(user)];
//	userName = [NSString stringWithString:txtUserName.text];
//	userEmail = [NSString stringWithString:(NSString*)ABRecordCopyValue(user, kABPersonEmailProperty)];
//	userPhone = [NSString stringWithString:(NSString*)ABRecordCopyValue(user, kABPersonEmailProperty)];
	
	[self dismissModalViewControllerAnimated:YES];
	return NO;
}

- (BOOL)peoplePickerNavigationController:(ABPeoplePickerNavigationController *)peoplePicker shouldContinueAfterSelectingPerson:(ABRecordRef)person property:(ABPropertyID)property identifier:(ABMultiValueIdentifier)identifier {
	return NO;
}

/*
 // The designated initializer.  Override if you create the controller programmatically and want to perform customization that is not appropriate for viewDidLoad.
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil {
    if (self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil]) {
        // Custom initialization
    }
    return self;
}
*/


// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	picker = [[ABPeoplePickerNavigationController alloc] init];
	picker.peoplePickerDelegate = self;
	if([[NSUserDefaults standardUserDefaults] dataForKey:@"USER"])
		userView.hidden = NO;
	else
		userView.hidden = YES;
}


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


- (void)dealloc {
	[picker release];
	[userView release];
	[userName release];
	[userImage release];
    [super dealloc];
}


@end
