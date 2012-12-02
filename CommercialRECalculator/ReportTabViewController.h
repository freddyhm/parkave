//
//  ReportTabViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabBarViewController.h"
#import "Report.h"
#import "Revenue.h"
#import "Expense.h"
#import "Mortgage.h"

@interface ReportTabViewController : TabBarViewController{

    NSDecimalNumber * totalRev;
    NSDecimalNumber * totalExp;
    NSDecimalNumber * netRev; 
    NSDecimalNumber * debtCovRatio;
    NSDecimalNumber * retCFDoll; 
    NSDecimalNumber * netRevRatio;
    NSDecimalNumber * capRate;
    NSDecimalNumber * effectRate;
    NSDecimalNumber * numOfPmt; 
    NSDecimalNumber * mthPmt;
    NSDecimalNumber * mthMtgConst;
    NSDecimalNumber * annMtgConst;
    NSDecimalNumber * annDebtServ;
    
    NSDecimalNumber * numberOne; 
    NSDecimalNumber * numberTwo;
    
    UILabel *lblTotalRev;
    UILabel *lblTotalExp;
    UILabel *lblNetRev;
    UILabel *lblDebtCovRatio;
    UILabel *lblRetCFDoll;
    UILabel *lblNetRevRatio;
    UILabel *lblCapRate;
    UILabel *lblGrossRevRatio;
    UILabel *lblEffectRate;
    UILabel *lblNumOfPmt; 
    UILabel *lblMthPmt;
    UILabel *lblMthMtgConst;
    UILabel *lblAnnMtgConst;
    UILabel *lblAnnDebtServ;
    
    NSArray *settingsList;
    NSArray *settingsData;
    
    NSArray *retCFIndic;
    NSArray *netRevIndic;
    NSArray *grossRevRatioIndic;
    NSArray *netRevRatioIndic;
    NSArray *effectRateIndic;
    NSArray *mthPmtIndic;
    NSArray *numPmtIndic;
    NSArray *mthMtgConstIndic;
    NSArray *annMtgConstIndic;
    NSArray *annDebtServIndic;
    NSArray *debtCovRatioIndic;
    NSArray *capRateIndic;
    
    Report *report;
}

@property (nonatomic, retain) NSDecimalNumber * totalRev;
@property (nonatomic, retain) NSDecimalNumber * totalExp;
@property (nonatomic, retain) NSDecimalNumber * netRev; 
@property (nonatomic, retain) NSDecimalNumber * debtCovRatio;
@property (nonatomic, retain) NSDecimalNumber * retCFDoll; 
@property (nonatomic, retain) NSDecimalNumber * grossRevRatio;
@property (nonatomic, retain) NSDecimalNumber * netRevRatio;
@property (nonatomic, retain) NSDecimalNumber * capRate;
@property (nonatomic, retain) NSDecimalNumber * effectRate;
@property (nonatomic, retain) NSDecimalNumber * numOfPmt; 
@property (nonatomic, retain) NSDecimalNumber * mthPmt;
//@property (nonatomic, retain) NSDecimalNumber * mthMtgConst;
//@property (nonatomic, retain) NSDecimalNumber * annMtgConst;
@property (nonatomic, retain) NSDecimalNumber * annDebtServ;

@property (nonatomic, retain) UILabel *lblTotalRev;
@property (nonatomic, retain) UILabel *lblTotalExp;
@property (nonatomic, retain) UILabel *lblNetRev;
@property (nonatomic, retain) UILabel *lblDebtCovRatio;
@property (nonatomic, retain) UILabel *lblRetCFDoll;
@property (nonatomic, retain) UILabel *lblNetRevRatio;
@property (nonatomic, retain) UILabel *lblCapRate;
@property (nonatomic, retain) UILabel *lblGrossRevRatio;
@property (nonatomic, retain) UILabel *lblEffectRate;
@property (nonatomic, retain) UILabel *lblMthPmt;
@property (nonatomic, retain) UILabel *lblNumOfPmt; 
//@property (nonatomic, retain) UILabel *lblMthMtgConst;
//@property (nonatomic, retain) UILabel *lblAnnMtgConst;
@property (nonatomic, retain) UILabel *lblAnnDebtServ;

@property (nonatomic, retain) NSDecimalNumber * numberOne; 
@property (nonatomic, retain) NSDecimalNumber * numberTwo;

@property (nonatomic, retain) NSArray *settingsList;
@property (nonatomic, retain) NSArray *settingsData; 

@property (nonatomic, retain) NSArray *retCFIndic;
@property (nonatomic, retain) NSArray *netRevIndic;
@property (nonatomic, retain) NSArray *grossRevRatioIndic;
@property (nonatomic, retain) NSArray *netRevRatioIndic;
@property (nonatomic, retain) NSArray *debtCovRatioIndic;
@property (nonatomic, retain) NSArray *capRateIndic;
@property (nonatomic, retain) NSArray *effectRateIndic;
@property (nonatomic, retain) NSArray *mthPmtIndic;
@property (nonatomic, retain) NSArray *numPmtIndic;
//@property (nonatomic, retain) NSArray *mthMtgConstIndic;
//@property (nonatomic, retain) NSArray *annMtgConstIndic;
@property (nonatomic, retain) NSArray *annDebtServIndic;
@property (nonatomic, retain) Report *report;

-(NSString *)dataFilePath:(NSString *)filename;
-(UIImage *)imageWithImage:(UIImage *)image CovertToSize:(CGSize)size;
-(UIImageView *)getImgView:(NSString *)imageName:(int)posx:(int)posy;
-(NSInteger)getIndicatorLevel:(NSArray *)settings:(float)value;
- (NSArray *)loadIndicators:(NSString *)filename:(float)value:(int)posy;
-(void)loadValues:(ReportData *)reportIn;
-(void)showFieldsLabels;



@end
