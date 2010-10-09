//
//  DCTFetchedResultsTableViewController.m
//  DCTUIKit
//
//  Created by Daniel Tull on 9.10.2010.
//  Copyright (c) 2010 Daniel Tull. All rights reserved.
//

#import "DCTFetchedResultsTableViewController.h"


@implementation DCTFetchedResultsTableViewController

@synthesize fetchedResultsController;

#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	[fetchedResultsController release], fetchedResultsController = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark DCTFetchedResultsTableViewController

- (void)setFetchedResultsController:(NSFetchedResultsController *)frc {
	
	fetchedResultsController.delegate = nil;
	NSFetchedResultsController *oldFrc = fetchedResultsController;
	fetchedResultsController = [frc retain];
	[oldFrc release];
	
	[fetchedResultsController performFetch:nil];
	fetchedResultsController.delegate = self;
}

- (NSIndexPath *)tableViewIndexPathForFetchedResultsControllerIndexPath:(NSIndexPath *)indexPath {
	return indexPath;
}

- (NSIndexPath *)fetchedResultsControllerIndexPathForTableViewIndexPath:(NSIndexPath *)indexPath {
	return indexPath;
}

- (NSUInteger)tableViewSectionIndexForFetchedResultsControllerSectionIndex:(NSUInteger)index {
	return index;
}

- (NSUInteger)fetchedResultsControllerSectionIndexForTableViewSectionIndex:(NSUInteger)index {
	return index;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tv numberOfRowsInSection:(NSInteger)section {
	
	NSInteger s = [self fetchedResultsControllerSectionIndexForTableViewSectionIndex:section];
	
	id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:s];
    return [sectionInfo numberOfObjects];
}

#pragma mark -
#pragma mark NSFetchedResultsControllerDelegate methods

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
