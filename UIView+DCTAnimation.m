//
//  UIView+DCTAnimation.m
//  DCTUIKit
//
//  Created by Daniel Tull on 14/05/2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "UIView+DCTAnimation.h"


@implementation UIView (DCTAnimation)

+ (UIViewAnimationCurve)dct_animationCurveForAnimationOptionCurve:(UIViewAnimationOptions)options {
	
	if ((options & UIViewAnimationOptionCurveEaseInOut) == UIViewAnimationOptionCurveEaseInOut) return UIViewAnimationCurveEaseInOut;
	if ((options & UIViewAnimationOptionCurveEaseIn) == UIViewAnimationOptionCurveEaseIn) return UIViewAnimationCurveEaseIn;
	if ((options & UIViewAnimationOptionCurveEaseOut) == UIViewAnimationOptionCurveEaseOut) return UIViewAnimationCurveEaseOut;
	if ((options & UIViewAnimationOptionCurveLinear) == UIViewAnimationOptionCurveLinear) return UIViewAnimationCurveLinear;
	
	return UIViewAnimationCurveEaseInOut;	
}

+ (UIViewAnimationOptions)dct_animationOptionCurveForAnimationCurve:(UIViewAnimationCurve)curve {
	
	if (curve == UIViewAnimationCurveEaseInOut) return UIViewAnimationOptionCurveEaseInOut;
	if (curve == UIViewAnimationCurveEaseIn) return UIViewAnimationOptionCurveEaseIn;
	if (curve == UIViewAnimationCurveEaseOut) return UIViewAnimationOptionCurveEaseOut;
	if (curve == UIViewAnimationCurveLinear) return UIViewAnimationOptionCurveLinear;
	
	return UIViewAnimationOptionCurveEaseInOut;
}

@end
