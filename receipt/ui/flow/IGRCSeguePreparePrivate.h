//
//  Created by Alexey Rogatkin on 15.08.12.
//  
//


@protocol IGRCSeguePreparePrivate <NSObject>

@required

-(void) prepareViewController: (id) destinationController
            forTransitionFrom: (id) sourceController
                    parameter: (id) initiator;

@end