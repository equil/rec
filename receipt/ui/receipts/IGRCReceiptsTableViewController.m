//
//  IGRCReceiptsTableViewController.m
//  receipt
//
//  Created by Alexey Rogatkin on 15.08.12.
//
//

#import <CoreData/CoreData.h>
#import "IGRCReceiptsTableViewController.h"
#import "Category.h"
#import "IGRCAppDelegate.h"
#import "Receipt.h"
#import "IGRCReceiptCell.h"
#import "IGRCReceiptDetailsViewController.h"

@interface IGRCReceiptsTableViewController ()
@property(nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@end

@implementation IGRCReceiptsTableViewController {
@private
    BOOL _showOnlyFavorite;
    Category *_fromCategory;
    NSFetchedResultsController *_fetchedResultsController;
}
@synthesize filteredArray = _filteredArray;
@synthesize searchBar = _searchBar;

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSPredicate *)predicateForFetchedController {
    return [NSPredicate predicateWithFormat:@"category == %@", self.fromCategory ];
}

- (void)fetchData {
    NSError *error = nil;
    self.fetchedResultsController = nil;
    BOOL success = [self.fetchedResultsController performFetch:&error];
    if (!success) {
        NSLog(@"Error in fetching: %@", error.userInfo);
    }
}

- (NSFetchedResultsController *)fetchedResultsController {
    if (_fetchedResultsController == nil) {
        IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;

        NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
        [fetch setEntity:[NSEntityDescription entityForName:@"Receipt"
                                     inManagedObjectContext:context]];

        [fetch setPredicate:[self predicateForFetchedController]];

        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
        [fetch setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [sortDescriptor release];

        _fetchedResultsController = [[NSFetchedResultsController alloc]
                initWithFetchRequest:fetch
                managedObjectContext:context
                  sectionNameKeyPath:nil cacheName:nil];
        _fetchedResultsController.delegate = self;
        [fetch release];
    }

    return _fetchedResultsController;

}


- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView endUpdates];
}


- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
		   atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type {
	switch (type) {
		case NSFetchedResultsChangeInsert:
			[self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;

		case NSFetchedResultsChangeDelete:
			[self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
	   atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
	  newIndexPath:(NSIndexPath *)newIndexPath {
	UITableView *tableView = self.tableView;

	switch (type) {
		case NSFetchedResultsChangeInsert:
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;

		case NSFetchedResultsChangeDelete:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;

		case NSFetchedResultsChangeUpdate:

            break;

		case NSFetchedResultsChangeMove:
			[tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
			[tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
			break;
	}
}




- (Category *)fromCategory {
    return _fromCategory;
}

- (void)setFromCategory:(Category *)aFromCategory {
    self.fetchedResultsController = nil;
    _fromCategory = aFromCategory;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    self.filteredArray = [NSMutableArray array];
}

- (void)viewDidUnload {
    [super viewDidUnload];
    self.fetchedResultsController = nil;
}

- (void)viewWillAppear:(BOOL)animated {
    [self fetchData];
    [super viewWillAppear:animated];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([sender isKindOfClass:[IGRCReceiptCell class]])
    {
        NSIndexPath *path = [((IGRCReceiptsTableViewController* )segue.sourceViewController).tableView indexPathForCell:sender];
        ((IGRCReceiptDetailsViewController* )segue.destinationViewController).receipt = [((IGRCReceiptsTableViewController* )segue.sourceViewController).fetchedResultsController objectAtIndexPath:path];
    }
    else
    {
        NSIndexPath *path = [((IGRCReceiptsTableViewController* )segue.sourceViewController).searchDisplayController.searchResultsTableView indexPathForCell:sender];
        ((IGRCReceiptDetailsViewController* )segue.destinationViewController).receipt = [((IGRCReceiptsTableViewController* )segue.sourceViewController).filteredArray objectAtIndex:path.row];
    }
    
    UIScrollView *scrollView = (UIScrollView *)((IGRCReceiptDetailsViewController* )segue.destinationViewController).view;
    UIView *view = [scrollView.subviews objectAtIndex:0];
    scrollView.contentSize = CGSizeMake(view.frame.size.width, view.frame.size.height);
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return 1;
    }
    else
    {
        return self.fetchedResultsController.sections.count;   
    }
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        return [self.filteredArray count];
    } else {
        id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:(NSUInteger) section];
        return [sectionInfo numberOfObjects];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ReceiptCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    if ( cell == nil ) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    Receipt *receipt;
    
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        receipt = [self.filteredArray objectAtIndex:indexPath.row];
        cell.textLabel.text = receipt.title;
    } else {
        receipt = [self.fetchedResultsController objectAtIndexPath:indexPath];
        [(IGRCReceiptCell *)cell configureWithReceipt:receipt];
    }

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    if (tableView == self.searchDisplayController.searchResultsTableView)
    {
        [self performSegueWithIdentifier:@"ReceiptDetailsSegue" sender:[tableView cellForRowAtIndexPath:indexPath]];
    }
}

-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    [self.filteredArray removeAllObjects];
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title contains[c] %@",searchText];
    self.filteredArray = [NSMutableArray arrayWithArray:[[self.fetchedResultsController fetchedObjects] filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

- (void)dealloc {
    self.fetchedResultsController = nil;
    [_fetchedResultsController release];
    [_filteredArray release];
    self.searchBar = nil;
    [super dealloc];
}

@end
