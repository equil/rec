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

@synthesize nameField, weightField, unitSegmentedControl, unitLabel, addButton, cancelButton, infoLabel, selectUnitLabel;

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

    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(textDidChange) name:UITextFieldTextDidChangeNotification object:nil];
    
    unit = @"гр";
    selectedInSegmentedControl = 0;
}

- (void)viewDidUnload
{
    self.nameField = nil;
    self.weightField = nil;
    self.unitSegmentedControl = nil;
    self.unitLabel = nil;
    self.addButton = nil;
    self.cancelButton = nil;
    self.infoLabel = nil;
    self.selectUnitLabel = nil;
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

- (void)dealloc
{
    [nameField release];
    [weightField release];
    [unitSegmentedControl release];
    [unitLabel release];
    [addButton release];
    [cancelButton release];
    [infoLabel release];
    [selectUnitLabel release];
    [super dealloc];
}

- (NSArray *)entityExistAmongGoods
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

- (NSArray *)entityExistAmongProducts
{
    IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
    NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
    
    NSFetchRequest *request = [[NSFetchRequest alloc] init];
    [request setEntity:[NSEntityDescription entityForName:@"Product" inManagedObjectContext:context]];
    
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"title ==[c] %@", nameField.text];
    
    [request setPredicate:predicate];
    [request setIncludesSubentities:NO];
    
    NSError *err;
    NSArray *product = [context executeFetchRequest:request error:&err];
    
    [request release];
    
    if ([product count] < 1 || product == nil)
        return nil;
    
    return product;
}

- (IBAction)addButtonClick
{
    if ([nameField.text isEqualToString:@""] || [weightField.text isEqualToString:@""])
    {
        [infoLabel setAlpha:1.0];
        [self performSelector:@selector(hideInfoLabel) withObject:nil afterDelay:2.0];
    }
    else
    {
        IGRCAppDelegate *delegate = (IGRCAppDelegate *) [[UIApplication sharedApplication] delegate];
        NSManagedObjectContext *context = delegate.dataAccessManager.managedObjectContext;
        
        NSArray *arrP = [self entityExistAmongProducts];
        if (arrP == nil)
        {
            Product *newProduct = [NSEntityDescription insertNewObjectForEntityForName:@"Product" inManagedObjectContext:context];
            newProduct.title = nameField.text;
            newProduct.unit = unit;
            
            Good *newGood = [NSEntityDescription insertNewObjectForEntityForName:@"Good" inManagedObjectContext:context];
            newGood.product = newProduct;
            newGood.weight = [NSDecimalNumber decimalNumberWithString:weightField.text];
        }
        else
        {
            NSArray *arrG = [self entityExistAmongGoods];
            if (arrG == nil)
            {
                Good *newGood = [NSEntityDescription insertNewObjectForEntityForName:@"Good" inManagedObjectContext:context];
                newGood.product = (Product *)[arrP objectAtIndex:0];
                newGood.weight = [NSDecimalNumber decimalNumberWithString:weightField.text];
            }
            else
            {
                Good *g = (Good *)[arrG objectAtIndex:0];
                g.weight = [NSDecimalNumber decimalNumberWithString:[NSString stringWithFormat:@"%i", [g.weight intValue] + [weightField.text intValue]]];
            }
        }
        
        [delegate.dataAccessManager saveState];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (IBAction)cancelButtonClick
{
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)hideInfoLabel
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    
    [infoLabel setAlpha:0.0];
    
    [UIView commitAnimations];
}
    
- (void)textDidChange
{
    NSArray *products = [self entityExistAmongProducts];
    if (products != nil)
    {
        Product *p = (Product *)[products objectAtIndex:0];
        unit = p.unit;
        [unitLabel setText:[NSString stringWithFormat:@"Единица: %@", p.unit]];
        [self unitLabelToTop];
    }
    else
    {
        [self processSegment];
        [unitLabel setText:@""];
        [self unitSegmentedControlToTop];
    }
}

- (IBAction)segmentSwitch:(id)sender {
    UISegmentedControl *segmentedControl = (UISegmentedControl *) sender;
    selectedInSegmentedControl = segmentedControl.selectedSegmentIndex;
    [self processSegment];
}

- (void)processSegment
{
    switch (selectedInSegmentedControl) {
        case 0:
        {
            unit = @"гр";
        }
            break;
            
        case 1:
        {
            unit = @"мл";
        }
            break;
            
        case 2:
        {
            unit = @"уп";
        }
            break;
            
        default:
            break;
    }
}

- (void)unitSegmentedControlToTop
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    
    unitLabel.alpha = 0.0;
    selectUnitLabel.alpha = 1.0;
    unitSegmentedControl.alpha = 1.0;
    
    [UIView commitAnimations];
}

- (void)unitLabelToTop
{
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.5f];
    
    selectUnitLabel.alpha = 0.0;
    unitSegmentedControl.alpha = 0.0;
    unitLabel.alpha = 1.0;
    
    [UIView commitAnimations];
}

@end
