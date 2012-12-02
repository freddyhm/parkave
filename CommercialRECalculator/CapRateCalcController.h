//
//  CapRateCalcController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalcViewController.h"
#import "CapRateCalcOutputController.h"

@interface CapRateCalcController : CalcViewController {
    
    UITextField *txtTotalInc;
    UITextField *txtTotalExp;
    UITextField *txtPurchPrice;
    
    UIButton *btnCalculate;
}

@property (nonatomic, retain) UITextField *txtTotalInc;
@property (nonatomic, retain) UITextField *txtTotalExp;
@property (nonatomic, retain) UITextField *txtPurchPrice;
@property (nonatomic, retain) UIButton *btnCalculate;;

-(void)getCapRate;
-(void)showFieldsLabels;


@end
