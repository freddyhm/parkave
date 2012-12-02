//
//  PropertyBuilder.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-01-18.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDataObjects.h"
#import "AppDataContainer.h"
#import "AppDelegateProtocol.h"
#import "Property.h"
#import "Revenue.h"
#import "Expense.h"
#import "Mortgage.h"
#import "Report.h"

@interface PropertyBuilder : NSObject{
    
    Property *property;
    Revenue *revenue;
    Expense *expense;
    Mortgage *mortgage;
    Report *report;
    
    NSDecimalNumber *revInc;
    NSDecimalNumber *mNr;
    NSDecimalNumber *structRes;
    NSDecimalNumber *admin;
    NSDecimalNumber *munTax;
    NSDecimalNumber *elecHeat;
    NSDecimalNumber *insurance;
    NSDecimalNumber *downPmt;
    NSDecimalNumber *purchPrice;
    NSDecimalNumber *mtgIntr;
    NSDecimalNumber *amortization;
    NSDecimalNumber *term;
    NSDecimalNumber *mtgAmt;
    
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

@property (nonatomic, retain) Property *property;
@property (nonatomic, retain) Revenue *revenue;
@property (nonatomic, retain) Expense *expense;
@property (nonatomic, retain) Mortgage *mortgage;
@property (nonatomic, retain) Report *report;
@property (nonatomic, retain) NSDecimalNumber *revInc;
@property (nonatomic, retain) NSDecimalNumber *mNr;
@property (nonatomic, retain) NSDecimalNumber *structRes;
@property (nonatomic, retain) NSDecimalNumber *admin;
@property (nonatomic, retain) NSDecimalNumber *munTax;
@property (nonatomic, retain) NSDecimalNumber *elecHeat;
@property (nonatomic, retain) NSDecimalNumber *insurance;
@property (nonatomic, retain) NSDecimalNumber *downPmt;
@property (nonatomic, retain) NSDecimalNumber *purchPrice;
@property (nonatomic, retain) NSDecimalNumber *mtgIntr;
@property (nonatomic, retain) NSDecimalNumber *amortization;
@property (nonatomic, retain) NSDecimalNumber *term;
@property (nonatomic, retain) NSDecimalNumber *mtgAmt;

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

-(AppDataObjects *) dataObjects;
-(void)createProperty:(NSMutableDictionary *)packages:(NSManagedObjectContext *)context;
-(void)updateProperty:(NSMutableDictionary *)packages:(Property *)propertyIn;
-(ReportData *)createReport:(NSMutableDictionary *)packages:(NSMutableDictionary *)rawPackage:(Property *)propertyIn;
-(NSDecimalNumber *)convertInputToPercent:(NSDecimalNumber *)input;
-(NSDecimalNumber *)getTotalRev:(NSDecimalNumber *)grossPotRevM;
-(NSDecimalNumber *)getTotalExp:(NSDecimalNumber *)munTaxM:(NSDecimalNumber *)elecHeatM:(NSDecimalNumber *)insuranceM:(NSDecimalNumber *)mNrM:(NSDecimalNumber *)structResM:(NSDecimalNumber *)adminM;
-(NSDecimalNumber *)getNetRev:(NSDecimalNumber *)totalRevM:(NSDecimalNumber *)totalExpM;
-(NSDecimalNumber *)getGrossRevRatio:(NSDecimalNumber *)purchPriceM:(NSDecimalNumber *)grossPotRevM;
-(NSDecimalNumber *)getCapRate:(NSDecimalNumber *)netRevM:(NSDecimalNumber *)purchPriceM;
-(NSDecimalNumber *)getNetRevRatio:(NSDecimalNumber *)purchPriceM:(NSDecimalNumber *)netRevM;
-(NSDecimalNumber *)getDebtCovRatio:(NSDecimalNumber *)netRevM:(NSDecimalNumber *)annDebtServM;
-(NSDecimalNumber *)getRetCFDoll:(NSDecimalNumber *)netRevM:(NSDecimalNumber *)annDebtServM;
-(NSDecimalNumber *)getROI:(NSDecimalNumber *)capAndCashM:(NSDecimalNumber *)downPmtM;
-(NSDecimalNumber *)getAnnDebtServ:(NSDecimalNumber *)mthPmtM;
-(NSDecimalNumber *)getMthlyPmt:(NSDecimalNumber *)effectRateM:(NSDecimalNumber *)numOfPmtM:(NSDecimalNumber *)mtgDollM;
-(NSDecimalNumber *)getEffectiveRate:(NSDecimalNumber *)mtgIntrM;
-(NSDecimalNumber *)getNumOfPmt:(NSDecimalNumber *)amortizationM;
-(NSDecimalNumber *)getMtgDollar:(NSDecimalNumber *)purchPriceM:(NSDecimalNumber *)downPmtDollarM:(NSDecimalNumber *)mtgPercM;
-(NSDecimalNumber *)getMthMtgConst:(NSDecimalNumber *)mthPmtM:(NSDecimalNumber *)mtgDollM;
-(NSDecimalNumber *)getAnnMtgConst:(NSDecimalNumber *)mthMtgConstM;
-(void)setCalcVarChgPckg:(NSMutableDictionary *)packages;
-(void)saveToRepDataObj;
-(void)setCalcVarReport:(Property *)propertyIn;
-(void)setCalcVarAllPckg:(NSDictionary *)packages;
-(void)calculate;
-(void)resetCalcVar;
-(ReportData *)createReportWithAllViews:(NSMutableDictionary *)allPackages;
-(void)updateReport:(NSDictionary *)packages:(Property *)propertyIn;


@end
