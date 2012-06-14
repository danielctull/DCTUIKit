/*
 DCTViewController.m
 DCTUIKit
 
 Created by Daniel Tull on 19.9.2010.
 
 
 
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
#import "UIResponder+DCTNextResponderExtensions.h"
#import "UIView+DCTAnimation.h"
#import "UINib+DCTExtensions.h"
#import "UIViewController+DCTViewController.h"

@interface DCTViewController ()
- (void)dctInternal_keyboardWillHide:(BOOL)hidden withNotification:(NSNotification *)notification;
@end

@implementation DCTViewController

@synthesize resizeViewToFitKeyboard;
@synthesize resizeViewToBottomEdgeOfScreenBeforeResizingForKeyboard;

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

- (void)viewDidLoad {
	[super viewDidLoad];
	[self dct_viewDidLoad];
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

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self dct_viewWillDisappear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self dct_viewWillAppear:animated];
}

#pragma mark - DCTViewController

- (IBAction)dismissModalViewController:(id)sender {
	[self dct_dismissModalViewController:sender];
}

- (void)sharedInit {}
- (void)loadTitle {}
- (void)keyboardWillShowNotification:(NSNotification *)notification {
	if (self.resizeViewToFitKeyboard)
		[self dctInternal_keyboardWillHide:NO withNotification:notification];
}
- (void)keyboardDidShowNotification:(NSNotification *)notification {}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
	if (self.resizeViewToFitKeyboard)
		[self dctInternal_keyboardWillHide:YES withNotification:notification];
}

- (void)keyboardDidHideNotification:(NSNotification *)notification {}

- (void)dctInternal_keyboardWillHide:(BOOL)hidden withNotification:(NSNotification *)notification {
	
	UIView *view = self.view;
	
	NSDictionary *userInfo = [notification userInfo];
	
	CGRect keyboardEndRect, keyboardBeginRect;
	[[userInfo objectForKey:UIKeyboardFrameEndUserInfoKey] getValue:&keyboardEndRect];
	[[userInfo objectForKey:UIKeyboardFrameBeginUserInfoKey] getValue:&keyboardBeginRect];
	
	if (keyboardEndRect.origin.y == keyboardBeginRect.origin.y) return;
	
	UIWindow *window = view.window;
	CGRect endRect = [window convertRect:keyboardEndRect toView:view];
	
	CGRect originalRect;
	
	if (!hidden) originalRect = view.frame;
	
	if (self.resizeViewToBottomEdgeOfScreenBeforeResizingForKeyboard) {
		
		CGRect beginRect = [window convertRect:keyboardBeginRect toView:view];
		
		[UIView animateWithDuration:0.0f animations:^(void) {
			view.frame = CGRectMake(originalRect.origin.x, 
									originalRect.origin.y,
									originalRect.size.width, 
									beginRect.origin.y);
		}];
	}
	
	UIViewAnimationCurve curve;
	[[userInfo objectForKey:UIKeyboardAnimationCurveUserInfoKey] getValue:&curve];
	UIViewAnimationOptions animationOptions = [UIView dct_animationOptionCurveForAnimationCurve:curve];
	
	double duration = [[userInfo objectForKey:UIKeyboardAnimationDurationUserInfoKey] doubleValue];	
	
	[UIView animateWithDuration:duration
						  delay:0.0f
						options:animationOptions
					 animations:^(void) {
						 
						 if (hidden && !self.resizeViewToBottomEdgeOfScreenBeforeResizingForKeyboard)
							 view.frame = originalRect;
						 else 
							 view.frame = CGRectMake(originalRect.origin.x, 
													 originalRect.origin.y,
													 originalRect.size.width, 
													 endRect.origin.y);
						 
					 } completion:^(BOOL finished) {
						 
						 if (hidden && self.resizeViewToBottomEdgeOfScreenBeforeResizingForKeyboard)
							 view.frame = originalRect;		
					 }];
}

@end
