//
//  BluetoothViewController.m
//  Bluetooth
//
//  Created by Brandon Coston on 9/10/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import "BluetoothViewController.h"
#import "setupViewController.h"

@implementation BluetoothViewController
@synthesize tSession;


- (BOOL)textFieldShouldReturn:(UITextField *)textField {
	[textField resignFirstResponder];
	return YES;
}

-(IBAction) connect_clicked:(id)sender {
	if([user.text length] > 0)
		[tPicker show];
}

-(IBAction) transfer_clicked:(id)sender {
	if([keyword.text length] > 0)
		[self sendData:keyword.text];
}


-(IBAction) returnToMain_clicked:(id)sender {
	[addyView.view removeFromSuperview];
	keyword.text = [NSString stringWithString:(NSString*)ABRecordCopyCompositeName(addyView.user)];
}

-(IBAction) person_clicked:(id)sender {
	[super.view addSubview:addyView.view];
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



// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad {
    [super viewDidLoad];
	tPicker = [[GKPeerPickerController alloc] init];
	addyView = [[setupViewController alloc] init];
	tPicker.delegate = self;
	tPicker.connectionTypesMask = GKPeerPickerConnectionTypeNearby;
	tPeers = [[NSMutableArray alloc] init];	
}

#pragma mark PeerPickerControllerDelegate stuff

/* Notifies delegate that a connection type was chosen by the user.
 */
- (void)peerPickerController:(GKPeerPickerController *)picker didSelectConnectionType:(GKPeerPickerConnectionType)type{
	if (type == GKPeerPickerConnectionTypeOnline) {
        picker.delegate = nil;
        [picker dismiss];
        [picker autorelease];
		// Implement your own internet user interface here.
    }
}

/* Notifies delegate that the connection type is requesting a GKSession object.
 
 You should return a valid GKSession object for use by the picker. If this method is not implemented or returns 'nil', a default GKSession is created on the delegate's behalf.
 */

- (GKSession *)peerPickerController:(GKPeerPickerController *)picker sessionForConnectionType:(GKPeerPickerConnectionType)type{
	
	//UIApplication *app=[UIApplication sharedApplication];
	NSString *txt=user.text;
	
	GKSession* session = [[GKSession alloc] initWithSessionID:@"sessionID" displayName:txt sessionMode:GKSessionModePeer];
    [session autorelease];
    return session;
}

/* Notifies delegate that the peer was connected to a GKSession.
 */
- (void)peerPickerController:(GKPeerPickerController *)picker didConnectPeer:(NSString *)peerID toSession:(GKSession *)session{
	
	NSLog(@"Connected from %@",peerID);
	
	// Use a retaining property to take ownership of the session.
    self.tSession = session;
	// Assumes our object will also become the session's delegate.
    session.delegate = self;
    [session setDataReceiveHandler: self withContext:nil];
	// Remove the picker.
    picker.delegate = nil;
    [picker dismiss];
    [picker autorelease];
	// Start your game.
}

-(void) sendData:(NSString*)data {
	NSMutableDictionary* sending = [[NSMutableDictionary alloc] initWithCapacity:1];
	[sending setObject:data forKey:@"whatever"];
	NSMutableData *sendableData = [[NSMutableData alloc] init];
	NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:sendableData];
	[archiver encodeObject:sending forKey:@"archiveKey"];
	[archiver finishEncoding];
	[archiver release];
	
	[tSession sendData:sendableData toPeers:tPeers withDataMode:GKSendDataReliable error:nil];	
//	[tSession sendData:[data dataUsingEncoding: NSASCIIStringEncoding] toPeers:tPeers withDataMode:GKSendDataReliable error:nil];
}

- (void) receiveData:(NSData *)data fromPeer:(NSString *)peer inSession: (GKSession *)session context:(void *)context
{
    // Read the bytes in data and perform an application-specific action.
	
	NSString* aStr;
	aStr = [NSString stringWithString:(NSString*)ABRecordCopyCompositeName((ABRecordRef*)data)];
	NSLog(@"Received Data from %@",peer);
	transfered.text=aStr;
}

/* Notifies delegate that the user cancelled the picker.
 */
- (void)peerPickerControllerDidCancel:(GKPeerPickerController *)picker{
	
}

#pragma mark GameSessionDelegate stuff

/* Indicates a state change for the given peer.
 */
- (void)session:(GKSession *)session peer:(NSString *)peerID didChangeState:(GKPeerConnectionState)state{
	
	switch (state)
    {
        case GKPeerStateConnected:
		{
			NSString *str=[NSString stringWithFormat:@"%@\n%@%@",user.text,@"Connected from peer ",peerID];
			transfered.text= str;
			NSLog(str);
			[tPeers addObject:peerID];
			[self.view addSubview:mainView];
			break;
		}
        case GKPeerStateDisconnected:
		{
			[tPeers removeObject:peerID];
			
			NSString *str=[NSString stringWithFormat:@"%@\n%@%@",user.text,@"DisConnected from peer ",peerID];
			transfered.text= str;
			NSLog(str);
			break;
		}
    }
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
	[user release];
	[transfered release];
	[keyword release];
	[sender release];
	[tPicker release];
	[tSession release];
	[tPeers release];
    [super dealloc];
}

@end
