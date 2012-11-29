//
//  IGRCFourItemCell.m
//  receipt
//
//  Created by fredformout on 29.11.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import "IGRCFourItemCell.h"

@implementation IGRCFourItemCell

@synthesize fourItem = _fourItem;

- (void)configureCellWithFourItem:(FourItem *)fourItem
{
    _fourItem = fourItem;
    self.textLabel.text = fourItem.title;
}

@end
