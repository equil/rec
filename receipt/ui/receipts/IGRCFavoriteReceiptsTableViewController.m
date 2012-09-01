//
//  Created by Alexey Rogatkin on 19.08.12.
//  
//


#import "IGRCFavoriteReceiptsTableViewController.h"
#import "IGRCAppDelegate.h"

@interface IGRCFavoriteReceiptsTableViewController () {

}
@end

@implementation IGRCFavoriteReceiptsTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
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


@end