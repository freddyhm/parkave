//
//  MtgCalcOutputController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MtgCalcOutputController.h"

@implementation MtgCalcOutputController
@synthesize lblAmort, lblEffect, lblIntrst;
@synthesize lblMtgAmt, lblNumPmt, lblMthPmts;
@synthesize lblAnnDebtServ, lblAnnMtgConst, lblMonthMtgConst;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
         self.title = @"Result";
    }
    return self;
}


#pragma mark - Custom Methods

-(void)packageProperty:(NSDecimalNumber *)mtgAmt:(NSDecimalNumber *)intrstRate:(NSDecimalNumber *)amort{
    
    NSMutableDictionary *packages = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *propPackage = [[NSMutableDictionary alloc] init];
    
    [propPackage setValue:@"New Property" forKey:@"address"];
    [propPackage setValue:@"" forKey:@"buildingType"];
    [propPackage setValue:@"" forKey:@"postalzip"];
    [propPackage setValue:@"" forKey:@"country"];
    [propPackage setValue:@"" forKey:@"units"];
    [propPackage setValue:@"" forKey:@"size"];
    [propPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"purchasePrice"];
    [propPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"downpayment"];
    
    [packages setValue:propPackage forKey:@"property"];
    [propPackage release];
    
    
    NSMutableDictionary *revPackage = [[NSMutableDictionary alloc] init];
    
    [revPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"rentAmount"];
    
    [packages setValue:revPackage forKey:@"revenue"];
    [revPackage release];
    
    
    NSMutableDictionary *expPackage = [[NSMutableDictionary alloc] init];
    
    [expPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"administration"];
    [expPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"elecHeat"];
    [expPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"insurance"];
    [expPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"mNr"];
    [expPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"munTax"];
    [expPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"structRes"];
    
    [packages setValue:expPackage forKey:@"expense"];
    [expPackage release];
    
    
    NSMutableDictionary *mtgPackage = [[NSMutableDictionary alloc] init];
    
    [mtgPackage setValue:amort forKey:@"amort"];
    [mtgPackage setValue:[NSDecimalNumber decimalNumberWithString:@"0"] forKey:@"term"];
    [mtgPackage setValue:mtgAmt forKey:@"mtg"];
    [mtgPackage setValue:intrstRate forKey:@"rate"];
    
    [packages setValue:mtgPackage forKey:@"mortgage"];
    [mtgPackage release];
    
    self.package = packages;
    [packages release];
}



-(void)showFieldsLabels{
    
    [self.view addSubview:[self lblMaker:@"Mortgage Amt":31:61]];
    [self.view addSubview:[self lblMaker:@"Interest Rate":31:91]];
    [self.view addSubview:[self lblMaker:@"Amortization Period":31:121]];
    
    [self.view addSubview:[self lblMaker:@"Effective Rate":31:181]];
    [self.view addSubview:[self lblMaker:@"Number of Payments":31:211]];
    [self.view addSubview:[self lblMaker:@"Monthly Payments":31:241]];
    [self.view addSubview:[self lblMaker:@"Montly Mtg Constant":31:271]];
    [self.view addSubview:[self lblMaker:@"Annual Mtg Constant":31:301]];
    [self.view addSubview:[self lblMaker:@"Annual Debt Service":31:331]];
}

