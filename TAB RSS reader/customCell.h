//
//  customCell.h
//  TAB RSS reader
//
//  Created by Brandon Coston on 1/13/10.
//  Copyright 2010 Slate Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface customCell : UITableViewCell {
	IBOutlet UILabel *storyTitle;
	IBOutlet UILabel *storyAuthor;
	IBOutlet UILabel *date;
	
	IBOutlet UIImageView *storyImage;
}

@property (nonatomic, retain) UILabel *storyTitle;
@property (nonatomic, retain) UILabel *storyAuthor;
@property (nonatomic, retain) UILabel *date;

@property (nonatomic, retain) UIImageView *storyImage;

@end
