/*
 DCTTabBar.h
 DCTUIKit
 
 Created by Daniel Tull on 29.09.2009.
 
 
 
 Copyright (c) 2009 Daniel Tull. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without
 modification, are permitted provided that the following conditions are met:
 
 * Redistributions of source code must retain the above copyright notice, this
 list of conditions and the following disclaimer.
 
 * Redistributions in binary form must reproduce the above copyright notice,
 this list of conditions and the following disclaimer in the documentation
 and/or other materials provided with the distribution.
 
 * Neither the name of the author nor the names of its contributors may be used
 to endorse or promote products derived from this software without specific
 prior written permission.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
 AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
 IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
 DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE
 FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
 CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
 OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
 OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */

#import <UIKit/UIKit.h>

@protocol DCTTabBarDelegate;

/** DCTTabBar is displayed by a DCTTabBarController and can be subclasses to give 
 a custom look, as the default look is a little plain. */
@interface DCTTabBar : UIView {
	NSArray *items;
	id<DCTTabBarDelegate> delegate;
	UITabBarItem *selectedItem;
	NSArray *itemHitAreas;
}

/** The currently selected item. Will exist in the items array.*/
@property (nonatomic, retain) UITabBarItem *selectedItem;

/** An array of UITabBarItems that is represented by the tab bar. */
@property (nonatomic, retain) NSArray *items;

/** An array of hit areas. These should correspond to the UITabBarItems in the items array. */
@property (nonatomic, retain) NSArray *itemHitAreas;

/** The delegate for the tab bar. */
@property (nonatomic, assign) NSObject <DCTTabBarDelegate> *delegate;
@end

/** Delegate methods for the tab bar.*/
@protocol DCTTabBarDelegate <NSObject>

/** Allows the delegate to respond to touches on the tab bar.
 
 @param tabBar The tab bar that was tapped.
 @param item The item that was selected.
 */
- (void)dctTabBar:(DCTTabBar *)tabBar didSelectItem:(UITabBarItem *)item;
@end
