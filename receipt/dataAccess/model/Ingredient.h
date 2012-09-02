//
//  Ingredient.h
//  receipt
//
//  Created by fredformout on 02.09.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product, Receipt;

@interface Ingredient : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * weight;
@property (nonatomic, retain) Product *product;
@property (nonatomic, retain) Receipt *receipt;

@end
