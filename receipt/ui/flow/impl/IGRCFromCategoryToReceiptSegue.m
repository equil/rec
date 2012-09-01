//
//  Created by Alexey Rogatkin on 15.08.12.
//  
//


#import "IGRCFromCategoryToReceiptSegue.h"
#import "IGRCReceiptsTableViewController.h"
#import "IGRCCategoryTableViewController.h"
#import "Category.h"
#import "IGRCCategoryCell.h"

@interface IGRCFromCategoryToReceiptSegue () {

}
@end

@implementation IGRCFromCategoryToReceiptSegue

- (void)prepareViewController:(IGRCReceiptsTableViewController *)destinationController
            forTransitionFrom:(IGRCCategoryTableViewController *)sourceController
                    parameter:(IGRCCategoryCell *)sender {
    NSIndexPath *path = [sourceController.tableView indexPathForCell:sender];
    Category *category = [sourceController.fetchResultsController objectAtIndexPath:path];
    destinationController.fromCategory = category;
    destinationController.navigationItem.title = category.title;
}

@end