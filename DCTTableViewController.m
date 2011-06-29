/*
 DCTTableViewController.m
 DCTUIKit
 
 Created by Daniel Tull on 09.08.2010.
 
 
 
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


@implementation DCTTableViewController {
    CGPoint savedOffset;
	NSIndexPath *savedIndexPath;
}

@synthesize tableViewDataSource;

#pragma mark - NSObject

- (void)dealloc {
	[savedIndexPath release], savedIndexPath = nil;
	[super dealloc];
}

#pragma mark - UIViewController

// Saving and reloading the position of the table view - if memory warning removes table.

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	savedOffset = self.tableView.contentOffset;
	[savedIndexPath release], savedIndexPath = nil;
	savedIndexPath = [[self.tableView indexPathForSelectedRow] retain];
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.tableView flashScrollIndicators];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	[self.tableView selectRowAtIndexPath:savedIndexPath animated:NO scrollPosition:UITableViewScrollPositionNone];
	self.tableView.contentOffset = savedOffset;
}

#pragma mark - DCTTableViewController

- (void)setTableViewDataSource:(id<UITableViewDataSource>)tvds {
	
	if (self.tableViewDataSource == tvds) return;
	
	tableViewDataSource = tvds;
	
	SEL setViewControllerSelector = @selector(setViewControllers:);
	
	if ([tableViewDataSource respondsToSelector:setViewControllerSelector])
		[tableViewDataSource performSelector:setViewControllerSelector withObject:self];
}

- (void)setTableView:(UITableView *)tableView {
	
	if (self.tableView == tableView) return;
	
	[super setTableView:tableView];
	
	tableView.dataSource = self.tableViewDataSource;
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tv cellForRowAtIndexPath:(NSIndexPath *)indexPath {
	
	UITableViewCell *cell = [tv dequeueReusableCellWithIdentifier:@"cell"];
	
	if (!(cell))
		cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"] autorelease];
	
	cell.textLabel.text = [NSString stringWithFormat:@"Cell with indexPath: %i.%i", indexPath.section, indexPath.row];
	
	return cell;
}


@end
