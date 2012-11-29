//
//  IGRCFourTableViewController.h
//  receipt
//
//  Created by fredformout on 29.11.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>

@class NSFetchedResultsController;

@interface IGRCFourTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>

@property(nonatomic, retain, readonly) NSFetchedResultsController *fetchResultsController;

@end
