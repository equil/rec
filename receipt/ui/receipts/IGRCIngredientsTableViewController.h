//
//  IGRCIngredientsTableViewController.h
//  receipt
//
//  Created by fredformout on 31.08.12.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "Receipt.h"

@interface IGRCIngredientsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property(nonatomic, retain) Receipt *fromReceipt;
@property(nonatomic, retain, readonly) NSFetchedResultsController *fetchedResultsController;

- (NSPredicate *)predicateForFetchedController;

@end
