/*
 UIColor+DCTHex.h
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
