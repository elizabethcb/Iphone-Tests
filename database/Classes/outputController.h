//
//  outputController.h
//  simple database
//
//  Created by Brandon Coston on 6/10/09.
//  Copyright 2009 Slate Technologies LLC. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface outputController : UIViewController {
	
	databaseAppDelegate *appDelegate;
	
	IBOutlet UITextField *txtContactFirstName;
	IBOutlet UITextField *txtContactLastName;
	IBOutlet UILabel *contactFirst;
	IBOutlet UILabel *contactLast;
	IBOutlet UILabel *contactAddress;
	IBOutlet UILabel *contactCity;
	IBOutlet UILabel *contactState;
	IBOutlet UILabel *contactZip;
	IBOutlet UILabel *contactPhone;
}

- (IBAction) btnRetrieve_clicked:(id)sender;



@end
