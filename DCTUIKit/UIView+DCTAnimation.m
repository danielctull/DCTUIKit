/*
 UIView+DCTAnimation.m
 DCTUIKit
 
 Created by Daniel Tull on 14.5.2011.
 
 
 
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
