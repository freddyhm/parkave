///
//  ReportTabViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "ReportTabViewController.h"


@implementation ReportTabViewController

@synthesize report;
@synthesize totalRev;
@synthesize totalExp;
@synthesize netRev; 
@synthesize debtCovRatio;
@synthesize retCFDoll; 
@synthesize grossRevRatio;
@synthesize netRevRatio;
@synthesize capRate;
@synthesize effectRate;
@synthesize numOfPmt; 
@synthesize mthPmt;
//@synthesize mthMtgConst;
//@synthesize annMtgConst;
@synthesize annDebtServ;

@synthesize lblDebtCovRatio, lblTotalExp, lblTotalRev, lblNetRev, lblCapRate, lblRetCFDoll, lblNetRevRatio,lblGrossRevRatio;
@synthesize lblEffectRate;
@synthesize lblNumOfPmt;    
@synthesize lblMthPmt;     
//@synthesize lblMthMtgConst;
//@synthesize lblAnnMtgConst;
@synthesize lblAnnDebtServ;

@synthesize settingsData;
@synthesize settingsList;

@synthesize numberOne; 
@synthesize numberTwo; 

@synthesize retCFIndic;
@synthesize netRevIndic;
@synthesize grossRevRatioIndic;
@synthesize netRevRatioIndic;
@synthesize debtCovRatioIndic;
@synthesize capRateIndic;
@synthesize effectRateIndic;
@synthesize mthPmtIndic;
@synthesize numPmtIndic;
//@synthesize mthMtgConstIndic;
//@synthesize annMtgConstIndic;
@synthesize annDebtServIndic;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
   }
          
    return self;
}


#pragma mark - Custom Methods

