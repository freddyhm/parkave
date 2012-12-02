//
//  CapRateCalcOutputController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CapRateCalcOutputController.h"



@implementation CapRateCalcOutputController
@synthesize lblExp, lblIncome, lblCapRate;
@synthesize lblPurPrice, lblNetRev;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Result";
    }
    return self;
}

#pragma mark - AppDelegateProtocol

//Package property and send to builder for creation
-(void)packageProperty:(NSDecimalNumber *)totalInc:(NSDecimalNumber *)totalExp:(NSDecimalNumber *)purchPrice{
    
    NSMutableDictionary *packages = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *propPackage = [[NSMutableDictionary alloc] init];
    
    [propPackage setValue:@"New Property" forKey:@"address"];
    [propPackage setValue:@"" forKey:@"buildingType"];
    [propPackage setValue:@"" forKey:@"postalzip"];
    [propPackage setValue:@"" forKey:@"country"];
    [propPackage setValue:@"" forKey:@"units"];
    [propPackage setValue:@"" forKey:@"size"];
    [propPackage setValue:purchPrice forKey:@"purchasePrice"];
    [propPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"downpayment"];
    
    [packages setValue:propPackage forKey:@"property"];
    [propPackage release];
    
    
    NSMutableDictionary *revPackage = [[NSMutableDictionary alloc] init];
    
    [revPackage setValue:totalInc forKey:@"rentAmount"];
    
    [packages setValue:revPackage forKey:@"revenue"];
    [revPackage release];
    
    
    NSMutableDictionary *expPackage = [[NSMutableDictionary alloc] init];
    
    [expPackage setValue:totalExp forKey:@"administration"];
    [expPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"elecHeat"];
    [expPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"insurance"];
    [expPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"mNr"];
    [expPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"munTax"];
    [expPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"structRes"];
    
    [packages setValue:expPackage forKey:@"expense"];
    [expPackage release];
    
    
    NSMutableDictionary *mtgPackage = [[NSMutableDictionary alloc] init];
    
    [mtgPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"amort"];
    [mtgPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"term"];
    [mtgPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"mtg"];
    [mtgPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"rate"];
    
    [packages setValue:mtgPackage forKey:@"mortgage"];
    [mtgPackage release];
    
    self.package = packages;
    [packages release];
}


#pragma mark - Custom Methods

//Show calculations
-(void)displayResults{
    
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    AppDataObjects *sharedObjs = [self dataObjects];
    
    NSDecimalNumber *totalInc = sharedObjs.propData.totalRevenue;
    NSString *fmtTotalInc = [self decimalNumToCurrency:totalInc];
    self.lblIncome = [self lblMaker:fmtTotalInc :200 :16];
    
    NSDecimalNumber *totalExp = sharedObjs.propData.totalExpense;
    NSString *fmtTotalExp = [self decimalNumToCurrency:totalExp];
    self.lblExp = [self lblMaker:fmtTotalExp :200 :56];
    
    
    //netrev = totalincome - totalexpenses
    NSDecimalNumber *netRev = [self.builder getNetRev:totalInc :totalExp];
    NSString *fmtNetRev = [self decimalNumToCurrency:netRev];
    self.lblNetRev = [self lblMaker:fmtNetRev :200 :96];
    
    NSDecimalNumber *purchPrice = sharedObjs.propData.purchasePrice;
    NSString *fmtPurchPrice = [self decimalNumToCurrency:purchPrice];
    self.lblPurPrice = [self lblMaker:fmtPurchPrice :200 :156];
    
    //cap rate = netrev / purchprice * 100
    NSDecimalNumber *capRate = [self.builder getCapRate:netRev :purchPrice]; 
    NSString *fmtCapRate = [[capRate decimalNumberByRoundingAccordingToBehavior:handler] stringValue];
    UILabel *lblCr = [[UILabel alloc]initWithFrame:CGRectMake(0, 256, 310, 50)];
    lblCr.text = fmtCapRate;
    lblCr.backgroundColor = [UIColor clearColor];
    lblCr.textAlignment = UITextAlignmentCenter; 
    self.lblCapRate = lblCr;
    [lblCr release];
    [self.lblCapRate setFont:[UIFont systemFontOfSize:50]];
    
    
    sharedObjs.repData.capRate = [NSDecimalNumber decimalNumberWithString:fmtCapRate];
    sharedObjs.repData.netRev = netRev;
    sharedObjs.repData.totalRev = totalInc;
    sharedObjs.repData.totalExp = totalExp;
    sharedObjs.repData.retCF = [NSDecimalNumber decimalNumberWithString:@"0"];
    sharedObjs.repData.annDebtServ = [NSDecimalNumber decimalNumberWithString:@"0"];
    sharedObjs.repData.mthPmt = [NSDecimalNumber decimalNumberWithString:@"0"];
    sharedObjs.repData.numPmt = [NSDecimalNumber decimalNumberWithString:@"0"];

    
    [self.view addSubview:self.lblIncome];
    [self.view addSubview:self.lblExp];
    [self.view addSubview:self.lblNetRev];
    [self.view addSubview:self.lblPurPrice];  
    [self.view addSubview:self.lblCapRate]; 
    
    [self packageProperty:totalInc : totalExp:purchPrice];
    
}

-(void)showFieldsLabels{
    
    //Add default labels to screen
    [self.view addSubview:[self lblMaker:@"Total Income":20:16]];
    [self.view addSubview:[self lblMaker:@"Total Expenses":20:56]];
    [self.view addSubview:[self lblMaker:@"Net Revenue":20:96]];
    [self.view addSubview:[self lblMaker:@"Purchase Price":20:156]];
    [self.view addSubview:[self lblMaker:@"Your Cap Rate Is":95:216]];
}

#pragma mark - Memory Management

- (void)dealloc
{
    [lblIncome release];
    [lblExp release];
    [lblNetRev release];
    [lblPurPrice release];
    [lblCapRate release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload
{
    self.builder = nil;
    self.lblExp = nil;
    self.lblCapRate = nil;
    self.lblIncome = nil;
    self.lblNetRev = nil;
    self.lblPurPrice = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    
    UIView *capRateControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    UIImage *bckgdimg = [UIImage imageNamed:@"PLAINBG.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:bckgdimg];
    [capRateControl addSubview:imgView];   
    

    
    UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                target:self 
                                action:@selector(sendPackageToBuilder)];
    
    self.navigationItem.rightBarButtonItem = btnSave;
    [btnSave release];

    self.view = capRateControl;
    
    [self showFieldsLabels];
    [self displayResults];
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
