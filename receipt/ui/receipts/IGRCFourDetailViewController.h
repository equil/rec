//
//  IGRCFourDetailViewController.h
//  receipt
//
//  Created by fredformout on 29.11.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FourItem.h"

@interface IGRCFourDetailViewController : UIViewController

@property(nonatomic, assign) FourItem *fromFourItem;
@property(nonatomic, retain) IBOutlet UIImageView *imageView;
@property(nonatomic, retain) IBOutlet UITextView *textView;

@end
