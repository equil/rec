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

@interface IGRCReceiptsTableViewController ()
@property(nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@end

@implementation IGRCReceiptsTableViewController {
@private
    BOOL _showOnlyFavorite;
    Category *_fromCategory;
    NSFetchedResultsController *_fetchedResultsController;
}

- (id)initWithStyle:(UITableViewStyle)style {
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSPredicate *)predicateForFetchedController {
    return [NSPredicate predicateWithFormat:@"category == %@", self.fromCategory];
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

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView endUpdates];
}



- (Category *)fromCategory {
    return _fromCategory;
}

- (void)setFromCategory:(Category *)aFromCategory {
    self.fetchedResultsController = nil;
    [_fromCategory release];
    _fromCategory = [aFromCategory retain];
}


- (void)viewDidLoad {
    [super viewDidLoad];
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
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate.segueStrategy prepareForSegue:segue parameter:sender];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:(NSUInteger) section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ReceiptCell";
    IGRCReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    Receipt *receipt = [self.fetchedResultsController objectAtIndexPath:indexPath];
    [cell configureWithReceipt:receipt];

    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here. Create and push another view controller.
    /*
     <#DetailViewController#> *detailViewController = [[<#DetailViewController#> alloc] initWithNibName:@"<#Nib name#>" bundle:nil];
     // ...
     // Pass the selected object to the new view controller.
     [self.navigationController pushViewController:detailViewController animated:YES];
     [detailViewController release];
     */
}

- (void)dealloc {
    self.fetchedResultsController = nil;
    [_fromCategory release];
    [_fetchedResultsController release];
    [super dealloc];
}

@end
