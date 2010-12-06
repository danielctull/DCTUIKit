/*
 UIDevice+DCTSystemVersion.m
 DCTUIKit
 
 Created by Daniel Tull on 26.06.2009.
 
 
 
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

#import "UIDevice+DCTSystemVersion.h"

@interface UIDevice ()
- (NSInteger)dctInternal_systemVersionComponentAtIndex:(NSInteger)index;
@end

@implementation UIDevice (DCTSystemVersion)

- (NSInteger)dct_majorSystemVersion {
	return [self dctInternal_systemVersionComponentAtIndex:0];
}

- (NSInteger)dct_minorSystemVersion {
	return [self dctInternal_systemVersionComponentAtIndex:1];
}

- (NSInteger)dct_maintenanceSystemVersion {
	return [self dctInternal_systemVersionComponentAtIndex:2];
}

#pragma mark -
#pragma mark Internal

- (NSInteger)dctInternal_systemVersionComponentAtIndex:(NSInteger)index {
	
	NSArray *components = [self.systemVersion componentsSeparatedByString:@"."];
	
	if ([components count] <= index) return -1;
	
	return [[components objectAtIndex:index] integerValue];
}

@end