-(void)loadValues:(ReportData *)reportIn{
    
    NSDecimalNumberHandler *handler = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:2 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    NSDecimalNumberHandler *handler2 = [NSDecimalNumberHandler decimalNumberHandlerWithRoundingMode:NSRoundPlain scale:4 raiseOnExactness:NO raiseOnOverflow:NO raiseOnUnderflow:NO raiseOnDivideByZero:NO];
    
    self.totalRev = reportIn.totalRev;
    self.totalExp = reportIn.totalExp;
    self.netRev = [[reportIn netRev] decimalNumberByRoundingAccordingToBehavior:handler];
    self.grossRevRatio = [[reportIn grossRevRatio] decimalNumberByRoundingAccordingToBehavior:handler];
    self.capRate = [[reportIn capRate] decimalNumberByRoundingAccordingToBehavior:handler];
    self.netRevRatio = [[reportIn netRevRatio] decimalNumberByRoundingAccordingToBehavior:handler];
    self.debtCovRatio = [[reportIn debtCoverRatio] decimalNumberByRoundingAccordingToBehavior:handler];
    self.retCFDoll = [[reportIn retCF] decimalNumberByRoundingAccordingToBehavior:handler];
    self.effectRate = [[reportIn effectRate] decimalNumberByRoundingAccordingToBehavior:handler2];
    self.mthPmt = [[reportIn mthPmt] decimalNumberByRoundingAccordingToBehavior:handler];
    self.numOfPmt = reportIn.numPmt;
    //self.mthMtgConst = [[reportIn mthMtgConst] decimalNumberByRoundingAccordingToBehavior:handler2];
   //self.annMtgConst = [[reportIn annMtgConst] decimalNumberByRoundingAccordingToBehavior:handler2];
    self.annDebtServ = [[reportIn annDebtServ] decimalNumberByRoundingAccordingToBehavior:handler];
    
    self.lblTotalRev = [self lblMaker:[self nAnToZero:self.totalRev]:180 :10];
    self.lblTotalExp = [self lblMaker:[self nAnToZero:self.totalExp]:180 :35];
    self.lblNetRev = [self lblMaker:[self nAnToZero:self.netRev] :180 :60];
    self.lblRetCFDoll = [self lblMaker:[self nAnToZero:self.retCFDoll] :180 :85];
    self.lblAnnDebtServ = [self lblMaker:[self nAnToZero:self.annDebtServ] :180 :110];
    self.lblMthPmt = [self lblMaker:[self nAnToZero:self.mthPmt] :180 :135];
    self.lblNumOfPmt = [self lblMaker:[self nilToStr:[self.numOfPmt stringValue]] :180 :160];
    self.lblCapRate = [self lblMaker:[self nilToStr:[self.capRate stringValue]]:215:185];
    self.lblNetRevRatio = [self lblMaker:[self nilToStr:[self.netRevRatio stringValue]]:215:210];
    self.lblDebtCovRatio = [self lblMaker:[self nilToStr:[self.debtCovRatio stringValue]] :215 :235];
    self.lblEffectRate = [self lblMaker:[self nilToStr:[self.effectRate stringValue]] :215 :260];
    //self.lblMthMtgConst = [self lblMaker:[self nilToStr:[self.mthMtgConst stringValue]] :215 :285];
    //self.lblAnnMtgConst = [self lblMaker:[self nilToStr:[self.annMtgConst stringValue]] :215 :310];
    self.lblGrossRevRatio = [self lblMaker:[self nilToStr:[self.grossRevRatio stringValue]] :215 :285];
    
    //self.netRevIndic = [NSArray arrayWithArray:[self loadIndicators:@"netRevData.plist":[self.netRev floatValue]:60]];
    
    //self.retCFIndic = [NSArray arrayWithArray:[self loadIndicators:@"retCashFlowData.plist":[self.retCFDoll floatValue]:85]];
    
    //self.annDebtServIndic = [NSArray arrayWithArray:[self loadIndicators:@"annDebtServData.plist":[self.annDebtServ floatValue]:110]];
    
    self.capRateIndic = [NSArray arrayWithArray:[self loadIndicators:@"capRateData.plist":[self.capRate floatValue]:185]];
    
     self.netRevRatioIndic = [NSArray arrayWithArray:[self loadIndicators:@"netRevRatioData.plist":[self.netRevRatio floatValue]:210]];
    
    self.debtCovRatioIndic = [NSArray arrayWithArray:[self loadIndicators:@"debtCovRatioData.plist":[self.debtCovRatio floatValue]:235]];

    self.effectRateIndic = [NSArray arrayWithArray:[self loadIndicators:@"effectRateData.plist":[self.effectRate floatValue]:260]];
    
     //self.mthPmtIndic = [NSArray arrayWithArray:[self loadIndicators:@"mthPmtData.plist":[self.mthPmt floatValue]:235]];
    
     //self.numPmtIndic = [NSArray arrayWithArray:[self loadIndicators:@"numPmtData.plist":[self.numOfPmt floatValue]:260]];
    
     //self.mthMtgConstIndic = [NSArray arrayWithArray:[self loadIndicators:@"mthMtgConstData.plist":[self.mthMtgConst floatValue]:285]];
    
     //self.annMtgConstIndic = [NSArray arrayWithArray:[self loadIndicators:@"annMtgConstData.plist":[self.annMtgConst floatValue]:310]];    
    
     self.grossRevRatioIndic = [NSArray arrayWithArray:[self loadIndicators:@"grossRevRatioData.plist":[self.grossRevRatio floatValue]:285]];
    
    
    [self.view addSubview:self.lblTotalRev];
    [self.view addSubview:self.lblTotalExp];
    [self.view addSubview:self.lblGrossRevRatio];
    [self.view addSubview:self.lblNetRev];
    [self.view addSubview:self.lblCapRate];
    [self.view addSubview:self.lblNetRevRatio];
    [self.view addSubview:self.lblRetCFDoll];
    [self.view addSubview:self.lblDebtCovRatio];
    [self.view addSubview:self.lblEffectRate];
    [self.view addSubview:self.lblMthPmt];
    [self.view addSubview:self.lblNumOfPmt ];
    //[self.view addSubview:self.lblMthMtgConst];
    //[self.view addSubview:self.lblAnnMtgConst];
    [self.view addSubview:self.lblAnnDebtServ];
    
    //[self.view addSubview:[self.netRevIndic objectAtIndex:0]];
    //[self.view addSubview:[self.retCFIndic objectAtIndex:0]];
    //[self.view addSubview:[self.annDebtServIndic objectAtIndex:0]];
    [self.view addSubview:[self.capRateIndic objectAtIndex:0]];
    [self.view addSubview:[self.netRevRatioIndic objectAtIndex:0]];
    [self.view addSubview:[self.debtCovRatioIndic objectAtIndex:0]];
    [self.view addSubview:[self.effectRateIndic objectAtIndex:0]];
    //[self.view addSubview:[self.mthPmtIndic objectAtIndex:0]];
    //[self.view addSubview:[self.numPmtIndic objectAtIndex:0]];
    [self.view addSubview:[self.grossRevRatioIndic objectAtIndex:0]];
}

