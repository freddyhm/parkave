//
//  ExpenseTabViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExpenseTabViewController.h"


@implementation ExpenseTabViewController
@synthesize expense;
@synthesize txtAdmin, txtElecHeat, txtExpIncr, txtVacBad;
@synthesize txtInsurance, txtMnR, txtMunTax, txtStructRes;

#pragma mark - Custom Methods

-(void)showFieldsLabels{
    
    [self.view addSubview:[self lblMaker:@"Administration":10:10]];
    [self.view addSubview:[self lblMaker:@"Electricity/Heating":10:60]];
    [self.view addSubview:[self lblMaker:@"Insurance":10:110]];
    [self.view addSubview:[self lblMaker:@"Municipal Tax":10:160]];
    [self.view addSubview:[self lblMaker:@"Structural Reserve":10:210]];
    [self.view addSubview:[self lblMaker:@"Maintenance":10:260]];
    
    self.txtAdmin = [self txtFieldMaker:170 :10:UIKeyboardTypeNumberPad:@"$4,000"];    
    self.txtElecHeat = [self txtFieldMaker:170 :60:UIKeyboardTypeNumberPad:@"$2,000"];
    self.txtInsurance = [self txtFieldMaker:170 :110:UIKeyboardTypeNumberPad:@"$1,000"];
    self.txtMunTax = [self txtFieldMaker:170:160:UIKeyboardTypeNumberPad:@"$500"];
    self.txtStructRes = [self txtFieldMaker:170 :210:UIKeyboardTypeNumberPad:@"$200"];
    self.txtMnR = [self txtFieldMaker:170 :260:UIKeyboardTypeNumberPad:@"$10,000"];
    
    [self.view addSubview:self.txtAdmin];
    [self.view addSubview:self.txtElecHeat];
    [self.view addSubview:self.txtInsurance];
    [self.view addSubview:self.txtMunTax];
    [self.view addSubview:self.txtStructRes];
    [self.view addSubview:self.txtMnR];

}

-(void)loadValues:(Property *)propertyIn{
    
    self.property = propertyIn;
    
    self.expense = (Expense *)[self.property.expense anyObject];
    
    self.txtAdmin.text = [self nAnToZero:self.expense.administration ];
    self.txtElecHeat.text = [self nAnToZero:self.expense.electricityHeating];
    self.txtInsurance.text = [self nAnToZero:self.expense.insurance];
    self.txtMunTax.text = [self nAnToZero:self.expense.municipalTax ];
    self.txtStructRes.text = [self nAnToZero:self.expense.structuralReserve ];
    self.txtMnR.text = [self nAnToZero:self.expense.maintenanceRepairs];    
}

-(IBAction)backgroundTap:(id)sender{
    
    [txtAdmin resignFirstResponder];
    [txtElecHeat resignFirstResponder];
    [txtExpIncr resignFirstResponder];
    [txtInsurance resignFirstResponder];
    [txtMnR resignFirstResponder];
    [txtMunTax resignFirstResponder];
    [txtStructRes resignFirstResponder];
    [txtVacBad resignFirstResponder];
    
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)dealloc
{
    [txtMunTax release];
    [txtElecHeat release];
    [txtInsurance release];
    [txtMnR release];
    [txtStructRes release];
    [txtAdmin release];
    [txtExpIncr release];
    [txtVacBad release];
    [expense release];
    [super dealloc];
}

- (void)viewDidUnload
{
    self.numberFormatter = nil;
    self.source = nil;
    self.settings = nil;
    self.property = nil;
    
    self.txtMunTax = nil;
    self.txtElecHeat = nil;
    self.txtInsurance = nil;
    self.txtMnR = nil;
    self.txtStructRes = nil;
    self.txtAdmin = nil;
    self.txtExpIncr = nil;
    self.txtVacBad = nil;
    self.expense = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    UIControl *expControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    UIImage *bckgdimg = [UIImage imageNamed:@"PLAINBG.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:bckgdimg];
    [expControl addSubview:imgView];    
    [expControl addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    
    self.view = expControl;
    

    [expControl release];
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
