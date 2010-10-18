/*
 DCTTabBarController.m
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

#import "DCTTabBarController.h"
#import "UIView+DCTSubviewExtensions.h"
#import "UIResponder+DCTNextResponderExtensions.h"

NSInteger const DCTTabBarUnselectedIndex = -1;

@interface DCTTabBarController ()
- (void)dctInternal_setUpTabBarItems;
- (void)dctInternal_sendDelegateMessageDidSelectViewController:(UIViewController *)viewController;
- (void)dctInternal_refreshNavigationControllerItems;
@end


@implementation DCTTabBarController

@synthesize viewControllers, selectedIndex, delegate, tabBar;

#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	[tabBar release];
	[viewControllers release];
    [super dealloc];
}

- (id)initWithViewControllers:(NSArray *)vcs {
	
	if (!(self = [self init])) return nil;
	
	viewControllers = [vcs retain];
	
	return self;
}

- (id)init {
	
	if (!(self = [super init])) return nil;
	
	self.position = DCTContentBarPositionBottom;
	selectedIndex = DCTTabBarUnselectedIndex;
	
	return self;
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidUnload {
	[super viewDidUnload];
	viewIsLoaded = NO;
}

- (void)viewDidLoad {
	[self dctInternal_setUpTabBarItems];
	self.barView = self.tabBar;
	if (self.selectedIndex == DCTTabBarUnselectedIndex) self.selectedIndex = 0;
	self.tabBar.selectedItem = [self.tabBar.items objectAtIndex:self.selectedIndex];
	self.tabBar.delegate = self;
	[super viewDidLoad];
	[self loadContentView];
	viewIsLoaded = YES;
}

- (void)didReceiveMemoryWarning {
	NSMutableArray *array = [viewControllers mutableCopy];
	[array removeObject:self.selectedViewController];
	for (UIViewController *vc in array)
		[vc didReceiveMemoryWarning];
	[array release];
	[super didReceiveMemoryWarning];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.selectedViewController viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.selectedViewController viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.selectedViewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[self.selectedViewController viewDidDisappear:animated];
}

- (UINavigationItem *)navigationItem {
	return self.selectedViewController.navigationItem;
}

#pragma mark -
#pragma mark Public methods

- (void)setTabBarHidden:(BOOL)hidden animated:(BOOL)animated {
	[self setBarHidden:hidden animated:animated];
}

- (void)loadContentView {
	
	BOOL firstLoad = [self.contentView dct_hasSubviews];
	
	[self.contentView dct_removeAllSubviews];
	
	UIViewController *vc = self.selectedViewController;
	
	vc.view.frame = self.contentView.bounds;
	[vc viewWillAppear:NO];
	[self.contentView addSubview:vc.view];
	[vc viewDidAppear:NO];
	
	if (firstLoad) [self dctInternal_refreshNavigationControllerItems];
}

#pragma mark -
#pragma mark Accessors

- (void)setSelectedIndex:(NSUInteger)integer {
	
	if (integer == selectedIndex) return;
		
	UIViewController *vc = self.selectedViewController;
	[vc viewWillDisappear:NO];
	
	selectedIndex = integer;

	if (viewIsLoaded) [self loadContentView];
	
	[vc viewDidDisappear:NO];
}

- (UIViewController *)selectedViewController {
	if (self.selectedIndex == DCTTabBarUnselectedIndex) self.selectedIndex = 0;
	return [viewControllers objectAtIndex:self.selectedIndex];
}

- (void)setSelectedViewController:(UIViewController *)vc {
	self.selectedIndex = [viewControllers indexOfObject:vc];
}

- (void)setTabBar:(DCTTabBar *)aTabBar {
	[tabBar release];
	tabBar = [aTabBar retain];
	self.barView = tabBar;
	[self dctInternal_setUpTabBarItems];
}

- (DCTTabBar *)tabBar {
	if (!tabBar) self.tabBar = [[DCTTabBar alloc] initWithFrame:CGRectMake(0.0, 0.0, 320.0, 44.0)];
	return tabBar;
}

#pragma mark -
#pragma mark DCTTabBarDelegate

- (void)dctTabBar:(DCTTabBar *)tab didSelectItem:(UITabBarItem *)item {
	self.selectedIndex = [tab.items indexOfObject:item];
	[self dctInternal_sendDelegateMessageDidSelectViewController:self.selectedViewController];
}

#pragma mark -
#pragma mark Internal methods

- (void)dctInternal_setUpTabBarItems {
	NSMutableArray *tempItems = [[NSMutableArray alloc] init];
	for (UIViewController *vc in self.viewControllers)
		[tempItems addObject:vc.tabBarItem];
	self.tabBar.items = tempItems;
	[tempItems release];
}

- (void)dctInternal_sendDelegateMessageDidSelectViewController:(UIViewController *)vc {
	if ([self.delegate respondsToSelector:@selector(DCTTabBarController:didSelectViewController:)])
		[self.delegate dctTabBarController:self didSelectViewController:vc];
}

- (void)dctInternal_refreshNavigationControllerItems {
	
	UINavigationController *nav = self.navigationController;
	
	if (nav == nil) return;
	
	NSMutableArray *items = [nav.viewControllers mutableCopy];
	
	NSInteger index = [items indexOfObject:self];
	
	[items removeObjectAtIndex:index];
	[items insertObject:self atIndex:index];
	nav.viewControllers = items;
	[items release];
}

@end





#pragma mark -

@implementation UIViewController (DCTTabBarController)

- (DCTTabBarController *)dctTabBarController {
	return (DCTTabBarController *)[self dct_nearestResponserOfClass:[DCTTabBarController class]];
}

@end