-(void)showFieldsLabels{
    
    [self.view addSubview:[self lblMaker:@"Total Revenue":10:10]];
    [self.view addSubview:[self lblMaker:@"Total Expense":10:35]];
    [self.view addSubview:[self lblMaker:@"Net Revenue":10:60]];
    [self.view addSubview:[self lblMaker:@"Return Cash Flow":10:85]];
    [self.view addSubview:[self lblMaker:@"Annual Debt Service":10:110]];
    [self.view addSubview:[self lblMaker:@"Monthly Payment":10:135]];
    [self.view addSubview:[self lblMaker:@"Number of Payments":10:160]];
    [self.view addSubview:[self lblMaker:@"Cap Rate":10:185]];
    [self.view addSubview:[self lblMaker:@"Net Rev Ratio":10:210]];
    [self.view addSubview:[self lblMaker:@"Debt Cover Ratio":10:235]];
    [self.view addSubview:[self lblMaker:@"Effective Rate":10:260]];
    //[self.view addSubview:[self lblMaker:@"Monthly Mtg Const.":10:285]];
    //[self.view addSubview:[self lblMaker:@"Annual Mtg Const.":10:310]];
    [self.view addSubview:[self lblMaker:@"Gross Rev Ratio":10:285]];
    
    
}

-(void)viewWillDisappear:(BOOL)animated{
    
    [self.lblTotalRev removeFromSuperview];
    [self.lblTotalExp removeFromSuperview];
    [self.lblRetCFDoll removeFromSuperview];
    [self.lblNetRevRatio removeFromSuperview];
    [self.lblNetRev removeFromSuperview];
    [self.lblGrossRevRatio removeFromSuperview];
    [self.lblDebtCovRatio removeFromSuperview];
    [self.lblCapRate removeFromSuperview];
    [self.lblEffectRate removeFromSuperview];
    [self.lblNumOfPmt removeFromSuperview]; 
    [self.lblMthPmt removeFromSuperview];
    //[self.lblMthMtgConst removeFromSuperview];
    //[self.lblAnnMtgConst removeFromSuperview];
    [self.lblAnnDebtServ removeFromSuperview];
    
    [[self.netRevRatioIndic objectAtIndex:0] removeFromSuperview];
    [[self.grossRevRatioIndic objectAtIndex:0] removeFromSuperview];
    [[self.capRateIndic objectAtIndex:0] removeFromSuperview];
    [[self.debtCovRatioIndic objectAtIndex:0] removeFromSuperview];
}



