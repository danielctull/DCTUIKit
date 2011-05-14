//
//  UIView+DCTAnimation.h
//  DCTUIKit
//
//  Created by Daniel Tull on 14/05/2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface UIView (DCTAnimation)

+ (UIViewAnimationCurve)dct_animationCurveForAnimationOptionCurve:(UIViewAnimationOptions)options;
+ (UIViewAnimationOptions)dct_animationOptionCurveForAnimationCurve:(UIViewAnimationCurve)curve;

@end
