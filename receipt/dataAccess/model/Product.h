//
//  Product.h
//  receipt
//
//  Created by Alexey Rogatkin on 16.08.12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Product : NSManagedObject

@property (nonatomic, retain) NSString * title;

@end
