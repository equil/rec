//
//  Created by Alexey Rogatkin on 15.08.12.
//  
//


#import "IGRCSeguePrepareStrategy.h"
#import "IGRCSeguePreparePrivate.h"
#import "IGRCFromCategoryToReceiptSegue.h"
#import "IGRCReceiptDetailsSeguePreparer.h"

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
        NSMutableDictionary *strategies = [[NSMutableDictionary alloc] initWithCapacity:1];
        [strategies setObject:[[[IGRCFromCategoryToReceiptSegue alloc] init] autorelease] forKey:@"CategoryToReceiptSegue"];
        [strategies setObject:[[[IGRCReceiptDetailsSeguePreparer alloc] init] autorelease] forKey:@"ReceiptDetailsSegue"];
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