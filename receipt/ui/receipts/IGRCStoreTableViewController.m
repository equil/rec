//
//  IGRCCategoryTableViewController.m
//  receipt
//
//  Created by Alexey Rogatkin on 15.08.12.
//
//

#import <CoreData/CoreData.h>
#import "IGRCStoreTableViewController.h"
#import "IGRCAppDelegate.h"
#import "IGRCSeguePrepareStrategy.h"
#import "IGRCDataAccessManager.h"
#import "Good.h"
#import "IGRCGoodCell.h"

@interface IGRCStoreTableViewController ()
@property(nonatomic, retain) NSFetchedResultsController *fetchResultsController;
@end

@implementation IGRCStoreTableViewController {
    NSFetchedResultsController *_fetchResultsController;
}

@synthesize addBarItem;
@synthesize checked = _checked;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    NSError *error = nil;
    BOOL success = [self.fetchResultsController performFetch:&error];
    if (!success) {
        NSLog(@"Error on fetching: %@", [error userInfo]);
    }
    
    self.navigationItem.leftBarButtonItem = self.editButtonItem;
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.fetchResultsController = nil;
    self.addBarItem = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    self.tabBarController.tabBar.selectedItem.badgeValue = nil;
    [self.tableView reloadData];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate.segueStrategy prepareForSegue:segue parameter:sender];
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [[self.fetchResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"GoodCell";
    IGRCGoodCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Good *good = [self.fetchResultsController objectAtIndexPath:indexPath];
    
    [cell configureCellWithGood:good andDelegate:self];
    
    return cell;
}

#pragma mark - Core data behavior

- (NSFetchedResultsController *) fetchResultsController {
    if (_fetchResultsController == nil) {
        IGRCAppDelegate *delegate = (IGRCAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
        
        NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
        [fetch setEntity:[NSEntityDescription entityForName:@"Good"
                                     inManagedObjectContext:context]];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"product.title" ascending:YES];
        [fetch setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [sortDescriptor release];
        
        _fetchResultsController = [[NSFetchedResultsController alloc]
                                   initWithFetchRequest:fetch
                                   managedObjectContext:context
                                   sectionNameKeyPath:nil
                                   cacheName:nil];
        
        _fetchResultsController.delegate = self;
        
        [fetch release];
    }
    return _fetchResultsController;
}

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView beginUpdates];
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
	[self.tableView endUpdates];
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

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Good *good = [self.fetchResultsController objectAtIndexPath:indexPath];
    BOOL temp = ![good.checked boolValue];
    
    IGRCAppDelegate *delegate = (IGRCAppDelegate *)[[UIApplication sharedApplication] delegate];
    good.checked = [NSNumber numberWithBool:temp];
    [delegate.dataAccessManager saveState];
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    
    if (temp == NO)
    {
        cell.accessoryType = UITableViewCellAccessoryNone;
    }
    else
    {
        cell.accessoryType = UITableViewCellAccessoryCheckmark;
    }
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        IGRCAppDelegate *delegate = (IGRCAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
        
        [context deleteObject: [self.fetchResultsController objectAtIndexPath:indexPath]];
        [delegate.dataAccessManager saveState];
    }
}

- (void)refreshChecked
{
    [_checked release];
    _checked = [[NSMutableArray alloc] init];
    
    if ([[self.fetchResultsController sections] count] > 0)
    {
        for (int j = 0; j < [[[self.fetchResultsController sections] objectAtIndex:0] numberOfObjects]; j++)
        {
            [_checked addObject:[NSNumber numberWithBool:NO]];
        }
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

- (IBAction)deleteAllGoods
{
    IGRCAppDelegate *delegate = (IGRCAppDelegate *)[[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
    NSArray *goods = [self getAllGoods];
    
    for (Good *g in goods)
    {
        [context deleteObject:g];
    }
    
    [delegate.dataAccessManager saveState];
}

- (NSArray *)getAllGoods
{
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Good" inManagedObjectContext:context]];
    
    [request setIncludesSubentities:NO];
    
    NSError *err;
    NSArray *goods = [context executeFetchRequest:request error:&err];
    
    [request release];
    
    return goods;
}

- (NSArray *)getGoods
{
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Good" inManagedObjectContext:context]];
    
    [request setIncludesSubentities:NO];
    
    NSError *err;
    NSArray *goods = [context executeFetchRequest:request error:&err];
    
    [request release];
    
    return goods;
}

- (void)dealloc {
    [_fetchResultsController release];
    [addBarItem release];
    [_checked release];
    [super dealloc];
}

@end
