//
//  TestDCTViewController.m
//  DCTUIKit
//
//  Created by Daniel Tull on 13/05/2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "TestDCTViewController.h"


@implementation TestDCTViewController

@synthesize textField;

- (void)viewDidLoad {
	[super viewDidLoad];
	self.resizeViewToFitKeyboard = YES;
}

- (IBAction)dismiss:(id)sender {
	[self.textField resignFirstResponder];
}

@end
