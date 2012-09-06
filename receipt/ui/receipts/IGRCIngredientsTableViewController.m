//
//  IGRCIngredientsTableViewController.m
//  receipt
//
//  Created by fredformout on 31.08.12.
//
//

#import "IGRCIngredientsTableViewController.h"
#import "IGRCAppDelegate.h"
#import "IGRCIngredientCell.h"
#import "Good.h"
#import "Product.h"

@interface IGRCIngredientsTableViewController ()
@property(nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@end

@implementation IGRCIngredientsTableViewController
{
@private
    Receipt *_fromReceipt;
    NSFetchedResultsController *_fetchedResultsController;
}

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (Receipt *)fromReceipt {
    return _fromReceipt;
}

- (void)setFromReceipt:(Receipt *)afromReceipt {
    self.fetchedResultsController = nil;
    _fromReceipt = afromReceipt;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    [delegate.segueStrategy prepareForSegue:segue parameter:sender];
}

- (NSPredicate *)predicateForFetchedController {
    return [NSPredicate predicateWithFormat:@"receipt == %@", self.fromReceipt];
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
        [fetch setEntity:[NSEntityDescription entityForName:@"Ingredient"
                                     inManagedObjectContext:context]];
        
        [fetch setPredicate:[self predicateForFetchedController]];
        
        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"product.title" ascending:YES];
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

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.fetchedResultsController.sections.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:(NSUInteger) section];    
    return [sectionInfo numberOfObjects];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"IngredientCell";
    IGRCIngredientCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    Ingredient *ingredient = [self.fetchedResultsController objectAtIndexPath:indexPath];
    
    [cell configureCellWithIngredient:ingredient andDelegate:self];
    
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
    [_fetchedResultsController release];
    [super dealloc];
}

- (IBAction)addAllIngredients
{
    NSArray *ingredients = [self getAllIngredients];
    for (Ingredient *i in ingredients) {
        [self buyItem:i];
    }
}

- (NSArray *)getAllIngredients
{
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
    
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:[NSEntityDescription entityForName:@"Ingredient"
                                 inManagedObjectContext:context]];
    
    [fetch setPredicate:[self predicateForFetchedController]];
    
    NSError *error;
    
    NSArray *ingredients = [context executeFetchRequest:fetch error:&error];
    
    [fetch release];
    
    return ingredients;
}

- (void)buyItem:(Ingredient *)ingredient
{
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
    
    NSArray *arr = [self entityExist:ingredient];
    if (arr == nil)
    {
        Good *newGood = [NSEntityDescription insertNewObjectForEntityForName:@"Good" inManagedObjectContext:context];
        newGood.product = ingredient.product;
        newGood.weight = ingredient.weight;
    }
    else
    {
        Good *g = (Good *)[arr objectAtIndex:0];
        g.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%i", [g.weight intValue] + [ingredient.weight intValue]]];
    }
    
    [delegate.dataAccessManager saveState];
    [self incFavoriteTabBarItemBadge];
}

- (void)incFavoriteTabBarItemBadge
{
    if (((UITabBarItem *)[self.tabBarController.tabBar.items objectAtIndex:2]).badgeValue == nil)
    {
        ((UITabBarItem *)[self.tabBarController.tabBar.items objectAtIndex:2]).badgeValue = @"1";
    }
    else
    {
        ((UITabBarItem *)[self.tabBarController.tabBar.items objectAtIndex:2]).badgeValue = [NSString stringWithFormat:@"%d", [((UITabBarItem *)[self.tabBarController.tabBar.items objectAtIndex:2]).badgeValue intValue] + 1];
    }
}

- (NSArray *)entityExist:(Ingredient *)ingredient
{
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Good" inManagedObjectContext:context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"product.title ==[c] %@", ingredient.product.title];
    
    [request setPredicate:predicate];
    [request setIncludesSubentities:NO];
    
    NSError *err;
    NSArray *good = [context executeFetchRequest:request error:&err];
    
    [request release];
    
    if ([good count] < 1 || good == nil)
        return nil;
    
    return good;
}

@end
