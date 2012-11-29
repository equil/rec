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

- (void) configureCellWithFourItem:(FourItem *)fourItem;

@end
