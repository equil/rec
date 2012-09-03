//
//  IGRCStoreTableViewController.h
//  receipt
//
//  Created by fredformout on 03.09.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NSFetchedResultsController;

@interface IGRCStoreTableViewController : UITableViewController <NSFetchedResultsControllerDelegate>
@property(nonatomic, retain, readonly) NSFetchedResultsController *fetchResultsController;
@end