//takes in a decimalnumber and transforms it into a percent if it's not one already
-(NSDecimalNumber *)convertInputToPercent:(NSDecimalNumber *)input{
    
    NSString *firstNum = [[input stringValue] substringWithRange:NSMakeRange(0, 1)];
    
    if(![firstNum isEqualToString:@"0"] && input != [NSDecimalNumber notANumber] && input != nil)
    {
        input = [input decimalNumberByDividingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    }
    
    return input;
}

-(NSInteger)getIndicatorLevel:(NSArray *)indicators:(float)value{
    
        
    NSNumber *numSl1Ban1 =  [indicators objectAtIndex:0];
    NSNumber *numSl2Ban1 =  [indicators objectAtIndex:1];
    
    NSNumber *numSl1Ban2 =  [indicators objectAtIndex:2];
    NSNumber *numSl2Ban2 =  [indicators objectAtIndex:3];
    
    NSNumber *numSl1Ban3 =  [indicators objectAtIndex:4];
    NSNumber *numSl2Ban3 =  [indicators objectAtIndex:5];
    
    
    float firstTypeOne;
    float secondTypeOne;
    
    float firstTypeTwo;
    float secondTypeTwo;
    
    float firstTypeThree;
    float secondTypeThree;
    
    if([numSl1Ban1 floatValue] < [numSl2Ban1 floatValue])
    {
        firstTypeOne = [numSl1Ban1 floatValue];
        secondTypeOne = [numSl2Ban1 floatValue];
    }
    else if([numSl1Ban1 floatValue] > [numSl2Ban1 floatValue])
    {
        firstTypeOne = [numSl2Ban1 floatValue];
        secondTypeOne = [numSl1Ban1 floatValue];
    }
    else
    {
        firstTypeOne = 0;
        secondTypeOne = [numSl2Ban1 floatValue];
    }
    
    
    
    if([numSl1Ban2 floatValue] < [numSl2Ban2 floatValue])
    {
        firstTypeTwo = [numSl1Ban2 floatValue];
       secondTypeTwo = [numSl2Ban2 floatValue];
    }
    else if([numSl2Ban2 floatValue] > [numSl1Ban2 floatValue])
    {
        firstTypeTwo = [numSl2Ban2 floatValue];
        secondTypeTwo = [numSl1Ban2 floatValue];
        
    }
    else
    {
        firstTypeTwo = 0;
        secondTypeTwo = [numSl2Ban2 floatValue];
    }
    
    
    if([numSl1Ban3 floatValue] < [numSl2Ban3 floatValue])
    {
        firstTypeThree = [numSl1Ban3 floatValue];
        secondTypeThree = [numSl2Ban3 floatValue];
    }
    else if([numSl2Ban3 floatValue] > [numSl1Ban3 floatValue])
    {
        firstTypeThree = [numSl2Ban3 floatValue];
        secondTypeThree = [numSl1Ban3 floatValue];
        
    }
    else
    {
        firstTypeThree = 0;
        secondTypeThree = [numSl2Ban3 floatValue];
    }
    
    NSInteger level = 3;
    
    if(value >= firstTypeOne && firstTypeOne != 0)
    {
        level = 1;
    }
    else if(value >= firstTypeTwo && value <= secondTypeTwo && firstTypeTwo != 0)
    {
        level = 2;
        
    }
    
    
    return level;

}

- (NSArray *)loadIndicators:(NSString *)filename:(float)value:(int)posy{
    
    NSString *filePath = [self dataFilePath:filename];
    NSArray *images = [NSArray arrayWithContentsOfFile:filePath];

    if(![[NSFileManager defaultManager] fileExistsAtPath:filePath])
    {
        NSNumber *numSl1Ban1 =  [NSNumber numberWithFloat:0];
        NSNumber *numSl2Ban1 =  [NSNumber numberWithFloat:20.99];
        NSNumber *numSl1Ban2 =  [NSNumber numberWithFloat:21];
        NSNumber *numSl2Ban2 =  [NSNumber numberWithFloat:40.99];
        NSNumber *numSl1Ban3 =  [NSNumber numberWithFloat:41];
        NSNumber *numSl2Ban3 =  [NSNumber numberWithFloat:100];    
        
        NSMutableArray *array = [[NSMutableArray alloc] initWithObjects:numSl1Ban1,numSl2Ban1, numSl1Ban2, numSl2Ban2, numSl1Ban3, numSl2Ban3, nil];
        
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                             NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        
        NSString *file = [documentsDirectory stringByAppendingPathComponent:filename];
        
        [array writeToFile:file atomically:YES];
        [array release];
        
    }
       
    if([self getIndicatorLevel:images :value] == 1) 
    {
        images = [NSArray arrayWithObject:[self getImgView:@"arrowdown.png":180:posy]];
    }
    else if([self getIndicatorLevel:images :value] == 2)
    {
        images = [NSArray arrayWithObject:[self getImgView:@"arrow.png":180:posy]];
    }
    else if([self getIndicatorLevel:images :value] == 3)
    {
        images = [NSArray arrayWithObject:[self getImgView:@"arrowup.png":180:posy]];
    }
    
    return images;  

}


-(UIImageView *)getImgView:(NSString *)imageName:(int)posx:(int)posy{
     
    UIImage *image = [UIImage imageNamed:imageName];
    [self imageWithImage:image CovertToSize:CGSizeMake(30, 20)];
    
    
    UIImageView *imageView = [[UIImageView alloc] init];
    imageView.image = image;
    imageView.frame = CGRectMake(posx, posy, 30, 20);
    
    return imageView;
}

-(UIImage *)imageWithImage:(UIImage *)image CovertToSize:(CGSize)size {
    
    UIGraphicsBeginImageContext(size);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *destImage = UIGraphicsGetImageFromCurrentImageContext();    
    UIGraphicsEndImageContext();
    return destImage;
}

-(UILabel *)lblMaker:(NSString *)labelText:(int)posX:(int)posY{
    
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(posX, posY, 200, 20)];
    label.text = labelText;
    label.backgroundColor = [UIColor clearColor];
    
    return label;
    
}


