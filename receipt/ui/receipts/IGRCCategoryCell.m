//
//  IGRCCategoryCell.m
//  receipt
//
//  Created by Alexey Rogatkin on 18.08.12.
//
//

#import "IGRCCategoryCell.h"
#import "Category.h"

@implementation IGRCCategoryCell

@synthesize nameLabel = _nameLabel;
@synthesize image = _image;

- (void)configureForCategory:(Category *)aCategory {
    self.nameLabel.text = aCategory.title;
    [self.image setImage:aCategory.image];
}

- (void)dealloc {
    [_nameLabel release];
    [_image release];
    [super dealloc];
}


@end
