/*
 DCTContainerViewController.m
 DCTUIKit
 
 Created by Daniel Tull on 03.04.2010.
 
 
 
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

#import "DCTContainerViewController.h"

@interface DCTContainerViewController ()
- (void)dctInternal_createChildViewControllersIfNeeded;
@end

@implementation DCTContainerViewController

@synthesize mainViewController;

#pragma mark -
#pragma mark NSObject

- (void)dealloc {
	[mainViewController release], mainViewController = nil;
	[childViewControllers release], childViewControllers = nil;
	[super dealloc];
}

#pragma mark -
#pragma mark DCTContainerViewController

- (void)addViewController:(UIViewController *)vc {
	[self dctInternal_createChildViewControllersIfNeeded];
	[childViewControllers addObject:vc];
}

- (void)removeViewController:(UIViewController *)vc {
	[self dctInternal_createChildViewControllersIfNeeded];
	if ([childViewControllers containsObject:vc])
		[childViewControllers removeObject:vc];
}

- (void)setMainViewController:(UIViewController *)vc {
	if ([mainViewController isEqual:vc]) return;
	
	id oldVC = mainViewController;
	mainViewController = [vc retain];
	[oldVC release];
	
	[self addViewController:mainViewController];
}

- (UIViewController *)mainViewController {
	if (!mainViewController) {
		
		if ([childViewControllers count] < 1)
			return nil;
		
		return [childViewControllers objectAtIndex:0];
	}
	
	return [[mainViewController retain] autorelease];
}

- (NSArray *)viewControllers {
	[self dctInternal_createChildViewControllersIfNeeded];
	return [NSArray arrayWithArray:childViewControllers];
}

#pragma mark -
#pragma mark UIViewController view event methods


- (void)viewDidAppear:(BOOL)animated {
	[super viewDidAppear:animated];
	
	for (UIViewController *vc in self.viewControllers)
		[vc viewDidAppear:animated];
}

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	for (UIViewController *vc in self.viewControllers)
		[vc viewWillAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	for (UIViewController *vc in self.viewControllers)
		[vc viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated {
	[super viewDidDisappear:animated];
	
	for (UIViewController *vc in self.viewControllers)
		[vc viewDidDisappear:animated];
}

#pragma mark -
#pragma mark UIViewController autorotation methods

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	return [self.mainViewController shouldAutorotateToInterfaceOrientation:toInterfaceOrientation];
}

- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	for (UIViewController *vc in self.viewControllers)
		[vc willRotateToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)willAnimateRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	for (UIViewController *vc in self.viewControllers)
		[vc willAnimateRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didRotateFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation {
	[super didRotateFromInterfaceOrientation:fromInterfaceOrientation];
	
	for (UIViewController *vc in self.viewControllers)
		[vc didRotateFromInterfaceOrientation:fromInterfaceOrientation];
}

- (void)willAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
	
	for (UIViewController *vc in self.viewControllers)
		[vc willAnimateFirstHalfOfRotationToInterfaceOrientation:toInterfaceOrientation duration:duration];
}

- (void)didAnimateFirstHalfOfRotationToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
	[super didRotateFromInterfaceOrientation:toInterfaceOrientation];
	
	for (UIViewController *vc in self.viewControllers)
		[vc didRotateFromInterfaceOrientation:toInterfaceOrientation];
}

- (void)willAnimateSecondHalfOfRotationFromInterfaceOrientation:(UIInterfaceOrientation)fromInterfaceOrientation duration:(NSTimeInterval)duration {
	[super willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
	
	for (UIViewController *vc in self.viewControllers)
		[vc willAnimateSecondHalfOfRotationFromInterfaceOrientation:fromInterfaceOrientation duration:duration];
}

#pragma mark -
#pragma mark Internal

- (void)dctInternal_createChildViewControllersIfNeeded {
	if (!childViewControllers) childViewControllers = [[NSMutableArray alloc] init];
}

@end
