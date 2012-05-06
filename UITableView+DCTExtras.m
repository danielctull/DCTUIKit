//
//  UITableView+DCTExtras.m
//  Tweetopolis
//
//  Created by Daniel Tull on 05.05.2012.
//  Copyright (c) 2012 Daniel Tull. All rights reserved.
//

#import "UITableView+DCTExtras.h"

@implementation UITableView (DCTExtras)

- (void)dct_scrollToBottomAnimated:(BOOL)animated {
	
	NSInteger section = self.numberOfSections - 1;
	if (section < 0) return;
	
	NSInteger row = [self numberOfRowsInSection:section] - 1;
	if (row < 0) return;
	
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:row inSection:section];
	[self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

- (void)dct_scrollToTopAnimated:(BOOL)animated {
	NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
	[self scrollToRowAtIndexPath:indexPath atScrollPosition:UITableViewScrollPositionTop animated:animated];
}

@end
