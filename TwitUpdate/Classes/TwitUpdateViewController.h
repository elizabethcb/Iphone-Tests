//
//  TwitUpdateViewController.h
//  TwitUpdate
//
//  Created by Brandon Trebitowski on 7/8/09.
//  Copyright iCodeBlog.com 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TwitUpdateViewController : UIViewController {
	UITextView * twitterMessageText;
	UIButton   * updateButton;

	UIActionSheet * loadingActionSheet;
}

@property (nonatomic, retain) IBOutlet UITextView * twitterMessageText;
@property (nonatomic, retain) IBOutlet UIButton   * updateButton;

- (IBAction) postTweet: (id) sender;

@end

