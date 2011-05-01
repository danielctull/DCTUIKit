/*
 DCTFetchedResultsTableViewController.m
 DCTUIKit
 
 Created by Daniel Tull on 19.09.2010.
 
 
 
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

#import "DCTFetchedResultsTableViewController.h"


@implementation DCTFetchedResultsTableViewController

@synthesize fetchedResultsController;

#pragma mark - NSObject

- (void)dealloc {
	fetchedResultsController.delegate = nil;
	[fetchedResultsController release], fetchedResultsController = nil;
	[super dealloc];
}

#pragma mark - UIViewController

- (void)viewDidUnload {
	[super viewDidUnload];
	self.fetchedResultsController.delegate = nil;
	self.fetchedResultsController = nil;
}

- (void)viewDidLoad {
	[super viewDidLoad];
	[self fetchedResultsController];
}

#pragma mark - DCTFetchedResultsTableViewController

- (void)setFetchedResultsController:(NSFetchedResultsController *)frc {
	
	fetchedResultsController.delegate = nil;
	NSFetchedResultsController *oldFrc = fetchedResultsController;
	fetchedResultsController = [frc retain];
	[oldFrc release];
	
	fetchedResultsController.delegate = self;
	[fetchedResultsController performFetch:nil];
}

- (NSFetchedResultsController *)fetchedResultsController {
	
	if (!fetchedResultsController) [self loadFetchedResultsController];
	
	return fetchedResultsController;	
}

- (void)loadFetchedResultsController {}

- (NSIndexPath *)tableViewIndexPathForFetchedResultsControllerIndexPath:(NSIndexPath *)indexPath {
	return indexPath;
}

- (NSIndexPath *)fetchedResultsControllerIndexPathForTableViewIndexPath:(NSIndexPath *)indexPath {
	return indexPath;
}

- (NSUInteger)tableViewSectionIndexForFetchedResultsControllerSectionIndex:(NSUInteger)theIndex {
	return theIndex;
}

- (NSUInteger)fetchedResultsControllerSectionIndexForTableViewSectionIndex:(NSUInteger)theIndex {
	return theIndex;
}

#pragma mark - UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	
	NSInteger s = [self fetchedResultsControllerSectionIndexForTableViewSectionIndex:section];
	
	id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:s];
    return [sectionInfo numberOfObjects];
}

#pragma mark - NSFetchedResultsControllerDelegate methods

/*
 
 These methods are taken straight from Apple's documentation on NSFetchedResultsController.
 
 */

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView beginUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller 
  didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)si
	 forChangeType:(NSFetchedResultsChangeType)type {
	
	NSUInteger sectionIndex = [self tableViewSectionIndexForFetchedResultsControllerSectionIndex:si];	
	
    switch(type) {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						  withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex]
						  withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}


- (void)controller:(NSFetchedResultsController *)controller 
   didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)ip
	 forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIP {
	
	NSIndexPath *indexPath = [self tableViewIndexPathForFetchedResultsControllerIndexPath:ip];
	NSIndexPath *newIndexPath = [self tableViewIndexPathForFetchedResultsControllerIndexPath:newIP];
	
    UITableView *tv = self.tableView;
	
    switch(type) {
			
        case NSFetchedResultsChangeInsert:
            [tv insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
					  withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeDelete:
            [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
					  withRowAnimation:UITableViewRowAnimationFade];
            break;
			
        case NSFetchedResultsChangeUpdate:
			[self.tableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationNone];
            break;
			
        case NSFetchedResultsChangeMove:
            [tv deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath]
					  withRowAnimation:UITableViewRowAnimationFade];
            [tv insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]
					  withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    [self.tableView endUpdates];
}


@end
