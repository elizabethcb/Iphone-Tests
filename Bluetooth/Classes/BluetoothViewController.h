//
//  BluetoothViewController.h
//  Bluetooth
//
//  Created by Brandon Coston on 9/10/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <GameKit/GameKit.h>
#import <AddressBook/AddressBook.h>

@class setupViewController;

@interface BluetoothViewController : UIViewController <GKPeerPickerControllerDelegate, GKSessionDelegate> {
	IBOutlet UILabel*		transfered;
	IBOutlet UITextField*	user;
	IBOutlet UITextField*	keyword;
	IBOutlet UISwitch*		sender;
	IBOutlet UIView*		loginView;
	IBOutlet UIView*		mainView;
	GKPeerPickerController* tPicker;
	GKSession*				tSession;
	NSMutableArray*			tPeers;
	setupViewController*	addyView;

}
@property (retain) GKSession* tSession;

-(IBAction) transfer_clicked:(id)sender;
-(IBAction) connect_clicked:(id)sender;
-(IBAction) returnToMain_clicked:(id)sender;
-(IBAction) person_clicked:(id)sender;
-(void) sendData:(NSString*)data;

@end

