//
//  StringHelper.m
//  TAB RSS reader
//
//  Created by Brandon Coston on 1/20/10.
//  Copyright 2010 Slate Technologies. All rights reserved.
//

#import "StringHelper.h"


@implementation NSString (StringHelper)

- (CGFloat)ST_textHeightForSystemFontOfSize:(CGFloat)size AndLabelWidth:(CGFloat)width {
    //Calculate the expected size based on the font and linebreak mode of the label
    CGFloat maxHeight = 9999;
    CGSize maximumLabelSize = CGSizeMake(width,maxHeight);
	
    CGSize expectedLabelSize = [self sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:maximumLabelSize lineBreakMode:UILineBreakModeWordWrap]; 
	
    return expectedLabelSize.height;
}

- (UILabel *)ST_sizeCellLabelWithSystemFontOfSize:(CGFloat)size LabelWidth:(CGFloat)width AndOrigin:(CGPoint)origin {
    CGFloat height = [self ST_textHeightForSystemFontOfSize:size AndLabelWidth:width];
    CGRect frame = CGRectMake(origin.x, origin.y, width, height);
    UILabel *cellLabel = [[UILabel alloc] initWithFrame:frame];
    cellLabel.textColor = [UIColor blackColor];
    cellLabel.backgroundColor = [UIColor clearColor];
    cellLabel.textAlignment = UITextAlignmentLeft;
    cellLabel.font = [UIFont systemFontOfSize:size];
	
    cellLabel.text = self; 
    cellLabel.numberOfLines = 0; 
    [cellLabel sizeToFit];
    return cellLabel;
}

@end
