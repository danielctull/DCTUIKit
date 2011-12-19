/*
 UIViewController+DCTViewController.m
 DCTUIKit
 
 Created by Daniel Tull on 17.08.2011.
 
 
 
 Copyright (c) 2011 Daniel Tull. All rights reserved.
 
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

#import "UIViewController+DCTViewController.h"
#import "UINib+DCTExtensions.h"
#import "UIResponder+DCTNextResponderExtensions.h"
#import "UIView+DCTAnimation.h"
#import "DCTViewController.h"

@interface UIViewController (DCTViewControllerInternal)
- (void)dctViewControllerInternal_addKeyboardObservers;
- (void)dctViewControllerInternal_removeKeyboardObservers;

- (void)dctViewControllerInternal_keyboardWillShowNotification:(NSNotification *)notification;
- (void)dctViewControllerInternal_keyboardDidShowNotification:(NSNotification *)notification;
- (void)dctViewControllerInternal_keyboardWillHideNotification:(NSNotification *)notification;
- (void)dctViewControllerInternal_keyboardDidHideNotification:(NSNotification *)notification;

- (void)dctViewControllerInternal_safeLoadNibNamed:(NSString *)nibName inBundle:(NSBundle *)bundle;

@property (nonatomic, readonly) UIViewController<DCTViewController> *dctViewControllerInternal_dctViewController;

@end

@implementation UIViewController (DCTViewController)

- (void)dct_viewWillAppear:(BOOL)animated {
	[self.navigationController setToolbarHidden:YES animated:YES]; // OVERRIDE THIS IN VIEWWILLAPPEAR: FOR THE MINORITY OF CASES WHERE THE TOOLBAR IS USED
	[self dctViewControllerInternal_addKeyboardObservers];	
}

- (void)dct_viewWillDisappear:(BOOL)animated {
	[self dctViewControllerInternal_removeKeyboardObservers];	
}

- (void)dct_viewDidLoad {
	[self title];	
}

- (void)dct_loadView {
	
	// If the subclass has loaded a view and called super, return so that
	// multiple views aren't loaded.
	
	if ([self isViewLoaded]) return;
	
	// Making the nib loading nature explicit. Will try to load a nib that has 
	// the same name as the view controller class or one of its superclasses.
	
	NSBundle *bundle = self.nibBundle;
	if (!bundle) bundle = [NSBundle mainBundle];
	
	[self dctViewControllerInternal_safeLoadNibNamed:self.nibName inBundle:bundle];
	
	if ([self isViewLoaded]) return;
	
	Class theClass = [self class];
	
	while (![self isViewLoaded] && [theClass isSubclassOfClass:[UIViewController class]]) {
		[self dctViewControllerInternal_safeLoadNibNamed:NSStringFromClass(theClass) inBundle:bundle];
		theClass = [theClass superclass];
	}
}

#pragma mark - DCTViewController

- (void)dct_dismissModalViewController:(id)sender {
	[self.parentViewController dismissModalViewControllerAnimated:YES];	
}

- (void)dct_sharedInit {
	[self title];
	[self.dctViewControllerInternal_dctViewController sharedInit];
}

@end

@implementation UIViewController (DCTViewControllerInternal)

- (void)dctViewControllerInternal_keyboardWillShowNotification:(NSNotification *)notification {
	[self.dctViewControllerInternal_dctViewController keyboardWillShowNotification:notification];
}

- (void)dctViewControllerInternal_keyboardDidShowNotification:(NSNotification *)notification {
	[self.dctViewControllerInternal_dctViewController keyboardDidShowNotification:notification];
}

- (void)dctViewControllerInternal_keyboardWillHideNotification:(NSNotification *)notification {
	[self.dctViewControllerInternal_dctViewController keyboardWillHideNotification:notification];
}

- (void)dctViewControllerInternal_keyboardDidHideNotification:(NSNotification *)notification {
	[self.dctViewControllerInternal_dctViewController keyboardDidHideNotification:notification];
}



- (void)dctViewControllerInternal_addKeyboardObservers {
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(dctViewControllerInternal_keyboardWillShowNotification:) 
												 name:UIKeyboardWillShowNotification
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(dctViewControllerInternal_keyboardDidShowNotification:) 
												 name:UIKeyboardDidShowNotification 
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(dctViewControllerInternal_keyboardWillHideNotification:)
												 name:UIKeyboardWillHideNotification 
											   object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self 
											 selector:@selector(dctViewControllerInternal_keyboardDidHideNotification:) 
												 name:UIKeyboardDidHideNotification 
											   object:nil];
}

- (void)dctViewControllerInternal_removeKeyboardObservers {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

- (void)dctViewControllerInternal_safeLoadNibNamed:(NSString *)nibName inBundle:(NSBundle *)bundle {
	
	if ([UINib dct_nibExistsWithNibName:nibName bundle:bundle])
		[bundle loadNibNamed:nibName owner:self options:nil];
}

- (UIViewController<DCTViewController> *)dctViewControllerInternal_dctViewController {
	
	if ([self conformsToProtocol:@protocol(DCTViewController)]) 
		return (UIViewController<DCTViewController> *)self;
	
	return nil;
	
}


@end
