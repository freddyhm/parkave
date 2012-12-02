//
//  CapRateCalcOutputController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-19.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalcViewController.h"


@interface CapRateCalcOutputController : CalcViewController {
        
    UILabel *lblIncome;
    UILabel *lblExp;
    UILabel *lblNetRev;
    UILabel *lblPurPrice;
    UILabel *lblCapRate;   
}

@property (nonatomic, retain) UILabel *lblIncome;
@property (nonatomic, retain) UILabel *lblExp;
@property (nonatomic, retain) UILabel *lblPurPrice;
@property (nonatomic, retain) UILabel *lblCapRate;
@property (nonatomic, retain) UILabel *lblNetRev;

-(void)showFieldsLabels;
-(void)packageProperty:(NSDecimalNumber *)totalInc:(NSDecimalNumber *)totalExp:(NSDecimalNumber *)purchPrice;

@end

