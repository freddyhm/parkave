//
//  MortgageTabViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MortgageTabViewController.h"


@implementation MortgageTabViewController
@synthesize mortgage;
@synthesize txtAmort, txtMtgSize, txtRate, txtTerm;

#pragma mark - Custom Methods

-(void)showFieldsLabels{
    
    
    self.txtMtgSize = [self txtFieldMaker:170 :10:UIKeyboardTypeNumberPad:@"$850,000"];
    
    if ((UIKeyboardTypeDecimalPad) && ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 4.1)) 
    {
        self.txtRate = [self txtFieldMaker:170 :60:UIKeyboardTypeDecimalPad:@"1.50"];
        self.txtTerm = [self txtFieldMaker:170 :110:UIKeyboardTypeDecimalPad:@"5"];
        self.txtAmort = [self txtFieldMaker:170 :160:UIKeyboardTypeDecimalPad:@"24"];
    }
    else
    {
        self.txtRate = [self txtFieldMaker:170 :60:UIKeyboardTypeNumbersAndPunctuation:@"1.50"];
        self.txtTerm = [self txtFieldMaker:170 :110:UIKeyboardTypeNumbersAndPunctuation:@"5"];
        self.txtAmort = [self txtFieldMaker:170 :160:UIKeyboardTypeNumbersAndPunctuation:@"24"];
    }

    
    
    
    [self.view addSubview:[self lblMaker:@"Mortgage":10:10]];
    [self.view addSubview:[self lblMaker:@"Interest Rate (%)":10:60]];
    [self.view addSubview:[self lblMaker:@"Term in years":10:110]];
    
    
    UILabel *lblAmort = [self lblMaker:@"Amortization in years":10:160];
    [lblAmort setFont:[UIFont fontWithName:@"Helvetica" size:16]];
    
    [self.view addSubview:lblAmort];
    [self.view addSubview:self.txtMtgSize];
    [self.view addSubview:self.txtRate];
    [self.view addSubview:self.txtTerm];
    [self.view addSubview:self.txtAmort];
    
}

-(void)loadValues:(Property *)propertyIn{
    
    self.property = propertyIn;
    
    self.mortgage = (Mortgage *)[self.property.mortgage anyObject];
    
    self.txtMtgSize.text = [self nAnToZero:self.mortgage.amt];
    self.txtTerm.text = [self.mortgage.term stringValue];
    self.txtRate.text = [self.mortgage.interest stringValue];
    self.txtAmort.text = [self.mortgage.amortization stringValue];

}


// Hide keyboard when tapping background while editing
- (IBAction)backgroundTap:(id)sender{
    [txtAmort resignFirstResponder];
    [txtMtgSize resignFirstResponder];
    [txtRate resignFirstResponder];
    [txtTerm resignFirstResponder];
}



#pragma mark - Memory Management

- (void)viewDidUnload
{
    self.numberFormatter = nil;
    self.source = nil;
    self.settings = nil;
    self.property = nil;
    
    self.txtMtgSize = nil;
    self.txtRate = nil;
    self.txtAmort = nil;
    self.txtTerm = nil;
    self.mortgage = nil;

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)dealloc
{
    [txtMtgSize release];
    [txtRate release];
    [txtAmort release];
    [txtTerm release];
    [mortgage release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    UIControl *mtgControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    UIImage *bckgdimg = [UIImage imageNamed:@"PLAINBG.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:bckgdimg];
    [mtgControl addSubview:imgView];    
    [mtgControl addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    
    self.view = mtgControl;
    
    [mtgControl release];
    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end