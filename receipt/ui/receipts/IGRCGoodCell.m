//
//  IGRCGoodCell.m
//  receipt
//
//  Created by fredformout on 03.09.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import "IGRCGoodCell.h"

@implementation IGRCGoodCell

@synthesize product = _product;
@synthesize nameLabel = _nameLabel;
@synthesize weightLabel = _weightLabel;

- (void)configureCellWithGood:(Good *)good andDelegate:(id)aDelegate {
    tableDelegate = aDelegate;
    _product = good.product;
    _nameLabel.text = good.product.title;
    _weightLabel.text = [NSString stringWithFormat:@"%i %@.", [good.weight intValue], _product.unit];
}

- (void)dealloc {
    [_nameLabel release];
    [_weightLabel release];
    [super dealloc];
}

@end
