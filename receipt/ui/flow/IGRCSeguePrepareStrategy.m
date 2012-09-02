//
//  Created by Alexey Rogatkin on 15.08.12.
//  
//


#import "IGRCSeguePrepareStrategy.h"
#import "IGRCSeguePreparePrivate.h"
#import "IGRCFromCategoryToReceiptSegue.h"
#import "IGRCReceiptDetailsSeguePreparer.h"
#import "IGRCFromReceiptToIngredientSegue.h"

@interface IGRCSeguePrepareStrategy () {

}
@end

@implementation IGRCSeguePrepareStrategy {
@private
    NSDictionary *_strategies;
}

- (id)init {
    self = [super init];
    if (self != nil) {
        NSMutableDictionary *strategies = [[NSMutableDictionary alloc] initWithCapacity:3];
        [strategies setObject:[[[IGRCFromCategoryToReceiptSegue alloc] init] autorelease] forKey:@"CategoryToReceiptSegue"];
        [strategies setObject:[[[IGRCReceiptDetailsSeguePreparer alloc] init] autorelease] forKey:@"ReceiptDetailsSegue"];
        [strategies setObject:[[[IGRCFromReceiptToIngredientSegue alloc] init] autorelease] forKey:@"ReceiptToIngredientSegue"];
        _strategies = strategies;
    }
    return self;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue parameter:(id)sender {
    id<IGRCSeguePreparePrivate> strategy = [_strategies objectForKey:segue.identifier];

    [strategy prepareViewController:segue.destinationViewController
                  forTransitionFrom:segue.sourceViewController
                          parameter:sender];
}


- (void)dealloc {
    [_strategies release];
    [super dealloc];
}

@end