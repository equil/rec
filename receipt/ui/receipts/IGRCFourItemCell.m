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
@synthesize image = _image;
@synthesize label = _label;

- (void)configureCellWithFourItem:(FourItem *)fourItem
{
    _fourItem = fourItem;
    self.image.image = fourItem.image;
    self.label.text = fourItem.title;
}

- (void)dealloc
{
    self.image = nil;
    self.label = nil;
    [super dealloc];
}

@end
