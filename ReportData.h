//
//  RepData.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-10-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ReportData : NSObject {
    
    NSDecimalNumber *totalRev;
    NSDecimalNumber *totalExp;
    NSDecimalNumber *netRev;
    NSDecimalNumber *debtCoverRatio;
    NSDecimalNumber *retCF;
    NSDecimalNumber *grossRevRatio;
    NSDecimalNumber *netRevRatio;
    NSDecimalNumber *capRate;
    NSDecimalNumber *effectRate;
    NSDecimalNumber *mthPmt;
    NSDecimalNumber *numPmt;
    NSDecimalNumber *mthMtgConst;
    NSDecimalNumber *annMtgConst;
    NSDecimalNumber *annDebtServ;

}

@property (nonatomic, retain) NSDecimalNumber *totalRev;
@property (nonatomic, retain) NSDecimalNumber *totalExp;
@property (nonatomic, retain) NSDecimalNumber *netRev;
@property (nonatomic, retain) NSDecimalNumber *debtCoverRatio;
@property (nonatomic, retain) NSDecimalNumber *retCF;
@property (nonatomic, retain) NSDecimalNumber *grossRevRatio;
@property (nonatomic, retain) NSDecimalNumber *netRevRatio;
@property (nonatomic, retain) NSDecimalNumber *capRate;
@property (nonatomic, retain) NSDecimalNumber *effectRate;
@property (nonatomic, retain) NSDecimalNumber *mthPmt;
@property (nonatomic, retain) NSDecimalNumber *numPmt;
@property (nonatomic, retain) NSDecimalNumber *mthMtgConst;
@property (nonatomic, retain) NSDecimalNumber *annMtgConst;
@property (nonatomic, retain) NSDecimalNumber *annDebtServ;


@end
