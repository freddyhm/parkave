//
//  RepData.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-10-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ReportData.h"


@implementation ReportData

@synthesize totalRev;
@synthesize totalExp;
@synthesize netRev;
@synthesize debtCoverRatio;
@synthesize retCF;
@synthesize grossRevRatio;
@synthesize netRevRatio;
@synthesize capRate;
@synthesize effectRate;
@synthesize mthPmt;
@synthesize numPmt;
@synthesize mthMtgConst;
@synthesize annMtgConst;
@synthesize annDebtServ;


-(void)dealloc{
    
    [totalRev release];
    [totalExp release];
    [netRev release];
    [debtCoverRatio release];
    [retCF release];
    [grossRevRatio release];
    [netRevRatio release];
    [capRate release];
    [effectRate release];
    [mthPmt release];
    [numPmt release];
    [mthMtgConst release];
    [annMtgConst release];
    [annDebtServ release];
    [super dealloc];
}
@end
