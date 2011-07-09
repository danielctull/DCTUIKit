//
//  DCTTableViewCell.m
//  Issues
//
//  Created by Daniel Tull on 9.07.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "DCTTableViewCell.h"
#import "UINib+DCTExtensions.h"

@implementation DCTTableViewCell

+ (NSString *)reuseIdentifier {
	return NSStringFromClass(self);
}

- (NSString *)reuseIdentifier {
	return [[self class] reuseIdentifier];
}

+ (NSString *)nibName {
	
	NSString *nibName = NSStringFromClass(self);
	
	if ([UINib dct_nibExistsWithNibName:nibName bundle:nil])
		return nibName;
	
	return nil;	
}

@end
