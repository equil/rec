//
//  IGRCAppDelegate.m
//  receipt
//
//  Created by Alexey Rogatkin on 13.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "IGRCAppDelegate.h"
#import "FourItem.h"
#import "Setting.h"
#import "Receipt.h"
#import "Ingredient.h"
#import "Product.h"
#import "Category.h"
#import "Good.h"

static NSString *const METADATA_FILE_NAME = @"db.sqlite";

@implementation IGRCAppDelegate

@synthesize window = _window;
@synthesize segueStrategy = _segueStrategy;
@synthesize dataAccessManager = _dataAccessManager;
@synthesize link = _link;
@synthesize fullVersion = _fullVersion;

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

- (void)fillFourItems {
    
    FourItem *fourItem1 = [NSEntityDescription insertNewObjectForEntityForName:@"FourItem" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    fourItem1.title = @"Первый объект";
    fourItem1.descr = @"Здесь должно быть очень подробное описание для первого объекта";
    fourItem1.image = [UIImage imageNamed:@"test.png"];
    
    FourItem *fourItem2 = [NSEntityDescription insertNewObjectForEntityForName:@"FourItem" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    fourItem2.title = @"Второй объект";
    fourItem2.descr = @"Здесь должно быть очень подробное описание для второго объекта";
    fourItem2.image = [UIImage imageNamed:@"test.png"];
}

- (void)fillProducts {
    
    Category *c1 = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    c1.title = @"Салаты";
    c1.image = [UIImage imageNamed:@"test.png"];
    
    Category *c2 = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    c2.title = @"Десерты";
    c2.image = [UIImage imageNamed:@"test.png"];
    
    Category *c3 = [NSEntityDescription insertNewObjectForEntityForName:@"Category" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    c3.title = @"Супы";
    c3.image = [UIImage imageNamed:@"test.png"];
    
    
    
    Receipt *r1 = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    r1.title = @"Весенний салат";
    r1.image = [UIImage imageNamed:@"test.png"];
    r1.favorite = [NSNumber numberWithBool:NO];
    r1.howToPrepare = @"Способ приготовления данного блюда очень прост, и его вы узнаете из этого приложения";
    r1.descript = @"Здесь должно быть описание весеннего салата";
    r1.yield = [NSDecimalNumber decimalNumberWithString:@"200"];
    r1.category = c1;
    
    Receipt *r2 = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    r2.title = @"Салат цезарь";
    r2.image = [UIImage imageNamed:@"test.png"];
    r2.favorite = [NSNumber numberWithBool:NO];
    r2.howToPrepare = @"Способ приготовления данного блюда очень прост, и его вы узнаете из этого приложения";
    r2.descript = @"Здесь должно быть описание салата цезарь";
    r2.yield = [NSDecimalNumber decimalNumberWithString:@"300"];
    r2.category = c1;
    
    Receipt *r3 = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    r3.title = @"Яблочный пирог";
    r3.image = [UIImage imageNamed:@"test.png"];
    r3.favorite = [NSNumber numberWithBool:NO];
    r3.howToPrepare = @"Способ приготовления данного блюда очень прост, и его вы узнаете из этого приложения";
    r3.descript = @"Здесь должно быть описание яблочного пирога";
    r3.yield = [NSDecimalNumber decimalNumberWithString:@"400"];
    r3.category = c2;
    
    Receipt *r4 = [NSEntityDescription insertNewObjectForEntityForName:@"Receipt" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    r4.title = @"Уха";
    r4.image = [UIImage imageNamed:@"test.png"];
    r4.favorite = [NSNumber numberWithBool:NO];
    r4.howToPrepare = @"Способ приготовления данного блюда очень прост, и его вы узнаете из этого приложения";
    r4.descript = @"Здесь должно быть описание ухи";
    r4.yield = [NSDecimalNumber decimalNumberWithString:@"500"];
    r4.category = c3;
    
    
    
    Product *p1 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    p1.title = @"Помидоры";
    p1.unit = @"гр";
    
    Product *p2 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    p2.title = @"Огурцы";
    p2.unit = @"гр";
    
    Product *p3 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    p3.title = @"Курица";
    p3.unit = @"гр";

    Product *p4 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    p4.title = @"Салат";
    p4.unit = @"гр";
    
    Product *p5 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    p5.title = @"Баранина";
    p5.unit = @"гр";
    
    Product *p6 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    p6.title = @"Говядина";
    p6.unit = @"гр";
    
    Product *p7 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    p7.title = @"Яйца";
    p7.unit = @"гр";
    
    Product *p8 = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    p8.title = @"Соль";
    p8.unit = @"гр";
    
    
    
    Ingredient *i1 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    i1.weight = [NSDecimalNumber decimalNumberWithString:@"500"];
    i1.receipt = r1;
    i1.product = p1;
    
    Ingredient *i2 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    i2.weight = [NSDecimalNumber decimalNumberWithString:@"400"];
    i2.receipt = r1;
    i2.product = p2;
    
    Ingredient *i3 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    i3.weight = [NSDecimalNumber decimalNumberWithString:@"300"];
    i3.receipt = r1;
    i3.product = p3;
    
    Ingredient *i4 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    i4.weight = [NSDecimalNumber decimalNumberWithString:@"600"];
    i4.receipt = r2;
    i4.product = p4;
    
    Ingredient *i5 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    i5.weight = [NSDecimalNumber decimalNumberWithString:@"200"];
    i5.receipt = r2;
    i5.product = p5;
    
    Ingredient *i6 = [NSEntityDescription insertNewObjectForEntityForName:@"Ingredient" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    i6.weight = [NSDecimalNumber decimalNumberWithString:@"100"];
    i6.receipt = r2;
    i6.product = p6;
    
    
    
    Good *g1 = [NSEntityDescription insertNewObjectForEntityForName:@"Good" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    g1.product = p1;
    g1.weight = [NSDecimalNumber decimalNumberWithString:@"800"];
    
    Good *g2 = [NSEntityDescription insertNewObjectForEntityForName:@"Good" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    g2.product = p2;
    g2.weight = [NSDecimalNumber decimalNumberWithString:@"600"];
    
    Good *g3 = [NSEntityDescription insertNewObjectForEntityForName:@"Good" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    g3.product = p3;
    g3.weight = [NSDecimalNumber decimalNumberWithString:@"400"];
    
    Good *g4 = [NSEntityDescription insertNewObjectForEntityForName:@"Good" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
    g4.product = p4;
    g4.weight = [NSDecimalNumber decimalNumberWithString:@"200"];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    _fullVersion = YES;
    _link = [[NSString alloc] initWithString:@"http://www.google.ru"];
    
    //[self prepareDatabase];
    _segueStrategy = [[IGRCSeguePrepareStrategy alloc] init];
    _dataAccessManager = [[IGRCDataAccessManager alloc] init];

    if ([[self allEntities:@"Setting"] count] == 0)
    {
        [self fillProducts];
        [self fillFourItems];
        
        Setting *fillDone = [NSEntityDescription insertNewObjectForEntityForName:@"Setting" inManagedObjectContext:self.dataAccessManager.managedObjectContext];
        fillDone.name = @"fillDone";
        
        [self.dataAccessManager saveState];
    }
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {

}

- (void)applicationDidEnterBackground:(UIApplication *)application {

}

- (void)applicationWillEnterForeground:(UIApplication *)application {

}

- (void)handleBuy
{
    NSUserDefaults *enterCount = [[NSUserDefaults alloc] initWithUser:@"ReceiptUser"];
    
    if ([enterCount objectForKey:@"enterCount"] == nil)
    {
        [enterCount setInteger:1 forKey:@"enterCount"];
    }
    else
    {
        int value = [[enterCount objectForKey:@"enterCount"] intValue] + 1;
        
        if (value == 3)
        {
            [enterCount setInteger:0 forKey:@"enterCount"];
            [self showAlert];
        }
        else
        {
            [enterCount setInteger:value forKey:@"enterCount"];
        }
    }
    [enterCount release];
}

- (void)showAlert
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Внимание" message:@"Хотите купить полную версию приложения?" delegate:self cancelButtonTitle:@"Отмена" otherButtonTitles:@"OK", nil];
    [alert show];
    [alert release];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1)
    {
        [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_link]];
    }
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    if (_fullVersion == NO)
    {
        [self handleBuy];
    }
}

- (void)applicationWillTerminate:(UIApplication *)application {

}

@end
