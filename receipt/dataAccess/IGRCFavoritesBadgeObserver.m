//
//  Created by Alexey Rogatkin on 25.08.12.
//  
//


#import <CoreData/CoreData.h>
#import "IGRCFavoritesBadgeObserver.h"
#import "Receipt.h"
#import "Product.h"
#import "Ingredient.h"

@interface IGRCFavoritesBadgeObserver () {

}
@end

@implementation IGRCFavoritesBadgeObserver

@synthesize context = _context;
@synthesize arrayOfFavoritesDone;
@synthesize arrayOfFavoritesTemp;

- (id)initWithContext:(NSManagedObjectContext *)context {
    self = [super init];
    if (self) {
        _context = [context retain];
        arrayOfFavoritesDone = [[NSMutableArray alloc] init];
        NSArray *array = [self getArrayOfFavorites];
        for (Receipt* r in array) {
            [arrayOfFavoritesDone addObject:r.title];
        }
        
        arrayOfFavoritesTemp = [[NSMutableArray alloc] init];
        
//--------------------------------------------------
//        NSArray *arrP = [self getArrayOfProducts];
//        NSLog(@"arrP %d", [arrP count]);
//
//        NSArray *arrR = [self getArrayOfReceipts];
//        NSLog(@"arrR %d", [arrR count]);        
//        
//        for (int i = 0; i < 6; i++)
//        {
//            Ingredient *newI = [NSEntityDescription
//                                            insertNewObjectForEntityForName:@"Ingredient"
//                                            inManagedObjectContext:_context];
//            newI.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",[self randomFloatBetween:100.0 and:700.0]]];
//            
//            if (i < 3)
//                newI.receipt = [arrR objectAtIndex:0];
//            else
//                newI.receipt = [arrR objectAtIndex:1];            
//            
//            newI.product = [arrP objectAtIndex:i];
//        }
//        
//        Ingredient *newI = [NSEntityDescription
//                            insertNewObjectForEntityForName:@"Ingredient"
//                            inManagedObjectContext:_context];
//        newI.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%f",[self randomFloatBetween:100.0 and:700.0]]];
//        
//        newI.receipt = [arrR objectAtIndex:0];
//        newI.product = [arrP objectAtIndex:3];
//        
//        NSError *error;
//        [_context save:&error];
        
//        NSArray *arrI = [self getArrayOfIngredients];
//        NSLog(@"arrI %d", [arrI count]);
//        for (Ingredient *i in arrI) {
//            NSLog(@"%@", i.receipt.title);
////            if (j > 6)
////                [_context deleteObject:i];
////            j++;
//        }
//--------------------------------------------------

    }
    return self;
}

- (float)randomFloatBetween:(float)smallNumber and:(float)bigNumber {
    float diff = bigNumber - smallNumber;
    return (((float) (arc4random() % ((unsigned)RAND_MAX + 1)) / RAND_MAX) * diff) + smallNumber;
}

- (void)dealloc {
    [_context release];
    [arrayOfFavoritesDone release];
    [arrayOfFavoritesTemp release];
    [super dealloc];
}

+ (id)objectWithContext:(NSManagedObjectContext *)context {
    return [[[IGRCFavoritesBadgeObserver alloc] initWithContext:context] autorelease];
}

- (NSArray *)getArrayOfFavorites
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Receipt" inManagedObjectContext:_context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"favorite == %@", [NSNumber numberWithBool:YES] ];
    
    [request setPredicate:predicate];
    
    [request setIncludesSubentities:NO];
    
    NSError *err;
    NSArray *receipts = [_context executeFetchRequest:request error:&err];

    [request release];
    return receipts;
}

- (NSArray *)getArrayOfReceipts
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Receipt" inManagedObjectContext:_context]];
    
    [request setIncludesSubentities:NO];
    
    NSError *err;
    NSArray *receipts = [_context executeFetchRequest:request error:&err];
    
    [request release];
    return receipts;
}

- (NSArray *)getArrayOfProducts
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Product" inManagedObjectContext:_context]];
    
    [request setIncludesSubentities:NO];
    
    NSError *err;
    NSArray *products= [_context executeFetchRequest:request error:&err];
    
    [request release];
    return products;
}

- (NSArray *)getArrayOfIngredients
{
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Ingredient" inManagedObjectContext:_context]];
    
    [request setIncludesSubentities:NO];
    
    NSError *err;
    NSArray *ingredients= [_context executeFetchRequest:request error:&err];
    
    [request release];
    return ingredients;
}

@end