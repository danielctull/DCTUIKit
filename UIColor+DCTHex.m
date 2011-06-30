/*
 UIColor+DCTHex.m
 DCTUIKit
 
 Created by Daniel Tull on 8.1.2011.
 
 
 
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


#import "UIColor+DCTHex.h"

@implementation UIColor (DCTHex)

+ (UIColor *)dct_colorWithHexString:(NSString *)string {
	return [self dct_colorWithHexString:string alpha:1.0f];
}

+ (UIColor *)dct_colorWithHexString:(NSString *)string alpha:(CGFloat)alpha {
	
	unsigned int value;
	
	[[NSScanner scannerWithString:string] scanHexInt:&value];
	
	return [self dct_colorWithHexValue:(NSInteger)value alpha:alpha];	
}

+ (UIColor *)dct_colorWithHexValue:(NSInteger)value {
	return [UIColor dct_colorWithHexValue:value alpha:1.0f];
}

+ (UIColor *)dct_colorWithHexValue:(NSInteger)value alpha:(CGFloat)alpha {
	
	CGFloat red = ((CGFloat)((value & 0xFF0000) >> 16))/255.0f;
	CGFloat green = ((CGFloat)((value & 0xFF00) >> 8))/255.0f;
	CGFloat blue = ((CGFloat)(value & 0xFF))/255.0f;
	
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
