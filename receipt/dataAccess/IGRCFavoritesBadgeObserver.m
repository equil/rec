//
//  Created by Alexey Rogatkin on 25.08.12.
//  
//


#import <CoreData/CoreData.h>
#import "IGRCFavoritesBadgeObserver.h"
#import "Receipt.h"

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
    }
    return self;
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

@end