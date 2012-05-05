//
//  UITableView+DCTExtras.h
//  Tweetopolis
//
//  Created by Daniel Tull on 05.05.2012.
//  Copyright (c) 2012 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UITableView (DCTExtras)
- (void)dct_scrollToBottomAnimated:(BOOL)animated;
- (void)dct_scrollToTopAnimated:(BOOL)animated;
@end
