//
//  Report.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-02-03.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Property;

@interface Report : NSManagedObject

@property (nonatomic, retain) NSDecimalNumber * totalExp;
@property (nonatomic, retain) NSDecimalNumber * netRev;
@property (nonatomic, retain) NSDecimalNumber * netRevRatio;
@property (nonatomic, retain) NSDecimalNumber * debtCoverRatio;
@property (nonatomic, retain) NSDecimalNumber * totalRev;
@property (nonatomic, retain) NSDecimalNumber * capRate;
@property (nonatomic, retain) NSDecimalNumber * grossRevRatio;
@property (nonatomic, retain) NSDecimalNumber * retCF;
@property (nonatomic, retain) NSDecimalNumber * effectRate;
@property (nonatomic, retain) NSDecimalNumber * mthPmt;
@property (nonatomic, retain) NSDecimalNumber * numPmt;
@property (nonatomic, retain) NSDecimalNumber * mthMtgConst;
@property (nonatomic, retain) NSDecimalNumber * annMtgConst;
@property (nonatomic, retain) NSDecimalNumber * annDebtServ;
@property (nonatomic, retain) Property *property;

@end
