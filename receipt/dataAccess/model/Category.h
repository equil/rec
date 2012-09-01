//
//  Category.h
//  receipt
//
//  Created by Alexey Rogatkin on 16.08.12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface Category : NSManagedObject

@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString * title;

@end
