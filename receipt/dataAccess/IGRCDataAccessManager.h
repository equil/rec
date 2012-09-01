//
//  Created by Alexey Rogatkin on 16.08.12.
//  
//


#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
#import "IGRCFavoritesBadgeObserver.h"

@interface IGRCDataAccessManager : NSObject

@property(readonly, retain, nonatomic) NSManagedObjectContext *managedObjectContext;
@property(readonly, retain, nonatomic) NSManagedObjectModel *managedObjectModel;
@property(readonly, retain, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property(nonatomic, retain, readonly) IGRCFavoritesBadgeObserver *favoriteBadgeObserver;

- (void)saveState;


@end