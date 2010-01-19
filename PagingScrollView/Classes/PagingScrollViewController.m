//
//  PagingScrollViewController.m
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

#import "PagingScrollViewController.h"
//#import "PageViewController.h"
#import "TablePageViewController.h"
#import "DataSource.h"

@implementation PagingScrollViewController

- (void)applyNewIndex:(NSInteger)newIndex pageController:(TablePageViewController *)pageController
{
	NSInteger pageCount = [[DataSource sharedDataSource] numDataPages];
	BOOL outOfBounds = newIndex >= pageCount || newIndex < 0;

	if (!outOfBounds)
	{
		CGRect pageFrame = pageController.view.frame;
		pageFrame.origin.y = 0;
		pageFrame.origin.x = scrollView.frame.size.width * newIndex;
		pageController.view.frame = pageFrame;
	}
	else
	{
		CGRect pageFrame = pageController.view.frame;
		pageFrame.origin.y = scrollView.frame.size.height;
		pageController.view.frame = pageFrame;
	}

	pageController.pageIndex = newIndex;
}

- (void)viewDidLoad
{
	currentPage = [[TablePageViewController alloc] init];
	nextPage = [[TablePageViewController alloc] init];
	prevPage = [[TablePageViewController alloc] init];
	[scrollView addSubview:prevPage.view];
	[scrollView addSubview:currentPage.view];
	[scrollView addSubview:nextPage.view];

	NSInteger widthCount = [[DataSource sharedDataSource] numDataPages];
	if (widthCount == 0)
	{
		widthCount = 1;
	}
	
    scrollView.contentSize =
		CGSizeMake(
			scrollView.frame.size.width * widthCount,
			scrollView.frame.size.height);
	scrollView.contentOffset = CGPointMake(0, 0);

	pageControl.numberOfPages = [[DataSource sharedDataSource] numDataPages];
	pageControl.currentPage = 0;
	
	[self applyNewIndex:-1 pageController:prevPage];
	[self applyNewIndex:0 pageController:currentPage];
	[self applyNewIndex:1 pageController:nextPage];
}

- (void)scrollViewDidScroll:(UIScrollView *)sender
{
    CGFloat pageWidth = scrollView.frame.size.width;
    float fractionalPage = scrollView.contentOffset.x / pageWidth;
	
	NSInteger middleNumber = floor(fractionalPage);
	NSInteger lowerNumber = middleNumber - 1;
	NSInteger upperNumber = middleNumber + 1;
	if(middleNumber == fractionalPage)
	{
		if (middleNumber == currentPage.pageIndex)
		{
			if (upperNumber != nextPage.pageIndex)
			{
				[self applyNewIndex:upperNumber pageController:nextPage];
			}
			if (lowerNumber != prevPage.pageIndex)
			{
				[self applyNewIndex:lowerNumber pageController:prevPage];
			}
		}
		else if (upperNumber == currentPage.pageIndex)
		{
			[self applyNewIndex:upperNumber pageController:nextPage];
			[nextPage updateTextViews:YES];
			[self applyNewIndex:middleNumber pageController:currentPage];
			[currentPage updateTextViews:YES];
			[self applyNewIndex:lowerNumber pageController:prevPage];
			[prevPage updateTextViews:YES];
			
		}
		else
		{
			[self applyNewIndex:lowerNumber pageController:prevPage];
			[prevPage updateTextViews:YES];
			[self applyNewIndex:middleNumber pageController:currentPage];
			[currentPage updateTextViews:YES];
			[self applyNewIndex:upperNumber pageController:nextPage];
			[nextPage updateTextViews:YES];
		}
	}
	
	[prevPage updateTextViews:NO];
	[currentPage updateTextViews:NO];
	[nextPage updateTextViews:NO];
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)newScrollView
{
	
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)newScrollView
{
	[self scrollViewDidEndScrollingAnimation:newScrollView];
	pageControl.currentPage = currentPage.pageIndex;
}

- (IBAction)addPageDone:(id)sender
{
	NSMutableArray*	tempArray = [[NSMutableArray alloc] init];
	NSMutableDictionary* tempDict;
	if([entry1.text length] > 0)
		[tempArray addObject:entry1.text];
	if([entry2.text length] > 0)
		[tempArray addObject:entry2.text];
	if([entry3.text length] > 0)
		[tempArray addObject:entry3.text];
	tempDict = [NSMutableDictionary dictionaryWithObjectsAndKeys:
				@"Page", @"pageName",
			    @"Some text for page", @"pageText",
			    tempArray, @"pageData",
				nil];
	[[DataSource sharedDataSource] insertDictionary:tempDict AtIndex:currentPage.pageIndex];
	NSInteger widthCount = [[DataSource sharedDataSource] numDataPages];
	if (widthCount == 0)
	{
		widthCount = 1;
	}
	
    scrollView.contentSize =
	CGSizeMake(
			   scrollView.frame.size.width * widthCount,
			   scrollView.frame.size.height);
	//scrollView.contentOffset = CGPointMake(0, 0);
	
	pageControl.numberOfPages = [[DataSource sharedDataSource] numDataPages];
	pageControl.currentPage = currentPage.pageIndex;
	
	[self applyNewIndex:prevPage.pageIndex pageController:prevPage];
	[self applyNewIndex:currentPage.pageIndex pageController:currentPage];
	[self applyNewIndex:nextPage.pageIndex pageController:nextPage];
	[prevPage updateTextViews:YES];
	[currentPage updateTextViews:YES];
	[nextPage updateTextViews:YES];
	[addPageView removeFromSuperview];
}

- (IBAction)addPage:(id)sender
{
	[self.view addSubview:addPageView];
}

- (IBAction)changePage:(id)sender
{
	NSInteger pageIndex = pageControl.currentPage;

	// update the scroll view to the appropriate page
    CGRect frame = scrollView.frame;
    frame.origin.x = frame.size.width * pageIndex;
    frame.origin.y = 0;
    [scrollView scrollRectToVisible:frame animated:YES];
}

- (void)dealloc
{
	[currentPage release];
	[nextPage release];
	
	[super dealloc];
}

@end
