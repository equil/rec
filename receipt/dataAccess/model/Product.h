//
//  Product.h
//  receipt
//
//  Created by fredformout on 06.09.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSString * unit;

@end
