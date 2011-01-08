//
//  UIColor+DCTComponents.m
//  DCTUIKit
//
//  Created by Daniel Tull on 8.01.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "UIColor+DCTComponents.h"

@implementation UIColor (DCTComponents)

- (CGFloat)dct_red {
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	return components[0];
}

- (CGFloat)dct_green {
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	return components[1];
}

- (CGFloat)dct_blue {
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	return components[2];
}

- (CGFloat)dct_alpha {
	const CGFloat *components = CGColorGetComponents(self.CGColor);
	return components[3];
}

@end
