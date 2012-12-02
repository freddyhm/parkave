//
//  MtgCalcOutputController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalcViewController.h"


@interface MtgCalcOutputController : CalcViewController {
    
    UILabel *lblMtgAmt;
    UILabel *lblIntrst;
    UILabel *lblAmort;
    UILabel *lblEffect;
    UILabel *lblMthPmts;
    UILabel *lblNumPmt;
    UILabel *lblMonthMtgConst;
    UILabel *lblAnnMtgConst;
    UILabel *lblAnnDebtServ;

}

@property (nonatomic, retain) UILabel *lblMtgAmt;
@property (nonatomic, retain) UILabel *lblIntrst;
@property (nonatomic, retain) UILabel *lblAmort;
@property (nonatomic, retain) UILabel *lblEffect;
@property (nonatomic, retain) UILabel *lblMthPmts;
@property (nonatomic, retain) UILabel *lblNumPmt;
@property (nonatomic, retain) UILabel *lblMonthMtgConst;
@property (nonatomic, retain) UILabel *lblAnnMtgConst;
@property (nonatomic, retain) UILabel *lblAnnDebtServ;

-(void)packageProperty:(NSDecimalNumber *)mtgAmt:(NSDecimalNumber *)intrstRate:(NSDecimalNumber *)amort;


@end
