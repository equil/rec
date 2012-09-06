//
//  IGRCIngredientCell.m
//  receipt
//
//  Created by fredformout on 31.08.12.
//
//

#import "IGRCAppDelegate.h"
#import "IGRCIngredientCell.h"
#import "Product.h"
#import "Good.h"

@implementation IGRCIngredientCell

@synthesize product = _product;
@synthesize ingredient = _ingredient;
@synthesize nameLabel = _nameLabel;
@synthesize weightLabel = _weightLabel;
@synthesize buyBtn = _buyBtn;

- (void)configureCellWithIngredient:(Ingredient *)ingredient andDelegate:(id)aDelegate {
    tableDelegate = aDelegate;
    _ingredient = ingredient;
    _product = ingredient.product;
    _nameLabel.text = ingredient.product.title;
    _weightLabel.text = [NSString stringWithFormat:@"%i %@.", [ingredient.weight intValue], _product.unit];
}

- (void)dealloc {
    [_nameLabel release];
    [_weightLabel release];
    [_buyBtn release];
    [super dealloc];
}

- (IBAction)buyItem
{
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;

    NSArray *arr = [self entityExist];
    if (arr == nil)
    {
        Good *newGood = [NSEntityDescription insertNewObjectForEntityForName:@"Good" inManagedObjectContext:context];
        newGood.product = _product;
        newGood.weight = _ingredient.weight;
    }
    else
    {
        Good *g = (Good *)[arr objectAtIndex:0];
        g.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%i", [g.weight intValue] + [_ingredient.weight intValue]]];
    }
    
    [delegate.dataAccessManager saveState];
    [self incFavoriteTabBarItemBadge];
}

- (void)incFavoriteTabBarItemBadge
{
    if (((UITabBarItem *)[((UIViewController *)tableDelegate).tabBarController.tabBar.items objectAtIndex:2]).badgeValue == nil)
    {
        ((UITabBarItem *)[((UIViewController *)tableDelegate).tabBarController.tabBar.items objectAtIndex:2]).badgeValue = @"1";
    }
    else
    {
        ((UITabBarItem *)[((UIViewController *)tableDelegate).tabBarController.tabBar.items objectAtIndex:2]).badgeValue = [NSString stringWithFormat:@"%d", [((UITabBarItem *)[((UIViewController *)tableDelegate).tabBarController.tabBar.items objectAtIndex:2]).badgeValue intValue] + 1];
    }
}

- (NSArray *)entityExist
{
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Good" inManagedObjectContext:context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"product.title ==[c] %@", _product.title];
    
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
