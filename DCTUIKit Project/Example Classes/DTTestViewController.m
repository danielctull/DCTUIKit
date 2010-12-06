//
//  DTTestViewController.m
//  DTResurrectionKit
//
//  Created by Daniel Tull on 16.11.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "DTTestViewController.h"

@implementation DTTestViewController

- (IBAction)presentVC:(id)sender {
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	NSLog(@"%@:%@", self, NSStringFromSelector(_cmd));
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	NSLog(@"%@:%@", self, NSStringFromSelector(_cmd));
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	NSLog(@"%@:%@", self, NSStringFromSelector(_cmd));
}

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	NSLog(@"%@:%@", self, NSStringFromSelector(_cmd));
}

@end
