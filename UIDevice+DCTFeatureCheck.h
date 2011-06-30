/*
 UIDevice+DCTFeatureCheck.h
 DCTUIKit
 
 Created by Daniel Tull on 28.8.2010.
 
 
 
 Copyright (c) 2010 Daniel Tull. All rights reserved.
 
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

/** Feature checking category.
 */
@interface UIDevice (DCTFeatureCheck)

/** A safe method to use for any OS.
 
 Ths method checks to see if `isMultitaskingSupported` exists on UIDevice, if
 it doesn't it returns NO.
 
 If the method does exist, it returns the result of calling it.
 
 @return YES if the device supports multitasking.
 */
- (BOOL)dct_multitaskingSupported;

/** Method to check for blocks support on the current device's OS.
 
 Blocks were brought in iOS4, so this checks if the major version number is 
 greater than or equal to 4.
 
 @return YES if blocks are supported.
 
 @see [UIDevice(DCTSystemVersion) dct_majorSystemVersion]
 */
- (BOOL)dct_blocksSupported;
@end
