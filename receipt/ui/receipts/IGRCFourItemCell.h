//
//  IGRCFourItemCell.h
//  receipt
//
//  Created by fredformout on 29.11.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourItem.h"

@interface IGRCFourItemCell : UITableViewCell

@property(nonatomic, assign) FourItem *fourItem;
@property(nonatomic, retain) IBOutlet UIImageView *image;
@property(nonatomic, retain) IBOutlet UILabel *label;

- (void) configureCellWithFourItem:(FourItem *)fourItem;

@end
