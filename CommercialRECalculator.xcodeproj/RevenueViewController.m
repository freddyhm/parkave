//
//  RevenueViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RevenueViewController.h"

@implementation RevenueViewController
@synthesize managedObjectContext;
@synthesize revenue, property;
@synthesize txtRent, txtExpRec, txtIncreases;


#pragma mark - Custom Methods

// Hide keyboard when tapping background while editing
- (IBAction)backgroundTap:(id)sender{
    [txtRent resignFirstResponder];
    [txtExpRec resignFirstResponder];
    [txtIncreases resignFirstResponder];
}

#pragma mark - Memory Management
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidUnload
{
    
    [super viewDidUnload];
}

- (void)dealloc
{

    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewWillDisappear:(BOOL)animated{

    [revenue setValue:[self property] forKey:@"property"];
    [revenue setValue:[NSDecimalNumber decimalNumberWithString:txtRent.text] forKey:@"rentAmount"];
    [revenue setValue:[NSDecimalNumber decimalNumberWithString:txtExpRec.text] forKey:@"expensesRecoveries"];
    [revenue setValue:[NSNumber numberWithDouble:[txtIncreases.text doubleValue]] forKey:@"increase"];
}



- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}





@end
