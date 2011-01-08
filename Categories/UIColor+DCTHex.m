//
//  UIColor+DCTHex.m
//  DCTUIKit
//
//  Created by Daniel Tull on 8.01.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "UIColor+DCTHex.h"

@implementation UIColor (DCTHex)

+ (UIColor *)dct_colorWithHexString:(NSString *)string {
	return [self dct_colorWithHexString:string alpha:1.0];
}

+ (UIColor *)dct_colorWithHexString:(NSString *)string alpha:(CGFloat)alpha {
	
	unsigned int value;
	
	[[NSScanner scannerWithString:string] scanHexInt:&value];
	
	return [self dct_colorWithHexValue:(NSInteger)value alpha:alpha];	
}

+ (UIColor *)dct_colorWithHexValue:(NSInteger)value {
	return [UIColor dct_colorWithHexValue:value alpha:1.0];
}

+ (UIColor *)dct_colorWithHexValue:(NSInteger)value alpha:(CGFloat)alpha {
	
	CGFloat red = ((CGFloat)((value & 0xFF0000) >> 16))/255.0;
	CGFloat green = ((CGFloat)((value & 0xFF00) >> 8))/255.0;
	CGFloat blue = ((CGFloat)(value & 0xFF))/255.0;
	
	return [UIColor colorWithRed:red green:green blue:blue alpha:alpha];
}

@end
