//
//  MultiTypes.h
//  dynamicViewType
//
//  Created by Brandon Coston on 12/17/09.
//  Copyright 2009 Slate Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum {
	CustomViewTypeData,
	CustomViewTypeTable,
	CustomViewTypeInput,
} CustomViewType;

@interface MultiTypes : UIViewController {

	IBOutlet UIView* table;
	IBOutlet UIView* input;
	IBOutlet UIView* output;
	
}

- (void)displayType:(CustomViewType)type;

@end
