//
//  TestDCTViewController.h
//  DCTUIKit
//
//  Created by Daniel Tull on 13/05/2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import "DCTViewController.h"

@interface TestDCTViewController : DCTViewController {}

- (IBAction)dismiss:(id)sender;
- (IBAction)toggleResizeViewToBottomEdgeOfScreenBeforeResizingForKeyboard:(id)sender;

@property (nonatomic, assign) IBOutlet UITextField *textField;

@end
