//
//  TablePageViewController.h
//  PagingScrollView
//
//  Created by Brandon Coston on 12/14/09.
//  Copyright 2009 Slate Technologies. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum {
	PanelTypeLocationStories,
	PanelTypeTwitterSearch,
	PanelTypeTopics,
	PanelTypeLocationCategories,
	PanelTypeTopicCategories
} PanelType;
@interface TablePageViewController : UIViewController {
	PanelType type;
	NSInteger pageIndex;
	BOOL textViewNeedsUpdate;
	UILabel *label;
	UITextView *textView;
	NSMutableArray *cellData;
	IBOutlet UITableView *searchTable;
	IBOutlet UITableView *standardTable;
}
@property PanelType type;
@property NSInteger pageIndex;

- (void)updateTextViews:(BOOL)force;

@end
