//
//  UINib+DCTExtensions.m
//  DCTUIKit
//
//  Created by Daniel Tull on 9.07.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "UINib+DCTExtensions.h"

@implementation UINib (DCTExtensions)

+ (BOOL)dct_nibExistsWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle {
	
	if (nibName == nil) return NO;
	
	if (bundle == nil) bundle = [NSBundle mainBundle];
	
	NSString *path = [bundle pathForResource:nibName ofType:@"nib"];
	
	if (path == nil) path = [bundle pathForResource:nibName ofType:@"xib"]; // Is this check needed? All xibs will get compiled to nibs right?
	
	if (path == nil) return NO;
	
	return YES;
}

@end