-(void)displayResults{
    
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumberHandler *handler2 = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:4 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    AppDataObjects *sharedObjs = [self dataObjects];

    NSDecimalNumber *mtgAmt = sharedObjs.mtgData.amt;
    NSString *fmtMtgAmt = [self decimalNumToCurrency:[self nAnToZero:mtgAmt]];
    self.lblMtgAmt = [self lblMaker:fmtMtgAmt :200 :61];
    
    NSDecimalNumber *intrstRate = [self.builder convertInputToPercent:sharedObjs.mtgData.interest];
    NSString *fmtIntrstRate = [[self nAnToZero:intrstRate] stringValue];
    self.lblIntrst = [self lblMaker:fmtIntrstRate : 200 :91];
    
    NSDecimalNumber *amort = sharedObjs.mtgData.amortization;
    NSString *fmtAmort = [[self nAnToZero:amort] stringValue];
    self.lblAmort = [self lblMaker:fmtAmort :200 :121];
    
    
  
    NSDecimalNumber *effectIntrst = [self.builder getEffectiveRate:intrstRate];
    NSString *fmtEffectIntrst = [[self nAnToZero:[effectIntrst decimalNumberByRoundingAccordingToBehavior:handler2]] stringValue];
    self.lblEffect = [self lblMaker:fmtEffectIntrst:200:181];
    
    
    NSDecimalNumber *numOfPmt = [self.builder getNumOfPmt:amort];
    NSString *fmtNumOfpmt = [numOfPmt stringValue];  
    self.lblNumPmt = [self lblMaker:fmtNumOfpmt :200 :211];
    
    NSDecimalNumber *mthPmt = [self.builder getMthlyPmt:effectIntrst :numOfPmt :mtgAmt];
    NSString *fmtMthPmt = [self decimalNumToCurrency:[self nAnToZero:[mthPmt decimalNumberByRoundingAccordingToBehavior:handler]]]; 
    self.lblMthPmts = [self lblMaker:fmtMthPmt :200 :241];     
    
    
    // mthPmt \ $mtgDoll
    NSDecimalNumber *mthMtgConst = [self.builder getMthMtgConst:mthPmt :mtgAmt];
    NSString *fmtMthMtgConst = [[self nAnToZero:[mthMtgConst decimalNumberByRoundingAccordingToBehavior:handler2]] stringValue]; 
    self.lblMonthMtgConst = [self lblMaker:fmtMthMtgConst :200 :271]; 
    
    
    // %mthMtgConst * 12
    NSDecimalNumber *annMtgConst = [self.builder getAnnMtgConst:mthMtgConst];
    NSString *fmtAnnMtgConst = [[self nAnToZero:[annMtgConst decimalNumberByRoundingAccordingToBehavior:handler2]] stringValue]; 
    self.lblAnnMtgConst = [self lblMaker:fmtAnnMtgConst :200 :301]; 

    
    // %mthPmt * 12
    NSDecimalNumber *annDebtServ = [self.builder getAnnDebtServ:mthPmt];
    NSString *fmtAnnDebtServ = [self decimalNumToCurrency:[self nAnToZero:[annDebtServ decimalNumberByRoundingAccordingToBehavior:handler]]]; 
    self.lblAnnDebtServ = [self lblMaker:fmtAnnDebtServ :200 :331]; 
    
    
    sharedObjs.repData.effectRate = [NSDecimalNumber decimalNumberWithString:@"0"];
    sharedObjs.repData.numPmt = [self nAnToZero:[NSDecimalNumber decimalNumberWithString:fmtNumOfpmt]];
    sharedObjs.repData.mthPmt = [self nAnToZero:[NSDecimalNumber decimalNumberWithString:fmtMthPmt]];
    sharedObjs.repData.mthMtgConst = [self nAnToZero:[NSDecimalNumber decimalNumberWithString:fmtMthMtgConst]];
    sharedObjs.repData.annMtgConst = [self nAnToZero:[NSDecimalNumber decimalNumberWithString:fmtAnnMtgConst]];
    sharedObjs.repData.annDebtServ = [self nAnToZero:[NSDecimalNumber decimalNumberWithString:fmtAnnDebtServ]];
    sharedObjs.repData.netRev = [NSDecimalNumber decimalNumberWithString:@"0"];
    sharedObjs.repData.totalRev = [NSDecimalNumber decimalNumberWithString:@"0"];
    sharedObjs.repData.totalExp = [NSDecimalNumber decimalNumberWithString:@"0"];
    
                                 
    
    [self.view addSubview:self.lblMtgAmt];
    [self.view addSubview:self.lblIntrst];
    [self.view addSubview:self.lblAmort];
    [self.view addSubview:self.lblEffect];
    [self.view addSubview:self.lblMthPmts];
    [self.view addSubview:self.lblNumPmt];
    [self.view addSubview:self.lblMonthMtgConst];
    [self.view addSubview:self.lblAnnMtgConst];
    [self.view addSubview:self.lblAnnDebtServ];
    
    [self packageProperty:mtgAmt :intrstRate :amort];
    
}


#pragma mark - View lifecycle

- (void)viewDidLoad
{
    UIView *capRateView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    UIImage *bckgdimg = [UIImage imageNamed:@"PLAINBG.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:bckgdimg];
    [capRateView addSubview:imgView];   

    UIBarButtonItem *btnSave = [[UIBarButtonItem alloc] 
                                initWithBarButtonSystemItem:UIBarButtonSystemItemSave
                                target:self 
                                action:@selector(sendPackageToBuilder)];
    
    self.navigationItem.rightBarButtonItem = btnSave;
    
    self.view = capRateView;
    
    [self showFieldsLabels];
    [self displayResults];
   
    [capRateView release];
    [btnSave release];
    [super viewDidLoad];

}

#pragma mark - Memory Management

- (void)dealloc
{
    [lblAmort release];
    [lblAnnDebtServ release];
    [lblAnnMtgConst release];
    [lblEffect release];
    [lblIntrst release];
    [lblMonthMtgConst release];
    [lblMtgAmt release];
    [lblMthPmts release];
    [lblNumPmt release];
    [super dealloc];
}

- (void)viewDidUnload
{
    self.builder = nil;
    self.lblAmort = nil;
    self.lblAnnDebtServ = nil;
    self.lblAnnMtgConst = nil;
    self.lblEffect = nil;
    self.lblIntrst = nil;
    self.lblMonthMtgConst = nil;
    self.lblMtgAmt = nil;
    self.lblMthPmts = nil;
    self.lblNumPmt = nil;
    [super viewDidUnload];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
