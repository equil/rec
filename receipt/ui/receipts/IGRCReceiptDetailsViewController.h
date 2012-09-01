//
//  IGRCReceiptDetailsViewController.h
//  receipt
//
//  Created by Alexey Rogatkin on 08/19/12.
//___COPYRIGHT___
//



#import <CoreData/CoreData.h>

@class Receipt;

@interface IGRCReceiptDetailsViewController : UIViewController

@property(nonatomic, retain) IBOutlet UIImageView *receiptImage;
@property(nonatomic, retain) IBOutlet UILabel *descriptionLabel;
@property(nonatomic, retain) IBOutlet UILabel *howToPrepareLabel;
@property(nonatomic, retain) IBOutlet UIImageView *favoriteImageView;

@property(nonatomic, retain) Receipt *receipt;

- (IBAction)switchFavoriteState;

@end
