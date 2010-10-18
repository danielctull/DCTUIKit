//
//  UIViewController+DCTTabBarController.m
//  DTKit
//
//  Created by Daniel Tull on 24.10.2009.
//  Copyright 2009 Daniel Tull. All rights reserved.
//

#import "UIViewController+DCTTabBarController.h"
#import "UIResponder+DCTNextResponderExtensions.h"

@implementation UIViewController (DCTTabBarController)

- (DCTTabBarController *)dctTabBarController {
	return (DCTTabBarController *)[self dct_nearestResponserOfClass:[DCTTabBarController class]];
}

- (NSArray *)allDCTTabBarControllers {
	return [self dct_allRespondersOfClass:[DCTTabBarController class]];
}
@end
