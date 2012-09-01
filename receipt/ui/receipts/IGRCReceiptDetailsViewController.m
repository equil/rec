//
//  IGRCReceiptDetailsViewController.m
//  receipt
//
//  Created by Alexey Rogatkin on 08/19/12.
//___COPYRIGHT___
//

#import "IGRCReceiptDetailsViewController.h"
#import "Receipt.h"
#import "IGRCAppDelegate.h"

@interface IGRCReceiptDetailsViewController ()

@end

@implementation IGRCReceiptDetailsViewController

@synthesize receiptImage = _receiptImage;
@synthesize descriptionLabel = _descriptionLabel;
@synthesize howToPrepareLabel = _howToPrepareLabel;
@synthesize receipt = _receipt;
@synthesize favoriteImageView = _favoriteImageView;


- (void)reconfigureControllerView {
    self.receiptImage.image = _receipt.image;
    self.descriptionLabel.text = _receipt.descript;
    self.howToPrepareLabel.text = _receipt.howToPrepare;
    self.navigationItem.title = _receipt.title;
    self.favoriteImageView.highlighted = [_receipt.favorite boolValue];
}

- (void)setReceipt:(Receipt *)aReceipt {
    [_receipt release];
    _receipt = [aReceipt retain];

    [self reconfigureControllerView];
}

- (IBAction)switchFavoriteState {
    _receipt.favorite = [NSNumber numberWithBool:![_receipt.favorite boolValue]];
    IGRCAppDelegate *delegate = (IGRCAppDelegate *)[[UIApplication sharedApplication] delegate];
    [delegate.dataAccessManager saveState];
    
    if (![delegate.dataAccessManager.favoriteBadgeObserver.arrayOfFavoritesDone containsObject:_receipt.title])
    {
        if (![delegate.dataAccessManager.favoriteBadgeObserver.arrayOfFavoritesTemp containsObject:_receipt.title])
        {
            [delegate.dataAccessManager.favoriteBadgeObserver.arrayOfFavoritesTemp addObject:_receipt.title];
            //+ badge
            [self incFavoriteTabBarItemBadge];            
        }
        else
        {
            [delegate.dataAccessManager.favoriteBadgeObserver.arrayOfFavoritesTemp removeObject:_receipt.title];
            //- badge
            [self decFavoriteTabBarItemBadge];
        }
    }
    else
    {
        [delegate.dataAccessManager.favoriteBadgeObserver.arrayOfFavoritesDone removeObject:_receipt.title];
    }
    
    [self reconfigureControllerView];
}

- (void)incFavoriteTabBarItemBadge
{
    if (((UITabBarItem *)[self.tabBarController.tabBar.items objectAtIndex:1]).badgeValue == nil)
    {
        ((UITabBarItem *)[self.tabBarController.tabBar.items objectAtIndex:1]).badgeValue = @"1";
    }
    else
    {
        ((UITabBarItem *)[self.tabBarController.tabBar.items objectAtIndex:1]).badgeValue = [NSString stringWithFormat:@"%d", [((UITabBarItem *)[self.tabBarController.tabBar.items objectAtIndex:1]).badgeValue intValue] + 1];
    }
}

- (void)decFavoriteTabBarItemBadge
{
    int value = [((UITabBarItem *)[self.tabBarController.tabBar.items objectAtIndex:1]).badgeValue intValue] - 1;
    if (value == 0)
    {
        ((UITabBarItem *)[self.tabBarController.tabBar.items objectAtIndex:1]).badgeValue = nil;
    }
    else
    {
        ((UITabBarItem *)[self.tabBarController.tabBar.items objectAtIndex:1]).badgeValue = [NSString stringWithFormat:@"%d", value];
    }
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self reconfigureControllerView];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc {
    [_receiptImage release];
    [_descriptionLabel release];
    [_howToPrepareLabel release];
    [_receipt release];
    [_favoriteImageView release];
    [super dealloc];
}

@end
