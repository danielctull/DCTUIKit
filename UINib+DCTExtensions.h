//
//  UINib+DCTExtensions.h
//  DCTUIKit
//
//  Created by Daniel Tull on 9.07.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UINib (DCTExtensions)

+ (BOOL)dct_nibExistsWithNibName:(NSString *)nibName bundle:(NSBundle *)bundle;

@end
