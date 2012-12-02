//
//  MtgCalcController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MtgCalcController.h"


@implementation MtgCalcController
@synthesize txtIntrst, txtMtgAmort, txtMtgAmt;
@synthesize btnCalculate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Mortgage";
    }
    return self;
}

#pragma mark - AppDelegateProtocol

- (void)dealloc
{
    [btnCalculate release];
    [txtIntrst release];
    [txtMtgAmort release];
    [txtMtgAmt release];
    [super dealloc];
}


- (void)viewDidUnload
{
    self.btnCalculate = nil;
    self.txtIntrst = nil;
    self.txtMtgAmort = nil;
    self.txtMtgAmt = nil;
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



#pragma mark - Custom Methods

//Show labels and textfields
-(void)showFieldsLabels{
    
    self.txtMtgAmt = [self txtFieldMaker:165:56:UIKeyboardTypeNumberPad:@"$850,000"];
    
    if ((UIKeyboardTypeDecimalPad) && ([[[UIDevice currentDevice] systemVersion] doubleValue] >= 4.1)) 
    {
        //Create txtFields
        self.txtIntrst = [self txtFieldMaker:165:96:UIKeyboardTypeDecimalPad:@"1.50"];
        self.txtMtgAmort = [self txtFieldMaker:165:136:UIKeyboardTypeDecimalPad:@"24"];
    }
    else
    {
        self.txtIntrst = [self txtFieldMaker:165:96:UIKeyboardTypeNumbersAndPunctuation:@"1.50"];
        self.txtMtgAmort = [self txtFieldMaker:165:136:UIKeyboardTypeNumbersAndPunctuation:@"24"];
    }
    
    
    //Create button    
    UIImage *btnImg = [UIImage imageNamed:@"calculate button.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:self action:@selector(calculateMtgPmt) forControlEvents:UIControlEventTouchDown];
    
    [button setImage:btnImg forState:UIControlStateNormal];
    button.frame = CGRectMake(102, 193, 117, 64);
    self.btnCalculate = button;
    [button release];
    
    //Add txtFields to screen
    [self.view addSubview:self.txtMtgAmt];
    [self.view addSubview:self.txtIntrst];
    [self.view addSubview:self.txtMtgAmort];
    
    //Add default labels to screen
    [self.view addSubview:[self lblMaker:@"Mortgage":11:56]];
    [self.view addSubview:[self lblMaker:@"Interest Rate (%)":11:96]];
    
    UILabel *lblAmort = [self lblMaker:@"Amortization in years":11:136];
    [lblAmort setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    
    [self.view addSubview:lblAmort];
    
    //Add button to screen
    [self.view addSubview:self.btnCalculate];
}


- (void)calculateMtgPmt{
    
    AppDataObjects *sharedObjs = [self dataObjects];

    sharedObjs.mtgData.amt = [self currencyStrToDecimalNum:self.txtMtgAmt.text];
    sharedObjs.mtgData.interest = [self currencyStrToDecimalNum:self.txtIntrst.text];
    sharedObjs.mtgData.amortization = [self currencyStrToDecimalNum:self.txtMtgAmort.text];
    
    MtgCalcOutputController *mtgCal = [[MtgCalcOutputController alloc] init];
    
    mtgCal.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:mtgCal animated:YES];
    
    [mtgCal release];
}


// Hide keyboard when tapping background while editing
- (IBAction)backgroundTap:(id)sender{
    
    [txtIntrst resignFirstResponder];
    [txtMtgAmort resignFirstResponder];
    [txtMtgAmt resignFirstResponder];
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    UIControl *mtgCalcControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    UIImage *bckgdimg = [UIImage imageNamed:@"PLAINBG.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:bckgdimg];
    [mtgCalcControl addSubview:imgView];    
    [mtgCalcControl addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    
    self.view = mtgCalcControl;
    
    [self showFieldsLabels];

    [mtgCalcControl release];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
