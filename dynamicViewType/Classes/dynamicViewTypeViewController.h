//
//  dynamicViewTypeViewController.h
//  dynamicViewType
//
//  Created by Brandon Coston on 12/17/09.
//  Copyright Slate Technologies 2009. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MultiTypes;

@interface dynamicViewTypeViewController : UIViewController {
	IBOutlet UISlider* typeSlider;
	MultiTypes* typeView;

}

- (IBAction) loadView:(id)sender;
- (IBAction) removeView:(id)sender;

@end

