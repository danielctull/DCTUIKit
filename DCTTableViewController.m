/*
 DCTTableViewController.m
 DCTUIKit
 
 Created by Daniel Tull on 9.8.2010.
 
 
 
 Copyright (c) 2010 Daniel Tull. All rights reserved.
 
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

#import "DCTTableViewController.h"
#import <objc/runtime.h>

@interface DCTTableViewController ()
- (void)dctInternal_keyboardWillHide:(BOOL)hidden withNotification:(NSNotification *)notification;
- (void)dctInternal_setupDataSource;

- (void)dctInternal_addKeyboardObservers;
- (void)dctInternal_removeKeyboardObservers;

+ (void)dctInternal_reimplementSelectorFromDCTViewController:(SEL)selector;

@end

@implementation DCTTableViewController {
    CGPoint savedOffset;
	NSIndexPath *savedIndexPath;
}

@synthesize tableViewDataSource;
@synthesize resizeViewToFitKeyboard;
@synthesize resizeViewToBottomEdgeOfScreenBeforeResizingForKeyboard;

#pragma mark - NSObject

+ (void)initialize {	
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(title)];
	
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(keyboardWillShowNotification:)];
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(keyboardDidShowNotification:)];
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(keyboardWillHideNotification:)];
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(keyboardDidHideNotification:)];
	
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(dismissModalViewController:)];
	
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(dctInternal_addKeyboardObservers:)];
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(dctInternal_removeKeyboardObservers:)];
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(dctInternal_keyboardWillHide:withNotification:)];
	
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(tabBarItem)];
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(setTabBarItem:)];
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(leftBarButtonItem)];
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(setLeftBarButtonItem:)];
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(rightBarButtonItem)];
	[self dctInternal_reimplementSelectorFromDCTViewController:@selector(setRightBarButtonItem:)];
}

#pragma mark - UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	[self dctInternal_setupDataSource];
}

// Saving and reloading the position of the table view - if memory warning removes table.

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	savedOffset = self.tableView.contentOffset;
	savedIndexPath = [self.tableView indexPathForSelectedRow];
	
	[self dctInternal_removeKeyboardObservers];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.tableView flashScrollIndicators];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.tableView selectRowAtIndexPath:savedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
	self.tableView.contentOffset = savedOffset;
	
	[self dctInternal_addKeyboardObservers];
}

#pragma mark - DCTTableViewController

- (void)setTableViewDataSource:(id<UITableViewDataSource>)tvds {
	
	if (self.tableViewDataSource == tvds) return;
	
	tableViewDataSource = tvds;
	
	[self dctInternal_setupDataSource];
}

- (void)setTableView:(UITableView *)tableView {
	
	if (self.tableView == tableView) return;
	
	[super setTableView:tableView];
	
	[self dctInternal_setupDataSource];
}

#pragma mark - DCTViewController

- (void)loadTitle {}

// Implmenetations in DCTViewController class

- (NSString *)title {return nil;}
- (IBAction)dismissModalViewController:(id)sender {}
- (void)keyboardWillShowNotification:(NSNotification *)notification {}
- (void)keyboardDidShowNotification:(NSNotification *)notification {}
- (void)keyboardWillHideNotification:(NSNotification *)notification {}
- (void)keyboardDidHideNotification:(NSNotification *)notification {}
- (UITabBarItem *)tabBarItem {return nil;}
- (void)setTabBarItem:(UITabBarItem *)item {}
- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {}
- (UIBarButtonItem *)leftBarButtonItem {return nil;}
- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {}
- (UIBarButtonItem *)rightBarButtonItem {return nil;}

#pragma mark - Internal

// Implmenetations in DCTViewController class

- (void)dctInternal_keyboardWillHide:(BOOL)hidden withNotification:(NSNotification *)notification {}
- (void)dctInternal_addKeyboardObservers {}
- (void)dctInternal_removeKeyboardObservers {}

+ (void)dctInternal_reimplementSelectorFromDCTViewController:(SEL)selector {
	IMP dctViewControllerImplementation = class_getMethodImplementation([DCTViewController class], selector);
	Method dctTableViewControllerMethod = class_getInstanceMethod(self, selector);
	method_setImplementation(dctTableViewControllerMethod, dctViewControllerImplementation);
}

- (void)dctInternal_setupDataSource {
	
	if (self.tableViewDataSource == nil) return;
	
	self.tableView.dataSource = self.tableViewDataSource;
	
	SEL setViewControllerSelector = @selector(setViewController:);
	if ([tableViewDataSource respondsToSelector:setViewControllerSelector])
		[tableViewDataSource performSelector:setViewControllerSelector withObject:self];
	
	SEL setTableViewSelector = @selector(setTableView:);
	if ([tableViewDataSource respondsToSelector:setTableViewSelector])
		[tableViewDataSource performSelector:setTableViewSelector withObject:self.tableView];
}

@end
