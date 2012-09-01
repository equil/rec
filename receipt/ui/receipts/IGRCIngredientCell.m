//
//  IGRCIngredientCell.m
//  receipt
//
//  Created by fredformout on 31.08.12.
//
//

#import "IGRCIngredientCell.h"
#import "Product.h"

@implementation IGRCIngredientCell

@synthesize nameLabel = _nameLabel;
@synthesize weightLabel = _weightLabel;
@synthesize buyBtn = _buyBtn;

- (void)configureCellWithIngredient:(Ingredient *)ingredient {
    _nameLabel.text = ingredient.product.title;
    _weightLabel.text = [NSString stringWithFormat:@"%i", [ingredient.weight intValue]];
}

- (void)dealloc {
    [_nameLabel release];
    [_weightLabel release];
    [_buyBtn release];
    [super dealloc];
}

@end
