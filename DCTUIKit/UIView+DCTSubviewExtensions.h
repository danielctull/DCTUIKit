/*
 UIView+DCTSubviewExtensions.h
 DCTUIKit
 
 Created by Daniel Tull on 13.10.2009.
 
 
 
 Copyright (c) 2009 Daniel Tull. All rights reserved.
 
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

@interface UIView (DCTSubviewExtensions)

/** Removes all subviews from the receiver. */
- (void)dct_removeAllSubviews;



/** Finds a subview of the receiver with the kind of the given class.
 
 This traverses down the view hierachy until a suitable class is found.
 
 @param aClass The class the returned view should be.
 @return A view of kind of the given class.
 */
- (id)dct_subviewOfKindOfClass:(Class)aClass;



/** Finds a superview of the receiver with the kind of the given class.
 
 This traverses up the view hierachy until a suitable class is found.
 
 @param aClass The class the returned view should be.
 @return A view of kind of the given class.
 */
- (id)dct_superviewOfKindOfClass:(Class)aClass;

/** Returns whether or not the receiver has subviews.
 
 @return YES if the receiver has any subviews, NO if it doesn't.
 */
- (BOOL)dct_hasSubviews;
@end
