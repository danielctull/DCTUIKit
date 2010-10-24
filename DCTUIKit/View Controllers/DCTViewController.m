/*
 DCTViewController.m
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

#import "DCTViewController.h"

@interface DCTViewController ()
- (void)dctInternal_keyboardWillHide:(BOOL)hidden withNotification:(NSNotification *)notification;
@end

@implementation DCTViewController

// Because all view controllers should rotate all ways, right?
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return YES;
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];	
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.navigationController setToolbarHidden:YES animated:YES]; // OVERRIDE THIS IN VIEWWILLAPPEAR: FOR THE MINORITY OF CASES WHERE THE TOOLBAR IS USED
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidHideNotification:) name:UIKeyboardDidHideNotification object:nil];
}

#pragma mark -
#pragma mark IBOutlet accessors

- (UITabBarItem *)tabBarItem {
	return [super tabBarItem];
}

- (void)setTabBarItem:(UITabBarItem *)item {
	[super setTabBarItem:item];
}

- (void)setLeftBarButtonItem:(UIBarButtonItem *)leftBarButtonItem {
	self.navigationItem.leftBarButtonItem = leftBarButtonItem;
}

- (UIBarButtonItem *)leftBarButtonItem {
	return self.navigationItem.leftBarButtonItem;
}

- (void)setRightBarButtonItem:(UIBarButtonItem *)rightBarButtonItem {
	self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (UIBarButtonItem *)rightBarButtonItem {
	return self.navigationItem.rightBarButtonItem;
}

#pragma mark -
#pragma mark UIKeyboard Notification methods

- (void)keyboardWillShowNotification:(NSNotification *)notification {
	[self dctInternal_keyboardWillHide:NO withNotification:notification];
}

- (void)keyboardDidShowNotification:(NSNotification *)notification {}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
	[self dctInternal_keyboardWillHide:YES withNotification:notification];
}

- (void)keyboardDidHideNotification:(NSNotification *)notification {}

#pragma mark -
#pragma mark Internal methods

- (void)dctInternal_keyboardWillHide:(BOOL)hidden withNotification:(NSNotification *)notification {
	
	CGRect keyboardRect;
	UIViewAnimationCurve curve;
	
	[[[notification userInfo] objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardRect];
	[[[notification userInfo] objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
	double duration = [[[notification userInfo] objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];	
	
	CGFloat height = self.view.bounds.size.height;
	
	CGFloat keyboardHeight = keyboardRect.size.height;
	
	if (self.interfaceOrientation == UIInterfaceOrientationLandscapeLeft || self.interfaceOrientation == UIInterfaceOrientationLandscapeRight)
		keyboardHeight = keyboardRect.size.width;
	
	if (hidden) 
		height = height + keyboardHeight;
	else
		height = height - keyboardHeight;
	
	[UIView beginAnimations:@"showKeyboard" context:nil];
	[UIView setAnimationDuration:duration];
	[UIView setAnimationCurve:curve];
	
	self.view.frame = CGRectMake(self.view.frame.origin.x, self.view.frame.origin.y, self.view.frame.size.width, height);
	[UIView commitAnimations];
	
}

@end