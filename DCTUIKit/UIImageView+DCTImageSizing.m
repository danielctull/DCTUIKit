//
//  UIImageView+DCTImageSizing.m
//  Tweetville
//
//  Created by Daniel Tull on 17/05/2012.
//  Copyright (c) 2012 Daniel Tull Limited. All rights reserved.
//

#import "UIImageView+DCTImageSizing.h"

@implementation UIImageView (DCTImageSizing)

- (CGSize)dct_imageSize {
	CGFloat scale = [UIScreen mainScreen].scale;
	CGSize imageViewSize = self.bounds.size;
	return CGSizeMake(imageViewSize.width*scale, imageViewSize.height*scale);
}

@end
