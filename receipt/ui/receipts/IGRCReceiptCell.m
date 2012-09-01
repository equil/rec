//
//  IGRCReceiptCell.m
//  receipt
//
//  Created by Alexey Rogatkin on 08/19/12.
//___COPYRIGHT___
//

#import "IGRCReceiptCell.h"
#import "Receipt.h"

@implementation IGRCReceiptCell

@synthesize nameLabel = _nameLabel;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize image = _image;

- (void)configureWithReceipt:(Receipt *)receipt {
    self.nameLabel.text = receipt.title;
    self.descriptionLabel.text = receipt.descript;
    [self.image setImage:receipt.image];
}

- (void)dealloc {
    [_nameLabel release];
    [_descriptionLabel release];
    [_image release];
    [super dealloc];
}


@end
