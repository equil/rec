//
//  IGRCCategoryTableViewController.m
//  receipt
//
//  Created by Alexey Rogatkin on 15.08.12.
//
//

#import <CoreData/CoreData.h>
#import "IGRCCategoryTableViewController.h"
#import "IGRCAppDelegate.h"
#import "IGRCSeguePrepareStrategy.h"
#import "IGRCDataAccessManager.h"
#import "Category.h"
#import "IGRCCategoryCell.h"

@interface IGRCCategoryTableViewController ()
@property(nonatomic, retain) NSFetchedResultsController *fetchResultsController;
@end

@implementation IGRCCategoryTableViewController {
    NSFetchedResultsController *_fetchResultsController;
}


- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    NSError *error = nil;
    BOOL success = [self.fetchResultsController performFetch:&error];
    if (!success) {
        NSLog(@"Error on fetching: %@", [error userInfo]);
    }
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    self.fetchResultsController = nil;
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
    static NSString *CellIdentifier = @"CategoryCell";
    IGRCCategoryCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];

    Category *category = [self.fetchResultsController objectAtIndexPath:indexPath];

    [cell configureForCategory:category];

    return cell;
}

#pragma mark - Core data behavior

- (NSFetchedResultsController *) fetchResultsController {
    if (_fetchResultsController == nil) {
        IGRCAppDelegate *delegate = (IGRCAppDelegate *)[[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;

        NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
        [fetch setEntity:[NSEntityDescription entityForName:@"Category"
                                     inManagedObjectContext:context]];

        NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"title" ascending:YES];
        [fetch setSortDescriptors:[NSArray arrayWithObject:sortDescriptor]];
        [sortDescriptor release];

        _fetchResultsController = [[NSFetchedResultsController alloc]
                initWithFetchRequest:fetch
                managedObjectContext:context
                  sectionNameKeyPath:nil
                           cacheName:nil];
        [fetch release];
    }
    return _fetchResultsController;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
}

- (void)dealloc {
    [_fetchResultsController release];
    [super dealloc];
}

@end
