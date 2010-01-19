//
//  PagingScrollViewController.h
//  PagingScrollView
//
//  Created by Matt Gallagher on 24/01/09.
//  Copyright 2009 Matt Gallagher. All rights reserved.
//
//  Permission is given to use this source code file, free of charge, in any
//  project, commercial or otherwise, entirely at your risk, with the condition
//  that any redistribution (in part or whole) of source code must retain
//  this copyright and permission notice. Attribution in compiled projects is
//  appreciated but not required.
//

#import <UIKit/UIKit.h>

//@class PageViewController;
@class TablePageViewController;

@interface PagingScrollViewController : UIViewController
{
	IBOutlet UIScrollView *scrollView;
	IBOutlet UIPageControl *pageControl;
	IBOutlet UIView *addPageView;
	IBOutlet UITextField *entry1;
	IBOutlet UITextField *entry2;
	IBOutlet UITextField *entry3;
	
	TablePageViewController *currentPage;
	TablePageViewController *nextPage;
	TablePageViewController *prevPage;
	
}

- (IBAction)addPageDone:(id)sender;
- (IBAction)addPage:(id)sender;
- (IBAction)changePage:(id)sender;

@end
