//
//  StringHelper.h
//  TAB RSS reader
//
//  Created by Brandon Coston on 1/20/10.
//  Copyright 2010 Slate Technologies. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface NSString (StringHelper)

- (CGFloat)ST_textHeightForSystemFontOfSize:(CGFloat)size AndLabelWidth:(CGFloat)width;
- (UILabel *)ST_sizeCellLabelWithSystemFontOfSize:(CGFloat)size LabelWidth:(CGFloat)width AndOrigin:(CGPoint)origin;

@end
