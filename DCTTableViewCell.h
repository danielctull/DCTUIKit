//
//  DCTTableViewCell.h
//  Issues
//
//  Created by Daniel Tull on 9.07.2011.
//  Copyright 2011 Daniel Tull. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DCTTableViewCell : UITableViewCell

+ (NSString *)reuseIdentifier;
+ (NSString *)nibName;

- (void)configureCellWithObject:(id)object;

@end



@interface UITableView (DCTTableViewCell)
- (void)dct_registerDCTTableViewCellSubclass:(Class)tableViewCellSubclass;
@end
