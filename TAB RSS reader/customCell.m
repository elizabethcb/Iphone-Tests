//
//  customCell.m
//  TAB RSS reader
//
//  Created by Brandon Coston on 1/13/10.
//  Copyright 2010 Slate Technologies. All rights reserved.
//

#import "customCell.h"


@implementation customCell

@synthesize storyTitle, storyAuthor, date;
@synthesize storyImage;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        // Initialization code
    }
    return self;
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {

    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (void)dealloc {
    [super dealloc];
}


@end
