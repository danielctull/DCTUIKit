/*
 DCTContainerViewController.h
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

#import <UIKit/UIKit.h>


@interface DCTContainerViewController : UIViewController {
	NSMutableArray *childViewControllers;
}

/// @name Managing the View Controllers

/** View controllers managed by the container. */
@property (nonatomic, readonly) NSArray *viewControllers;

/** The main view controller.
 
 This view controller is the one that will be asked for specific
 details, such as `shouldAutorotateToInterfaceOrientation:`. 
 */
@property (nonatomic, retain) UIViewController *mainViewController;

/** Add a view controller to the array of managed view controllers.
 
 If this is the first view controller added, it will automatically become
 the mainViewController.
 
 @param viewController The view controller to be added.
 */
- (void)addViewController:(UIViewController *)viewController;

/** Remove the given view controller from the array of view controllers.
 
 @param viewController The view controller to be removed.
 */
- (void)removeViewController:(UIViewController *)viewController;

@end
