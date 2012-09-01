//
//  Created by Alexey Rogatkin on 19.08.12.
//  
//


#import <CoreData/CoreData.h>
#import "IGRCReceiptDetailsSeguePreparer.h"
#import "IGRCReceiptDetailsViewController.h"
#import "IGRCReceiptsTableViewController.h"
#import "IGRCReceiptCell.h"

@interface IGRCReceiptDetailsSeguePreparer () {

}
@end

@implementation IGRCReceiptDetailsSeguePreparer

- (void)prepareViewController:(IGRCReceiptDetailsViewController *)destinationController
            forTransitionFrom:(IGRCReceiptsTableViewController *)sourceController
                    parameter:(IGRCReceiptCell *)initiator {
    NSIndexPath *const path = [sourceController.tableView indexPathForCell:initiator];
    destinationController.receipt = [sourceController.fetchedResultsController objectAtIndexPath:path];

    UIScrollView *scrollView = (UIScrollView *) destinationController.view;
    UIView *view = [scrollView.subviews objectAtIndex:0];
    scrollView.contentSize = CGSizeMake(view.frame.size.width, view.frame.size.height);}


@end