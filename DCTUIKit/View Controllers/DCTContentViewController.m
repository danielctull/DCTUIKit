/*
 DCTContentViewController.m
 DCTUIKit
 
 Created by Daniel Tull on 23.10.2009.
 
 
 
 Copyright (c) 2009 Daniel Tull. All rights reserved.
 
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

#import "DCTContentViewController.h"

@implementation DCTContentViewController

@synthesize position, barView, contentView, viewController, barHidden;

#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	[viewController release];
	[barView release];
	[contentView release];
    [super dealloc];
}

#pragma mark -
#pragma mark UIViewController

- (void)viewDidLoad {
	[super viewDidLoad];
	
	[self.view addSubview:self.contentView];
	
	self.barView.frame = [self barFrame];
	
	if (self.position == DCTContentBarPositionTop)
		self.barView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleBottomMargin);
	else if (self.position == DCTContentBarPositionBottom)
		self.barView.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleTopMargin);
	else if (self.position == DCTContentBarPositionRight)
		self.barView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleLeftMargin);
	else if (self.position == DCTContentBarPositionLeft)
		self.barView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleRightMargin);
	
	[self.view addSubview:self.barView];
	self.contentView.frame = [self contentFrame];
	self.contentView.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	self.view.autoresizingMask = (UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth);
	self.viewController.view.autoresizingMask = (UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight);
	self.viewController.view.frame = self.contentView.bounds;
	self.viewController.wantsFullScreenLayout = YES;
	
	[self.contentView addSubview:self.viewController.view];
}

- (void)viewDidUnload {
	[super viewDidUnload];
	self.contentView = nil;
	self.barView = nil;
}

- (UITabBarItem *)tabBarItem {
	return [self.viewController tabBarItem];
}

- (UINavigationItem *)navigationItem {
	return [self.viewController navigationItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
	[self.viewController didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark UIViewController view event methods

- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	[self.viewController viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	[self.viewController viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	[self.viewController viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	[self.viewController viewDidDisappear:animated];
}

#pragma mark -
#pragma mark UIViewController autorotation methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return [self.viewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.viewController willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.viewController willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	[self.viewController didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	[self.viewController willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	[super didRotateFromInterfaceOrientation:toInterfaceOrientation];
	[self.viewController didRotateFromInterfaceOrientation:toInterfaceOrientation];
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
	[self.viewController willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
}

#pragma mark -
#pragma mark DCTContentViewController

- (id)initWithViewController:(UIViewController *)aViewController {
	
	if (!(self = [super init])) return nil;
	
	self.wantsFullScreenLayout = YES;
	viewController = [aViewController retain];
	
	return self;
}

- (UIView *)contentView {
	if (!contentView) contentView = [[UIView alloc] initWithFrame:[self contentFrame]];
	return contentView;
}

- (UIView *)barView {
	if (!barView) barView = [[UIView alloc] initWithFrame:CGRectMake(0.0, 0.0, self.view.bounds.size.width, 44.0)];
	return barView;
}

- (void)setBarHidden:(BOOL)aBool {
	[self setBarHidden:aBool animated:NO completion:nil];
}

- (void)setBarHidden:(BOOL)hidden animated:(BOOL)animated {
	[self setBarHidden:hidden animated:animated completion:nil];
}

- (void)setBarHidden:(BOOL)hidden animated:(BOOL)animated completion:(void (^)(BOOL finished))completion {
	
	if (barHidden == hidden) return;
	
	barHidden = hidden;
	
	if (self.position == DCTContentBarPositionNone) return;
		
	NSTimeInterval time = 0.333;
	if (!animated) time = 0.0;
	
	[UIView animateWithDuration:time animations:^{
		
		if (hidden) {
			self.contentView.frame = self.view.bounds;
			
			if (self.position == DCTContentBarPositionBottom)
				self.barView.frame = CGRectMake(self.barView.frame.origin.x, self.barView.frame.origin.y + self.barView.frame.size.height, self.barView.frame.size.width, self.barView.frame.size.height);
			
			else if (self.position == DCTContentBarPositionTop)
				self.barView.frame = CGRectMake(self.barView.frame.origin.x, self.barView.frame.origin.y - self.barView.frame.size.height, self.barView.frame.size.width, self.barView.frame.size.height);
			
			else if (self.position == DCTContentBarPositionRight)
				self.barView.frame = CGRectMake(self.barView.frame.origin.x + self.barView.frame.size.width, self.barView.frame.origin.y, self.barView.frame.size.width, self.barView.frame.size.height);
			
			else if (self.position == DCTContentBarPositionLeft)
				self.barView.frame = CGRectMake(self.barView.frame.origin.x - self.barView.frame.size.width, self.barView.frame.origin.y, self.barView.frame.size.width, self.barView.frame.size.height);
			
		} else {
			self.barView.frame = [self barFrame];
			self.contentView.frame = [self contentFrame];
		}
		
		
		
	} completion:completion];
}

#pragma mark -
#pragma mark Framing methods

- (CGRect)barFrame {
	if (self.position == DCTContentBarPositionBottom)
		return CGRectMake(0.0,
						  self.view.frame.size.height - self.barView.frame.size.height,
						  self.view.frame.size.width,
						  self.barView.frame.size.height);
	
	else if (self.position == DCTContentBarPositionTop)
		return CGRectMake(0.0, 
						  0.0, 
						  self.view.frame.size.width, 
						  self.barView.frame.size.height);
	
	else if (self.position == DCTContentBarPositionRight)
		return CGRectMake(self.view.frame.size.width - self.barView.frame.size.width,
						  0.0,
						  self.barView.frame.size.width,
						  self.view.frame.size.height);
	
	else if (self.position == DCTContentBarPositionLeft)
		return CGRectMake(0.0, 
						  0.0,
						  self.barView.frame.size.width, 
						  self.view.frame.size.height);
	
	return CGRectZero;
}

- (CGRect)contentFrame {
	
	if (!self.barView) return self.view.bounds;
	
	if (self.position == DCTContentBarPositionBottom)
		return CGRectMake(0.0, 
						  0.0, 
						  self.view.frame.size.width, 
						  self.view.frame.size.height - self.barView.frame.size.height);
	
	else if (self.position == DCTContentBarPositionTop)
		return CGRectMake(0.0,
						  self.barView.frame.size.height, 
						  self.view.frame.size.width, 
						  self.view.frame.size.height - self.barView.frame.size.height);
	
	else if (self.position == DCTContentBarPositionRight)
		return CGRectMake(0.0, 
						  0.0, 
						  self.view.frame.size.width - self.barView.frame.size.width, 
						  self.view.frame.size.height);
	
	else if (self.position == DCTContentBarPositionLeft)
		return CGRectMake(self.barView.frame.size.width, 
						  0.0, 
						  self.view.frame.size.width - self.barView.frame.size.width, 
						  self.view.frame.size.height);
	
	return self.view.frame;
}

#pragma mark -
#pragma mark Methods for subclasses to use

- (void)loadContentView {}


@end
