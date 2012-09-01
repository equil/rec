//
//  Ingredient.h
//  receipt
//
//  Created by Alexey Rogatkin on 16.08.12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface Ingredient : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * weight;
@property (nonatomic, retain) Product *product;

@end
