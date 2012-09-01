//
//  Good.h
//  receipt
//
//  Created by fredformout on 31.08.12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Product;

@interface Good : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * weight;
@property (nonatomic, retain) Product *product;

@end
