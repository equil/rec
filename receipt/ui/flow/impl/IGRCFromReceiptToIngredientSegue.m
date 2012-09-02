//
//  IGRCFromReceiptToIngredientSegue.m
//  receipt
//
//  Created by fredformout on 02.09.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import "IGRCFromReceiptToIngredientSegue.h"
#import "IGRCIngredientsTableViewController.h"
#import "IGRCReceiptDetailsViewController.h"
#import "IGRCIngredientCell.h"

@implementation IGRCFromReceiptToIngredientSegue

- (void)prepareViewController:(IGRCIngredientsTableViewController *)destinationController
            forTransitionFrom:(IGRCReceiptDetailsViewController *)sourceController
                    parameter:(IGRCIngredientCell *)sender {
    Receipt *receipt = sourceController.receipt;
    destinationController.fromReceipt = receipt;
    destinationController.navigationItem.title = receipt.title;
}

@end
