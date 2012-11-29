//
//  IGRCFourToDetailSegue.m
//  receipt
//
//  Created by fredformout on 29.11.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import "IGRCFourToDetailSegue.h"
#import "IGRCFourTableViewController.h"
#import "IGRCFourDetailViewController.h"
#import "IGRCFourItemCell.h"

@implementation IGRCFourToDetailSegue

- (void)prepareViewController:(IGRCFourDetailViewController *)destinationController
            forTransitionFrom:(IGRCFourTableViewController *)sourceController
                    parameter:(IGRCFourItemCell *)sender {
    NSIndexPath *path = [sourceController.tableView indexPathForCell:sender];
    FourItem *fourItem = [sourceController.fetchResultsController objectAtIndexPath:path];
    destinationController.fromFourItem = fourItem;
    destinationController.navigationItem.title = fourItem.title;
}

@end
