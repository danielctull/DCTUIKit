//
//  UIColor+DCTHex.h
//  DCTUIKit
//
//  Created by Daniel Tull on 8.01.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIColor (DCTHex)



/** Accessor to get a color object from a hexadecimal-based string. The returned 
 color has an alpha value of 1.
 
 @param string The string in hexadecimal format for example: @"FFE378".
 
 @return The created UIColor object. 
 */
+ (UIColor *)dct_colorWithHexString:(NSString *)string;



/** Accessor to get a color object from a hexadecimal-based string.
 
 @param string The string in hexadecimal format for example: @"FFE378".
 @param alpha  The value to use for the alpha.
 
 @return The created UIColor object. 
 */
+ (UIColor *)dct_colorWithHexString:(NSString *)string alpha:(CGFloat)alpha;



/** Accessor to get a color object from a hexadecimal value. The returned 
 color has an alpha value of 1.
 
 @param value The value in hexadecimal format for example: 0xFFE378.
 
 @return The created UIColor object. 
 */
+ (UIColor *)dct_colorWithHexValue:(NSInteger)value;



/** Accessor to get a color object from a hexadecimal value.
 
 @param value The value in hexadecimal format for example: 0xFFE378.
 @param alpha The value to use for the alpha.
 
 @return The created UIColor object. 
 */
+ (UIColor *)dct_colorWithHexValue:(NSInteger)value alpha:(CGFloat)alpha;

@end
