//
//  IGRCReceiptsTableViewController.h
//  receipt
//
//  Created by Alexey Rogatkin on 15.08.12.
//
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class Category;
@class NSFetchedResultsController;

@interface IGRCReceiptsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property(nonatomic, retain) Category *fromCategory;

@property(nonatomic, retain, readonly) NSFetchedResultsController *fetchedResultsController;

- (NSPredicate *)predicateForFetchedController;


@end
