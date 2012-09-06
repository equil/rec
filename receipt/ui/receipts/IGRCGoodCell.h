//
//  IGRCGoodCell.h
//  receipt
//
//  Created by fredformout on 03.09.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Product.h"
#import "Good.h"

@interface IGRCGoodCell : UITableViewCell
{
    id tableDelegate;
}

@property(nonatomic, assign) Product *product;
@property(nonatomic, retain) IBOutlet UILabel *nameLabel;
@property(nonatomic, retain) IBOutlet UILabel *weightLabel;

- (void) configureCellWithGood:(Good *)good andDelegate:(id)aDelegate;

@end
