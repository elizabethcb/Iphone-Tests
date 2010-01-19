//
//  inputController.h
//  simple database
//
//  Created by Brandon Coston on 6/11/09.
//  Copyright 2009 Slate Technologies LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface inputController : UIViewController {
	
	databaseAppDelegate *appDelegate;
	
	IBOutlet UITextField *txtFirstName;
	IBOutlet UITextField *txtLastName;
	IBOutlet UITextField *txtAddress;
	IBOutlet UITextField *txtCity;
	IBOutlet UITextField *txtState;
	IBOutlet UITextField *txtZip;
	IBOutlet UITextField *txtPhone;
	IBOutlet UILabel *lblMessage;
}

- (IBAction) btnSubmit_clicked:(id)sender;
- (IBAction) btnBackground_clicked:(id)sender;
@end
