//
//  IGRCAddGoodViewController.h
//  receipt
//
//  Created by fredformout on 03.09.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface IGRCAddGoodViewController : UIViewController

@property (nonatomic, retain) IBOutlet UITextField *nameField;
@property (nonatomic, retain) IBOutlet UITextField *weightField;
@property (nonatomic, retain) IBOutlet UIButton *addButton;
@property (nonatomic, retain) IBOutlet UIButton *cancelButton;
@property (nonatomic, retain) IBOutlet UIView *infoView;
@property (nonatomic, retain) IBOutlet UILabel *infoLabel;

- (IBAction)addButtonClick;
- (IBAction)cancelButtonClick;

@end
