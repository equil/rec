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

@interface IGRCReceiptsTableViewController : UITableViewController <NSFetchedResultsControllerDelegate, UISearchBarDelegate, UISearchDisplayDelegate>

@property(nonatomic, assign) Category *fromCategory;

@property(nonatomic, retain, readonly) NSFetchedResultsController *fetchedResultsController;

@property (retain, nonatomic) NSMutableArray *filteredArray;
@property (retain, nonatomic) IBOutlet UISearchBar *searchBar;

- (NSPredicate *)predicateForFetchedController;

@end
