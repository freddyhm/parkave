//
//  CapRateCalcController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CapRateCalcController.h"


@implementation CapRateCalcController
@synthesize txtTotalExp, txtTotalInc, txtPurchPrice;
@synthesize btnCalculate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}



#pragma mark - Custom Methods

//Sets the views data into shared objs and pushes the next controller
- (void)getCapRate{
    
    AppDataObjects *sharedObjs = [self dataObjects];
    
    sharedObjs.propData.totalRevenue = [self currencyStrToDecimalNum:self.txtTotalInc.text];
    sharedObjs.propData.totalExpense = [self currencyStrToDecimalNum:self.txtTotalExp.text];
    sharedObjs.propData.purchasePrice = [self currencyStrToDecimalNum:self.txtPurchPrice.text];

    CapRateCalcOutputController *capRateCalcOutputController = [[CapRateCalcOutputController alloc] init];
    
    capRateCalcOutputController.managedObjectContext = self.managedObjectContext;
    
    [self.navigationController pushViewController:capRateCalcOutputController animated:YES];
    
    [CapRateCalcOutputController release];     
}

//Display labels and textfields
-(void)showFieldsLabels{
    
    //Create txtFields
    self.txtTotalInc= [self txtFieldMaker:155:56:UIKeyboardTypeNumberPad:@"$1,000,000"];
    self.txtTotalExp = [self txtFieldMaker:155:96:UIKeyboardTypeNumberPad:@"$500,000"];
    self.txtPurchPrice = [self txtFieldMaker:155:136:UIKeyboardTypeNumberPad:@"$2,000,000"];

    //Create button    
    UIImage *btnImg = [UIImage imageNamed:@"calculate button.png"];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button addTarget:self action:@selector(getCapRate) forControlEvents:UIControlEventTouchDown];
    
    [button setImage:btnImg forState:UIControlStateNormal];
    button.frame = CGRectMake(102, 193, 117, 64);
    self.btnCalculate = button;
    [button release];
    
    //Add txtFields to screen
    [self.view addSubview:self.txtPurchPrice];
    [self.view addSubview:self.txtTotalExp];
    [self.view addSubview:self.txtTotalInc];
       
    //Add default labels to screen
    [self.view addSubview:[self lblMaker:@"Total Income":21:56]];
    [self.view addSubview:[self lblMaker:@"Total Expenses":21:96]];
    [self.view addSubview:[self lblMaker:@"Purchase Price":21:136]];
    
    //Add button to screen
    [self.view addSubview:self.btnCalculate];
}

// Hide keyboard when tapping background while editing
- (IBAction)backgroundTap:(id)sender{
    
    [txtPurchPrice resignFirstResponder];
    [txtTotalExp resignFirstResponder];
    [txtTotalInc resignFirstResponder];
}


#pragma mark - Memory Management

- (void)dealloc
{
    [btnCalculate release];
    [txtTotalInc release];
    [txtTotalExp release];
    [txtPurchPrice release];
    [super dealloc];
}

- (void)viewDidUnload
{
    self.builder = nil;
    self.btnCalculate = nil;
    self.txtPurchPrice = nil;
    self.txtTotalExp = nil;
    self.txtTotalInc = nil;
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
    UIControl *capRateControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    UIImage *bckgdimg = [UIImage imageNamed:@"PLAINBG.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:bckgdimg];
    [capRateControl addSubview:imgView];    
    [capRateControl addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    
    self.view = capRateControl;
    
    [self showFieldsLabels];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
