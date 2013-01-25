//
//  IGRCAppDelegate.h
//  receipt
//
//  Created by Alexey Rogatkin on 13.08.12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "IGRCSeguePrepareStrategy.h"
#import "IGRCDataAccessManager.h"
#import "IGRCFavoritesBadgeObserver.h"

@interface IGRCAppDelegate : UIResponder <UIApplicationDelegate, UIAlertViewDelegate>

@property (retain, nonatomic) UIWindow *window;

@property (retain, nonatomic, readonly) IGRCSeguePrepareStrategy *segueStrategy;
@property (retain, nonatomic, readonly) IGRCDataAccessManager *dataAccessManager;
@property (retain, nonatomic) NSString *link;
@property (assign, nonatomic) BOOL fullVersion;

@end
