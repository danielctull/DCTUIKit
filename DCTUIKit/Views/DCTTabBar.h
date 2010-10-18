//
//  DCTTabBar.h
//  DTKit
//
//  Created by Daniel Tull on 29.09.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DCTTabBarDelegate;

@interface DCTTabBar : UIView {
	NSArray *items;
	id<DCTTabBarDelegate> delegate;
	UITabBarItem *selectedItem;
	NSArray *itemHitAreas;
}
@property (nonatomic, retain) UITabBarItem *selectedItem;
@property (nonatomic, retain) NSArray *items, *itemHitAreas;
@property (nonatomic, assign) NSObject <DCTTabBarDelegate> *delegate;
@end

@protocol DCTTabBarDelegate <NSObject>
- (void)tabBar:(DCTTabBar *)tabBar didSelectItem:(UITabBarItem *)item;
@end
