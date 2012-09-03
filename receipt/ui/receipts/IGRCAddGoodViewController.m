//
//  IGRCAddGoodViewController.m
//  receipt
//
//  Created by fredformout on 03.09.12.
//  Copyright (c) 2012 Alexey Rogatkin. All rights reserved.
//

#import "IGRCAddGoodViewController.h"
#import "IGRCAppDelegate.h"
#import "Good.h"
#import "Product.h"

@interface IGRCAddGoodViewController ()

@end

@implementation IGRCAddGoodViewController

@synthesize nameField, weightField, addButton, cancelButton, infoView, infoLabel;

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
	// Do any additional setup after loading the view.
}

- (void)viewDidUnload
{
    self.nameField = nil;
    self.weightField = nil;
    self.addButton = nil;
    self.cancelButton = nil;
    self.infoView = nil;
    self.infoLabel = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [nameField release];
    [weightField release];
    [addButton release];
    [cancelButton release];
    [infoView release];
    [infoLabel release];
    [super dealloc];
}

- (IBAction)addButtonClick
{
    if ([nameField.text isEqualToString:@""] || [weightField.text isEqualToString:@""])
    {
        infoView.alpha = 1.0;
        [self performSelector:@selector(hideInfoView) withObject:nil afterDelay:2.0];
    }
    else
    {
        IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
        
        NSArray *arr = [self entityExist];
        if (arr == nil)
        {
            Product *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
            newProduct.title = nameField.text;
            
            Good *newGood = [NSEntityDescription insertNewObjectForEntityForName:@"Good" inManagedObjectContext:context];
            newGood.product = newProduct;
            newGood.weight = [NSDecimalNumber decimalNumberWithString:weightField.text];
        }
        else
        {
            Good *g = (Good *)[arr objectAtIndex:0];
            g.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%i", [g.weight intValue] + [weightField.text intValue]]];
        }
        
        [delegate.dataAccessManager saveState];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)cancelButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideInfoView
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    
    infoView.alpha = 0.0;
    
    [UIView commitAnimations];
}

- (NSArray *)entityExist
{
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Good" inManagedObjectContext:context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"product.title ==[c] %@", nameField.text];
    
    [request setPredicate:predicate];
    [request setIncludesSubentities:NO];
    
    NSError *err;
    NSArray *good = [context executeFetchRequest:request error:&err];
    
    [request release];
    
    if ([good count] < 1 || good == nil)
        return nil;
    
    return good;
}

@end
