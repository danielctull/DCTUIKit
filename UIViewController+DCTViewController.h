//
//  UIViewController+DCTViewController.h
//  Issues
//
//  Created by Daniel Tull on 17.08.2011.
//  Copyright (c) 2011 Daniel Tull. All rights reserved.
//



@interface UIViewController (DCTViewController)

- (void)dct_sharedInit;
- (void)dct_viewDidLoad;
- (void)dct_loadView;
- (void)dct_viewWillDisappear:(BOOL)animated;
- (void)dct_viewWillAppear:(BOOL)animated;
- (void)dct_dismissModalViewController:(id)sender;

@end
