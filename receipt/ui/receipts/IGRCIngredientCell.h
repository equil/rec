//
//  IGRCIngredientCell.h
//  receipt
//
//  Created by fredformout on 31.08.12.
//
//

#import <UIKit/UIKit.h>
#import "Ingredient.h"

@interface IGRCIngredientCell : UITableViewCell

@property(nonatomic, retain) IBOutlet UILabel *nameLabel;
@property(nonatomic, retain) IBOutlet UILabel *weightLabel;
@property(nonatomic, retain) IBOutlet UIButton *buyBtn;

- (void) configureCellWithIngredient:(Ingredient *)ingredient;

@end
