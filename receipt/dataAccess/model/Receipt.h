//
//  Receipt.h
//  receipt
//
//  Created by Alexey Rogatkin on 16.08.12.
//
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Category, Ingredient;

@interface Receipt : NSManagedObject

@property (nonatomic, retain) NSString * descript;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSString * howToPrepare;
@property (nonatomic, retain) UIImage *image;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSDecimalNumber * yield;
@property (nonatomic, retain) Category *category;
@property (nonatomic, retain) NSOrderedSet *ingredients;
@end

@interface Receipt (CoreDataGeneratedAccessors)

- (void)insertObject:(Ingredient *)value inIngredientsAtIndex:(NSUInteger)idx;
- (void)removeObjectFromIngredientsAtIndex:(NSUInteger)idx;
- (void)insertIngredients:(NSArray *)value atIndexes:(NSIndexSet *)indexes;
- (void)removeIngredientsAtIndexes:(NSIndexSet *)indexes;
- (void)replaceObjectInIngredientsAtIndex:(NSUInteger)idx withObject:(Ingredient *)value;
- (void)replaceIngredientsAtIndexes:(NSIndexSet *)indexes withIngredients:(NSArray *)values;
- (void)addIngredientsObject:(Ingredient *)value;
- (void)removeIngredientsObject:(Ingredient *)value;
- (void)addIngredients:(NSOrderedSet *)values;
- (void)removeIngredients:(NSOrderedSet *)values;
@end
