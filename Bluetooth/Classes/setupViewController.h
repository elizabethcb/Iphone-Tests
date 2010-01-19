//
//  setupViewController.h
//  iConcur
//
//  Created by Brandon Coston on 9/10/09.
//  Copyright 2009 Slate Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AddressBook/AddressBook.h>
#import <AddressBookUI/AddressBookUI.h>


@interface setupViewController : UIViewController  <ABPeoplePickerNavigationControllerDelegate> {
	IBOutlet UIView*					userView;
	IBOutlet UIImageView*				userImage;
	IBOutlet UILabel*					txtUserName;
	ABPeoplePickerNavigationController*	picker;
	ABRecordRef							user;
	NSNumber*							userID;
	NSString*							userName;
	NSString*							userEmail;
	NSString*							userPhone;
	NSString*							userAddress1;
	NSString*							userAddress2;
	NSData*								userImageData;
	
}

@property (nonatomic) ABRecordRef user;

-(IBAction) Address_clicked:(id)sender;
-(IBAction) input_clicked:(id)sender;
-(IBAction) edit_clicked:(id)sender;

@end
