//
//  Good.h
//  receipt
//
//  Created by fredformout on 23.01.13.
//  Copyright (c) 2013 Alexey Rogatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface Good : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * weight;
@property (nonatomic, retain) NSNumber * checked;
@property (nonatomic, retain) Product *product;

@end
