//
//  MtgCalcController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//


#import "MtgCalcOutputController.h"



@interface MtgCalcController : CalcViewController{
    
    UITextField *txtMtgAmt;
    UITextField *txtIntrst;
    UITextField *txtMtgAmort;
    
    UIButton *btnCalculate;
    
}

@property (nonatomic, retain) UITextField *txtMtgAmt;
@property (nonatomic, retain) UITextField *txtIntrst;
@property (nonatomic, retain) UITextField *txtMtgAmort;
@property (nonatomic, retain) UIButton *btnCalculate;

//calculates and displays mtg info
-(void) calculateMtgPmt;

@end
