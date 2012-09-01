//
//  IGRCReceiptCell.h
//  receipt
//
//  Created by Alexey Rogatkin on 08/19/12.
//___COPYRIGHT___
//



@class Receipt;

@interface IGRCReceiptCell : UITableViewCell

@property(nonatomic, retain) IBOutlet UILabel *nameLabel;
@property(nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property(nonatomic, retain) IBOutlet UIImageView *image;

- (void) configureWithReceipt: (Receipt *) receipt;

@end
