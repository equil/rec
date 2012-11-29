//
//  FourItem.h
//  receipt
//
//  Created by fredformout on 29.11.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>


@interface FourItem : NSManagedObject

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) id image;
@property (nonatomic, retain) NSString * descr;

@end
