//
//  UIViewController+DCTViewController.m
//  Issues
//
//  Created by Daniel Tull on 17.08.2011.
//  Copyright (c) 2011 Daniel Tull. All rights reserved.
//

#import "UIViewController+DCTViewController.h"
#import "UINib+DCTExtensions.h"
#import "UIResponder+DCTNextResponderExtensions.h"
#import "UIView+DCTAnimation.h"
#import "DCTViewController.h"

@interface UIViewController ()
- (void)dctInternal_addKeyboardObservers;
- (void)dctInternal_removeKeyboardObservers;

- (void)dctInternal_keyboardWillShowNotification:(NSNotification *)notification;
- (void)dctInternal_keyboardDidShowNotification:(NSNotification *)notification;
- (void)dctInternal_keyboardWillHideNotification:(NSNotification *)notification;
- (void)dctInternal_keyboardDidHideNotification:(NSNotification *)notification;

- (void)dctInternal_keyboardWillHide:(BOOL)hidden withNotification:(NSNotification *)notification;

- (void)dctInternal_safeLoadNibNamed:(NSString *)nibName inBundle:(NSBundle *)bundle;

@property (nonatomic, readonly) UIViewController<DCTViewController> *dctViewController;

@end

@implementation UIViewController (DCTViewController)

- (void)dct_viewWillAppear:(BOOL)animated {
	[self.navigationController setToolbarHidden:YES animated:YES]; // OVERRIDE THIS IN VIEWWILLAPPEAR: FOR THE MINORITY OF CASES WHERE THE TOOLBAR IS USED
	[self dctInternal_addKeyboardObservers];	
}

- (void)dct_viewWillDisappear:(BOOL)animated {
	[self dctInternal_removeKeyboardObservers];	
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
	
	[self dctInternal_safeLoadNibNamed:self.nibName inBundle:bundle];
	
	if ([self isViewLoaded]) return;
	
	Class theClass = [self class];
	
	while (![self isViewLoaded] && [theClass isSubclassOfClass:[UIViewController class]]) {
		[self dctInternal_safeLoadNibNamed:NSStringFromClass(theClass) inBundle:bundle];
		theClass = [theClass superclass];
	}
	
	if ([self isViewLoaded]) return;
	
	[self loadView];
}

- (void)dctInternal_keyboardWillShowNotification:(NSNotification *)notification {	
	if (self.dctViewController.resizeViewToFitKeyboard) [self dctInternal_keyboardWillHide:NO withNotification:notification];
	
	[self.dctViewController keyboardWillShowNotification:notification];
}

- (void)dctInternal_keyboardDidShowNotification:(NSNotification *)notification {
	[self.dctViewController keyboardDidShowNotification:notification];
}

- (void)dctInternal_keyboardWillHideNotification:(NSNotification *)notification {
	if (self.dctViewController.resizeViewToFitKeyboard) [self dctInternal_keyboardWillHide:YES withNotification:notification];
	
	[self.dctViewController keyboardWillHideNotification:notification];
}

- (void)dctInternal_keyboardDidHideNotification:(NSNotification *)notification {
	[self.dctViewController keyboardDidHideNotification:notification];
}

#pragma mark - Internal

- (void)dctInternal_addKeyboardObservers {
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dctInternal_keyboardWillShowNotification:) name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dctInternal_keyboardDidShowNotification:) name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dctInternal_keyboardWillHideNotification:) name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(dctInternal_keyboardDidHideNotification:) name:UIKeyboardDidHideNotification object:nil];
}

- (void)dctInternal_removeKeyboardObservers {
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidShowNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
	[[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardDidHideNotification object:nil];
}

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
	
	if (self.dctViewController.resizeViewToBottomEdgeOfScreenBeforeResizingForKeyboard) {
		
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
						 
						 if (hidden && !self.dctViewController.resizeViewToBottomEdgeOfScreenBeforeResizingForKeyboard)
							 view.frame = originalRect;
						 else 
							 view.frame = CGRectMake(originalRect.origin.x, 
													 originalRect.origin.y,
													 originalRect.size.width, 
													 endRect.origin.y);
						 
					 } completion:^(BOOL finished) {
						 
						 if (hidden && self.dctViewController.resizeViewToBottomEdgeOfScreenBeforeResizingForKeyboard)
							 view.frame = originalRect;		
					 }];
}

- (void)dctInternal_safeLoadNibNamed:(NSString *)nibName inBundle:(NSBundle *)bundle {
	
	if ([UINib dct_nibExistsWithNibName:nibName bundle:bundle])
		[bundle loadNibNamed:nibName owner:self options:nil];
}

- (UIViewController<DCTViewController> *)dctViewController {
	
	if ([self conformsToProtocol:@protocol(DCTViewController)]) 
		return (UIViewController<DCTViewController> *)self;
	
	return nil;
	
}


@end
