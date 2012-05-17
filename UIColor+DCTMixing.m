//
//  UIColor+DCTMixing.m
//  Tweetopolis
//
//  Created by Daniel Tull on 12.03.2012.
//  Copyright (c) 2012 Daniel Tull. All rights reserved.
//

#import "UIColor+DCTMixing.h"

@implementation UIColor (DCTMixing)

- (UIColor *)dct_colorWithAlpha:(CGFloat)alpha {
	
	CGColorRef selfColorRef = self.CGColor;
	const CGFloat *components = CGColorGetComponents(selfColorRef);
	int selfNumberOfComponents = CGColorGetNumberOfComponents(selfColorRef);
	
	if (selfNumberOfComponents == 2)
		return [UIColor colorWithWhite:components[0] alpha:alpha];
	
	return [UIColor colorWithRed:components[0]
						   green:components[1]
							blue:components[2]
						   alpha:alpha];
}

@end
