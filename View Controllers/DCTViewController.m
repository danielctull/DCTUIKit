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
- (NSString *)dctInternal_nibNameForClass:(Class)aClass inBundle:(NSBundle *)bundle;
@end

@implementation DCTViewController

@synthesize resizeViewToFitKeyboard;

#pragma mark - NSObject 

- (void)awakeFromNib {
	[super awakeFromNib];
	[self title];
}

#pragma mark - UIViewController

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

- (void)loadView {
	
	
	// If the subclass has loaded a view and called super, return so that
	// multiple views aren't loaded.
	
	if ([self isViewLoaded]) return;
	
	// Making the nib loading nature explicit. Will try to load a nib that has 
	// the same name as the view controller class or one of its superclasses.
	
	NSBundle *bundle = self.nibBundle;
	if (!bundle) bundle = [NSBundle mainBundle];
	
	NSString *nib = self.nibName;
	
	if ((nib)) [bundle loadNibNamed:nib owner:self options:nil];
	
	if ([self isViewLoaded]) return;
	
	Class theClass = [self class];
	
	while (![self isViewLoaded] && [theClass isSubclassOfClass:[UIViewController class]]) {
		NSString *nibName = [self dctInternal_nibNameForClass:theClass inBundle:bundle];
		[bundle loadNibNamed:nibName owner:self options:nil];
		theClass = [theClass superclass];
	}
	
	if ([self isViewLoaded]) return;
	
	[super loadView];
}

- (NSString *)dctInternal_nibNameForClass:(Class)aClass inBundle:(NSBundle *)bundle {
	
	// If the class is not a UIViewController subclass, we don't need to check for a nib.
	// if (![aClass isSubclassOfClass:[UIViewController class]]) return nil;
	
	// Get the classname, see if a xib with that name exists in the resources, is so return it.
	NSString *classname = NSStringFromClass(aClass);
	NSString *path = [bundle pathForResource:classname ofType:@"nib"];
	
	if (!(path)) path = [bundle pathForResource:classname ofType:@"xib"]; // Is this check needed? All xibs will get compiled to nibs right?
	
	if ((path)) return classname;
	
	return nil;
}

#pragma mark -
#pragma mark IBAction

- (IBAction)dismissModalViewController:(id)sender {
	[self.parentViewController dismissModalViewControllerAnimated:YES];
}

#pragma mark -
#pragma mark IBOutlet

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

- (NSString *)title {
	NSString *t = super.title;
	
	if (!(t) || [t isEqualToString:@""]) {
		t = [self loadTitle];
		self.title = t;
	}
	
	return t;
}

- (NSString *)loadTitle {
	return super.title;
}

#pragma mark -
#pragma mark UIKeyboard Notification methods

- (void)keyboardWillShowNotification:(NSNotification *)notification {
	if (self.resizeViewToFitKeyboard) [self dctInternal_keyboardWillHide:NO withNotification:notification];
}

- (void)keyboardDidShowNotification:(NSNotification *)notification {}

- (void)keyboardWillHideNotification:(NSNotification *)notification {
	if (self.resizeViewToFitKeyboard) [self dctInternal_keyboardWillHide:YES withNotification:notification];
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
