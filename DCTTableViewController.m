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
#import "UIViewController+DCTViewController.h"

@interface DCTTableViewController ()
- (void)dctInternal_setupDataSource;
@end

@implementation DCTTableViewController {
    CGPoint savedOffset;
	NSIndexPath *savedIndexPath;
}

@synthesize tableViewDataSource;

#pragma mark - NSObject

- (id)initWithCoder:(NSCoder *)coder {
	
	if (!(self = [super initWithCoder:coder])) return nil;
	
	[self dct_sharedInit];
	
	return self;
}

#pragma mark - UIViewController


- (id)initWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
	
	if (!(self = [super initWithNibName:nibName bundle:bundle])) return nil;
	
	[self dct_sharedInit];
	
	return self;	
}

- (void)viewDidUnload {
	[super viewDidUnload];
	tableViewDataSource = nil;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self dct_viewDidLoad];
	[self tableViewDataSource];
}

- (void)loadView {
	[self dct_loadView];
	
	if (![self isViewLoaded]) [super loadView];
}

- (NSString *)title {
	NSString *t = super.title;
	
	if (!(t) || [t isEqualToString:@""]) {
		[self loadTitle];
		t = super.title;
	}
	
	return t;
}

// Saving and reloading the position of the table view - if memory warning removes table.

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self dct_viewWillDisappear:animated];
	savedOffset = self.tableView.contentOffset;
	savedIndexPath = [self.tableView indexPathForSelectedRow];
}

- (void)viewWillAppear:(BOOL)animated {
	[self.tableView selectRowAtIndexPath:savedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
	self.tableView.contentOffset = savedOffset;
	
	[super viewWillAppear:animated];
	[self dct_viewWillAppear:animated];
}

#pragma mark - DCTTableViewController

- (id<UITableViewDataSource>)tableViewDataSource {
	
	if (!tableViewDataSource)
		[self loadTableViewDataSource];
	
	return tableViewDataSource;	
}

- (void)setTableViewDataSource:(id<UITableViewDataSource>)tvds {
	
	if (tableViewDataSource == tvds) return;
	
	tableViewDataSource = tvds;
	
	[self dctInternal_setupDataSource];
}

- (void)setTableView:(UITableView *)tableView {
	[super setTableView:tableView];
	[self dctInternal_setupDataSource];
}

- (void)loadTableViewDataSource {}

#pragma mark - DCTViewController

- (IBAction)dismissModalViewController:(id)sender {
	[self dct_dismissModalViewController:sender];
}

- (void)sharedInit {}
- (void)loadTitle {}
- (void)keyboardWillShowNotification:(NSNotification *)notification {}
- (void)keyboardDidShowNotification:(NSNotification *)notification {}
- (void)keyboardWillHideNotification:(NSNotification *)notification {}
- (void)keyboardDidHideNotification:(NSNotification *)notification {}

#pragma mark - Internal

- (void)dctInternal_setupDataSource {
	
	if (self.tableViewDataSource == nil) return;
	
	self.tableView.dataSource = self.tableViewDataSource;
}

@end
