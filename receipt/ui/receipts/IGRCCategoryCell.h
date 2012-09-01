//
//  IGRCCategoryCell.h
//  receipt
//
//  Created by Alexey Rogatkin on 18.08.12.
//
//

#import <UIKit/UIKit.h>

@class Category;

@interface IGRCCategoryCell : UITableViewCell

@property(nonatomic, retain) IBOutlet UILabel *nameLabel;
@property(nonatomic, retain) IBOutlet UIImageView *image;

- (void) configureForCategory: (Category *) aCategory;

@end
