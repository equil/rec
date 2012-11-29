//
//  IGRCFourDetailViewController.m
//  receipt
//
//  Created by fredformout on 29.11.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import "IGRCFourDetailViewController.h"

@interface IGRCFourDetailViewController ()

@end

@implementation IGRCFourDetailViewController

@synthesize fromFourItem = _fromFourItem;
@synthesize imageView = _imageView;
@synthesize textView = _textView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    [_imageView setImage:_fromFourItem.image];
    [_textView setText:_fromFourItem.descr];
}

- (void)dealloc
{
    self.imageView = nil;
    self.textView = nil;
    [super dealloc];
}

@end