- (NSString *)dataFilePath:(NSString *)filename{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:filename];
}


#pragma mark - Memory Management


- (void)dealloc
{
    [totalRev release];
    [totalExp release];
    [netRev release]; 
    [debtCovRatio release];
    [retCFDoll release]; 
    [netRevRatio release];
    [capRate release];
    [numberOne release]; 
    [numberTwo release];
    [effectRate release];
    [numOfPmt release]; 
    [mthPmt release];
    [mthMtgConst release];
    [annMtgConst release];
    [annDebtServ release];
    
    [lblTotalRev  release];
    [lblTotalExp  release];
    [lblNetRev  release];
    [lblDebtCovRatio  release];
    [lblRetCFDoll  release];
    [lblNetRevRatio  release];
    [lblCapRate  release];
    [lblGrossRevRatio  release];
    [lblEffectRate  release];
    [lblNumOfPmt  release]; 
    [lblMthPmt  release];
    [lblMthMtgConst  release];
    [lblAnnMtgConst  release];
    [lblAnnDebtServ  release];
    
    [settingsList release];
    [settingsData release];
    [report release];
    
    [grossRevRatioIndic release];
    [netRevRatioIndic release];
    [debtCovRatioIndic release];
    [capRateIndic release];
    [effectRateIndic release];
    [mthPmtIndic release];
    [numPmtIndic release];
    //[mthMtgConstIndic release];
    //[annMtgConstIndic release];
    [annDebtServIndic release];
    
    [super dealloc];
}

- (void)viewDidUnload
{
    self.numberFormatter = nil;
    self.source = nil;
    self.settings = nil;
    self.property = nil;
    
    //Rep
    self.totalRev = nil;
    self.totalExp = nil;
    self.netRev = nil; 
    self.debtCovRatio = nil;
    self.retCFDoll = nil; 
    self.netRevRatio = nil;
    self.capRate = nil;
    self.numberOne = nil; 
    self.numberTwo = nil;
    
    self.effectRate = nil;
    self.numOfPmt = nil; 
    self.mthPmt = nil;
    //self.mthMtgConst = nil;
    //self.annMtgConst = nil;
    self.annDebtServ = nil;
    
    self.lblTotalRev = nil;
    self.lblTotalExp = nil;
    self.lblNetRev = nil;
    self.lblDebtCovRatio = nil;
    self.lblRetCFDoll = nil;
    self.lblNetRevRatio = nil;
    self.lblCapRate = nil;
    self.lblGrossRevRatio = nil;
    self.lblEffectRate = nil;
    self.lblNumOfPmt = nil; 
    self.lblMthPmt = nil;
    //self.lblMthMtgConst = nil;
    //self.lblAnnMtgConst = nil;
    self.lblAnnDebtServ = nil;

    self.settingsList = nil;
    self.settingsData = nil;
    self.report = nil;
    
    self.grossRevRatioIndic = nil;
    self.netRevRatioIndic = nil;
    self.debtCovRatioIndic = nil;
    self.capRateIndic = nil;
    self.effectRateIndic = nil;
    self.mthPmtIndic = nil;
    self.numPmtIndic = nil;
    //self.mthMtgConstIndic = nil;
    //self.annMtgConstIndic = nil;
    //self.annDebtServIndic = nil;
    
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


-(void)viewDidLoad{
    
    UIControl *repControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    UIImage *bckgdimg = [UIImage imageNamed:@"PLAINBG.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:bckgdimg];
    [repControl addSubview:imgView];    
    [repControl addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    
    self.view = repControl;
    [repControl release];

    [super viewDidLoad];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
