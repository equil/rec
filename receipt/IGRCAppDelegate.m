//
//  IGRCAppDelegate.m
//  receipt
//
//  Created by Alexey Rogatkin on 13.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IGRCAppDelegate.h"

static NSString *const METADATA_FILE_NAME = @"db.sqlite";

@implementation IGRCAppDelegate

@synthesize window = _window;
@synthesize segueStrategy = _segueStrategy;
@synthesize dataAccessManager = _dataAccessManager;


- (void)dealloc {
    [_window release];
    [_segueStrategy release];
    [_dataAccessManager release];
    [super dealloc];
}

- (NSURL *)applicationDocumentsDirectory {
    return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentDirectory inDomains:NSUserDomainMask] lastObject];
}

- (NSURL *)databasePath {
    return [[self applicationDocumentsDirectory] URLByAppendingPathComponent:METADATA_FILE_NAME];
}

- (NSURL *)draftDatabasePath {
    return [[[NSBundle mainBundle] bundleURL] URLByAppendingPathComponent:METADATA_FILE_NAME];
}


- (void)prepareDatabase {
    NSURL *database = [self databasePath];
    NSFileManager *manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:[database path]]) {
        NSError *error;
        BOOL success = [manager copyItemAtPath:[[self draftDatabasePath] path] toPath:[database path] error:&error];
        if (!success) {
            NSLog(@"Error in preparing migrating metadata db. %@", error.userInfo);
        }
    }
}

- (NSArray *)allEntities:(NSString *)name {
    NSManagedObjectContext *context = self.dataAccessManager.managedObjectContext;
    NSFetchRequest *fetch = [[NSFetchRequest alloc] init];
    [fetch setEntity:[NSEntityDescription entityForName:name
                                 inManagedObjectContext:context]];

    NSError *error = nil;
    NSArray *result = [context executeFetchRequest:fetch error:&error];
    if (result == nil) {
        result = [NSArray array];
        NSLog(@"Error on fetch: %@", [error userInfo]);
    }
    [fetch release];

    return result;
}

//- (void)fillImagesDbg {
//
//    for (Receipt *receipt in [self allEntities:@"Receipt"]) {
//        receipt.image = [UIImage imageNamed:@"test.png"];
//    }
//    for (Category *category in [self allEntities:@"Category"]) {
//        category.image = [UIImage imageNamed:@"test.png"];
//    }
//    [self.dataAccessManager saveState];
//
//}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self prepareDatabase];
    _segueStrategy = [[IGRCSeguePrepareStrategy alloc] init];
    _dataAccessManager = [[IGRCDataAccessManager alloc] init];

//    [self fillImagesDbg];

    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    /*
     Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
     Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
     */
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    /*
     Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
     If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
     */
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    /*
     Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
     */
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    /*
     Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
     */
}

- (void)applicationWillTerminate:(UIApplication *)application {
    /*
     Called when the application is about to terminate.
     Save data if appropriate.
     See also applicationDidEnterBackground:.
     */
}

@end
