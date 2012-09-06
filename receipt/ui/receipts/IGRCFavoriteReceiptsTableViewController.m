//
//  Created by Alexey Rogatkin on 19.08.12.
//  
//


#import "IGRCFavoriteReceiptsTableViewController.h"
#import "IGRCAppDelegate.h"
#import "Receipt.h"

@interface IGRCFavoriteReceiptsTableViewController () {

}
@end

@implementation IGRCFavoriteReceiptsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}


- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    self.tabBarController.tabBar.selectedItem.badgeValue = nil;
    
    IGRCAppDelegate *delegate = (IGRCAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    for (id obj in delegate.dataAccessManager.favoriteBadgeObserver.arrayOfFavoritesTemp)
    {
        [delegate.dataAccessManager.favoriteBadgeObserver.arrayOfFavoritesDone addObject:obj];
    }
    
    [delegate.dataAccessManager.favoriteBadgeObserver.arrayOfFavoritesTemp removeAllObjects];
}


- (NSPredicate *)predicateForFetchedController {
    return [NSPredicate predicateWithFormat:@"favorite == YES"];
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {   
        IGRCAppDelegate *delegate = (IGRCAppDelegate *)[[UIApplication sharedApplication] delegate];
        [delegate.dataAccessManager.favoriteBadgeObserver.arrayOfFavoritesDone removeObject:((Receipt *)[self.fetchedResultsController objectAtIndexPath:indexPath]).title];
        ((Receipt *)[self.fetchedResultsController objectAtIndexPath:indexPath]).favorite = [NSNumber numberWithBool:NO];
        [delegate.dataAccessManager saveState];
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForDeleteConfirmationButtonForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return @"Удалить";
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    [self.tableView setEditing:editing animated:animated];
}

- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return UITableViewCellEditingStyleDelete;
}

@end