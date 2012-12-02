//
//  PropertyBuilder.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-01-18.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import "PropertyBuilder.h"

@implementation PropertyBuilder
@synthesize property, revenue, expense, mortgage, report;
@synthesize revInc;
@synthesize mNr;
@synthesize structRes;
@synthesize admin;
@synthesize munTax;
@synthesize elecHeat;
@synthesize insurance;
@synthesize downPmt;
@synthesize purchPrice;
@synthesize mtgIntr;
@synthesize amortization;
@synthesize term;
@synthesize mtgAmt;

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



-(id)init{
    if(self = [super init])
    {
        
    }
    
    return self;
}

#pragma mark - AppDelegateProtocol
- (AppDataObjects *) dataObjects
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	AppDataObjects *dataObj;
    dataObj = (AppDataObjects *) theDelegate.dataObjects;
	return dataObj;
}

#pragma mark - Custom Mehods
-(void)createProperty:(NSMutableDictionary *)packages:(NSManagedObjectContext *)context{
    
    NSDictionary *propertyDict = [packages objectForKey:@"property"];
    NSDictionary *revenueDict = [packages objectForKey:@"revenue"];
    NSDictionary *expenseDict = [packages objectForKey:@"expense"];
    NSDictionary *mortgageDict = [packages objectForKey:@"mortgage"];
    
    Property *prop = (Property *)[NSEntityDescription insertNewObjectForEntityForName:@"Property" inManagedObjectContext:context];
    
    prop.timeStamp = [NSDate date];
    prop.purchasePrice = [propertyDict objectForKey:@"purchasePrice"];
    prop.downPaymentSize = [propertyDict objectForKey:@"downpayment"];
    prop.type = [propertyDict objectForKey:@"buildingType"];
    prop.address = [propertyDict objectForKey:@"address"];
    prop.postalzip = [propertyDict objectForKey:@"postalzip"];
    prop.country = [propertyDict objectForKey:@"country"];
    prop.unit = [propertyDict objectForKey:@"units"];
    prop.size = [propertyDict objectForKey:@"size"];
    
    Revenue *rev = (Revenue *)[NSEntityDescription insertNewObjectForEntityForName:@"Revenue" inManagedObjectContext:context];
    
    rev.rentAmount = [revenueDict objectForKey:@"rentAmount"];
    
    Expense *exp = (Expense *)[NSEntityDescription insertNewObjectForEntityForName:@"Expense" inManagedObjectContext:context];
    
    exp.administration = [expenseDict objectForKey:@"administration"];
    exp.electricityHeating = [expenseDict objectForKey:@"elecHeat"];
    exp.insurance = [expenseDict objectForKey:@"insurance"];
    exp.maintenanceRepairs = [expenseDict objectForKey:@"mNr"];
    exp.municipalTax = [expenseDict objectForKey:@"munTax"];    
    exp.structuralReserve = [expenseDict objectForKey:@"structRes"];
    
    Mortgage *mtg = (Mortgage *)[NSEntityDescription insertNewObjectForEntityForName:@"Mortgage" inManagedObjectContext:context];
    
    mtg.amt = [mortgageDict objectForKey:@"mtg"];
    mtg.interest = [mortgageDict objectForKey:@"rate"];
    mtg.amortization = [mortgageDict objectForKey:@"amort"];
    mtg.term = [mortgageDict objectForKey:@"term"];
    
    Report *rep = (Report *)[NSEntityDescription insertNewObjectForEntityForName:@"Report" inManagedObjectContext:context];
    
    
    AppDataObjects *sharedObj = [self dataObjects];
    
    if(sharedObj.repData)
    {
        rep.totalRev = sharedObj.repData.totalRev;
        rep.totalExp = sharedObj.repData.totalExp;
        rep.netRev = sharedObj.repData.netRev;
        rep.debtCoverRatio = sharedObj.repData.debtCoverRatio;
        rep.retCF = sharedObj.repData.retCF;
        rep.grossRevRatio = sharedObj.repData.grossRevRatio;
        rep.netRevRatio = sharedObj.repData.netRevRatio;
        rep.capRate = sharedObj.repData.capRate;
        rep.effectRate = sharedObj.repData.effectRate;
        rep.mthPmt = sharedObj.repData.mthPmt;
        rep.numPmt = sharedObj.repData.numPmt;
        rep.mthMtgConst = sharedObj.repData.mthMtgConst;
        rep.annMtgConst = sharedObj.repData.annMtgConst;
        rep.annDebtServ = sharedObj.repData.annDebtServ;
        
        sharedObj.repData = [[[ReportData alloc] init] autorelease];
        
    }
    
   rev.property = prop;
   exp.property = prop;
   mtg.property = prop;
   rep.property = prop;
    
   self.property = prop;
    
}

-(ReportData *)createReport:(NSMutableDictionary *)packages:(NSMutableDictionary *)rawPackage:(Property *)propertyIn
{
   
    
    AppDataObjects *sharedObj = [self dataObjects];
    
    self.property = propertyIn;
    
    if(self.property != nil & [packages count] == 0)
    {
        [self setCalcVarReport:self.property];
    }
    else if(self.property != nil & [packages count] > 0)
    {
        
        [self setCalcVarAllPckg:rawPackage];
        [self calculate];
    }
    else
    {
        //takes what's in package and sets it to local variables
        [self setCalcVarChgPckg:packages];
        //takes local variables and gets report variables
        [self calculate];
    }
    
    //save report variables to repdata object
    [self saveToRepDataObj];
    
    //reset local and shared variables so next property starts clean
    [self resetCalcVar];
    
    return sharedObj.repData;
}


-(ReportData *)createReportWithAllViews:(NSMutableDictionary *)package;
{
    AppDataObjects *sharedObj = [self dataObjects];  
    
    [self setCalcVarAllPckg:package];
    [self calculate];
    [self saveToRepDataObj];
    
    return sharedObj.repData;
}


-(void)setCalcVarChgPckg:(NSMutableDictionary *)packages{
        
    UITextField *txtField;
    
    if([packages count] > 0)
    {
        for(id key in packages)
        {
            if(key == @"property")
            {
                NSDictionary *propertyDict = [packages objectForKey:@"property"];
                
                for(id k in propertyDict)
                {
                    txtField = [propertyDict objectForKey:k];
                    
                    if(k == @"$1,000,000")
                    {
                        self.purchPrice = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                    }
                    else if(k == @"$150,000")
                    {
                        self.downPmt = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                    }
                }
            }
            
            if(key == @"revenue")
            {
                
                NSDictionary *revenueDict = [packages objectForKey:@"revenue"];
                
                for(id k in revenueDict)
                {
                    txtField = [revenueDict objectForKey:k];
                    
                    if(k == @"$2,000,000")
                    {
                        self.revInc = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                    }
                }
            }
            
            
            if(key == @"expense")
            {
                
                
                NSDictionary *expenseDict = [packages objectForKey:@"expense"];
                
                for(id k in expenseDict)
                {
                    txtField = [expenseDict objectForKey:k];
                    
                    if(k == @"$4,000")
                    {
                       self.admin = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                    }
                    else if(k == @"$2,000")
                    {
                        self.elecHeat = [NSDecimalNumber decimalNumberWithString:[txtField text]]; 
                    }
                    else if(k == @"$1,000")
                    {
                        self.insurance = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                    }
                    else if(k == @"$10,000")
                    {
                        self.mNr = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                    }
                    else if(k == @"$500")
                    {
                        self.munTax = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                    }
                    else if(k == @"$200")
                    {
                        self.structRes = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                    }
                    
                }
            }
            
            if(key == @"mortgage")
            {
                
                NSDictionary *mortgageDict = [packages objectForKey:@"mortgage"];
                
                for(id k in mortgageDict)
                {
                    txtField = [mortgageDict objectForKey:k];
                    
                    if(k == @"$850,000")
                    {
                        self.mtgAmt = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                    }
                    else if(k == @"1.50")
                    {
                        self.mtgIntr = [NSDecimalNumber decimalNumberWithString:[txtField text]]; 
                    }
                    else if(k == @"5")
                    {
                        self.term = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                    }
                    else if(k == @"24")
                    {
                        self.amortization = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                        self.amortization = [self.amortization decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];

                    }
                }
            }
        }
     }
}

-(void)setCalcVarAllPckg:(NSDictionary *)packages{
    
    NSDictionary *propertyDict = [packages objectForKey:@"property"];
    NSDictionary *revenueDict = [packages objectForKey:@"revenue"];
    NSDictionary *expenseDict = [packages objectForKey:@"expense"];
    NSDictionary *mortgageDict = [packages objectForKey:@"mortgage"];
    
    
    self.purchPrice = [propertyDict objectForKey:@"purchasePrice"];
    self.downPmt = [propertyDict objectForKey:@"downpayment"];
    self.revInc = [revenueDict objectForKey:@"rentAmount"];
    self.mNr = [expenseDict objectForKey:@"mNr"];
    self.structRes = [expenseDict objectForKey:@"structRes"];
    self.admin = [expenseDict objectForKey:@"administration"];
    self.munTax = [expenseDict objectForKey:@"munTax"];    
    self.elecHeat = [expenseDict objectForKey:@"elecHeat"];
    self.insurance = [expenseDict objectForKey:@"insurance"];
    self.mtgIntr = [mortgageDict objectForKey:@"rate"];
    
    self.amortization = [mortgageDict objectForKey:@"amort"];
    self.amortization = [self.amortization decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];
    
    self.term = [mortgageDict objectForKey:@"term"];
    self.mtgAmt = [mortgageDict objectForKey:@"mtg"];
}
    
-(void)saveToRepDataObj{
    
    AppDataObjects *sharedObj = [self dataObjects];
    
    sharedObj.repData.netRev = self.netRev;
    sharedObj.repData.totalRev = self.totalRev;
    sharedObj.repData.totalExp = self.totalExp;
    sharedObj.repData.grossRevRatio = self.grossRevRatio;
    sharedObj.repData.capRate = self.capRate;
    sharedObj.repData.netRevRatio = self.netRevRatio;
    sharedObj.repData.debtCoverRatio = self.debtCoverRatio;
    sharedObj.repData.retCF = self.retCF;
    sharedObj.repData.effectRate = self.effectRate;
    sharedObj.repData.mthPmt = self.mthPmt;
    sharedObj.repData.numPmt = self.numPmt;
    sharedObj.repData.mthMtgConst = self.mthMtgConst;
    sharedObj.repData.annMtgConst = self.annMtgConst;
    sharedObj.repData.annDebtServ = self.annDebtServ;
}

-(void)setCalcVarReport:(Property *)propertyIn{
    
    self.property = propertyIn;
    
    Report *rep = (Report *)[self.property.report anyObject];
    
    self.netRev = rep.netRev;
    self.totalRev= rep.totalRev;
    self.totalExp = rep.totalExp;
    self.grossRevRatio = rep.grossRevRatio;
    self.capRate = rep.capRate;
    self.netRevRatio = rep.netRevRatio;
    self.debtCoverRatio = rep.debtCoverRatio;
    self.retCF = rep.retCF;
    self.effectRate = rep.effectRate;
    self.mthPmt = rep.mthPmt;
    self.numPmt = rep.numPmt;
    self.mthMtgConst = rep.mthMtgConst;
    self.annMtgConst = rep.annMtgConst;
    self.annDebtServ = rep.annDebtServ;
}
    
-(void)calculate{
    
    //convert to proper percentage from input
    self.mtgIntr = [self convertInputToPercent:self.mtgIntr]; 
    
    self.totalRev = [self getTotalRev:self.revInc];
    
    self.totalExp = [self getTotalExp:munTax :self.elecHeat :self.insurance :self.mNr :self.structRes: self.admin];
    
    self.netRev = [self getNetRev:self.totalRev:self.totalExp];
    
    self.grossRevRatio = [self getGrossRevRatio:self.purchPrice :self.totalRev];
    
    self.capRate = [self getCapRate:self.netRev:self.purchPrice];
    
    self.netRevRatio = [self getNetRevRatio:self.purchPrice:self.netRev];
    
    self.effectRate = [self getEffectiveRate:self.mtgIntr];
    
    self.numPmt = [self getNumOfPmt:self.amortization];
    
    self.mthPmt = [self getMthlyPmt:self.effectRate:self.numPmt:self.mtgAmt];
    
    self.annDebtServ = [self getAnnDebtServ:self.mthPmt];
    
    self.mthMtgConst = [self getMthMtgConst:self.mthPmt : self.mtgAmt];
    
    self.annMtgConst = [self getAnnMtgConst:self.mthMtgConst];
    
    self.annDebtServ = [self getAnnDebtServ:self.mthPmt];
    
    self.debtCoverRatio = [self getDebtCovRatio:self.netRev:annDebtServ];
    
    self.retCF = [self getRetCFDoll:self.netRev:annDebtServ];
    
}

-(void)resetCalcVar{
    
    self.revInc = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.mNr = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.structRes = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.admin = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.munTax = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.elecHeat = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.insurance = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.downPmt = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.purchPrice = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.mtgIntr = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.amortization = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.term = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.mtgAmt = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    self.totalRev = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.totalExp = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.netRev = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.debtCoverRatio = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.retCF = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.grossRevRatio = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.netRevRatio = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.capRate = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.effectRate = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.mthPmt = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.numPmt = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.mthMtgConst = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.annMtgConst = [NSDecimalNumber decimalNumberWithString:@"0"];
    self.annDebtServ = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    AppDataObjects *sharedObj = [self dataObjects];
    
    PropertyData *propData = [[PropertyData alloc] init];
    RevenueData *revData = [[RevenueData alloc] init];
    ExpenseData *expData = [[ExpenseData alloc] init];
    MortgageData *mtgData = [[MortgageData alloc] init];
    
    sharedObj.propData = propData;
    sharedObj.revData  = revData;
    sharedObj.expData = expData;
    sharedObj.mtgData = mtgData;
    
}

-(void)updateProperty:(NSMutableDictionary *)packages:(Property *)propertyIn{
    
    self.property = propertyIn;
    
    UITextField *txtField;
    
    for (id key in packages) {
        
        if(key == @"property")
        {
            NSDictionary *propertyDict = [packages objectForKey:@"property"];
            
            for(id k in propertyDict)
            {
                txtField = [propertyDict objectForKey:k];
                
                if(k == @"$1,000,000")
                {
                    self.property.purchasePrice = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                }
                else if(k == @"$150,000")
                {
                    self.property.downPaymentSize = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                }
                else if(k == @"Commercial")
                {
                    self.property.type = [txtField text];
                }
                else if(k == @"123 Park Ave")
                {
                    self.property.address = [txtField text];
                }
                else if(k == @"A1B 2C3")
                {
                    self.property.postalzip = [txtField text];
                }
                else if(k == @"Canada")
                {
                    self.property.country = [txtField text];
                }
                else if(k == @"12000 sqft")
                {
                    self.property.size = [txtField text];
                }
                else if(k == @"15 units")
                {
                    self.property.unit = [txtField text];
                }
            }
        }
        
        if(key == @"revenue")
        {
            self.revenue = (Revenue *)[self.property.revenue anyObject];
            
            NSDictionary *revenueDict = [packages objectForKey:@"revenue"];
            
            for(id k in revenueDict)
            {
                txtField = [revenueDict objectForKey:k];
                
                if(k == @"$2,000,000")
                {
                    self.revenue.rentAmount = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                }
            }
        }
        
        
        if(key == @"expense")
        {
            self.expense = (Expense *)[self.property.expense anyObject];
            
            NSDictionary *expenseDict = [packages objectForKey:@"expense"];
            
            for(id k in expenseDict)
            {
                txtField = [expenseDict objectForKey:k];
                
                if(k == @"$4,000")
                {
                    self.expense.administration = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                }
                else if(k == @"$2,000")
                {
                    self.expense.electricityHeating = [NSDecimalNumber decimalNumberWithString:[txtField text]]; 
                }
                else if(k == @"$1,000")
                {
                    self.expense.insurance = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                }
                else if(k == @"$10,000")
                {
                    self.expense.maintenanceRepairs = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                }
                else if(k == @"$500")
                {
                    self.expense.municipalTax = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                }
                else if(k == @"$200")
                {
                    self.expense.structuralReserve = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                }

            }
        }
        
        if(key == @"mortgage")
        {
            self.mortgage = (Mortgage *)[self.property.mortgage anyObject];
            
            NSDictionary *mortgageDict = [packages objectForKey:@"mortgage"];
            
            for(id k in mortgageDict)
            {
                txtField = [mortgageDict objectForKey:k];
                
                if(k == @"$850,000")
                {
                    self.mortgage.amt = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                }
                else if(k == @"1.50")
                {
                    self.mortgage.interest = [NSDecimalNumber decimalNumberWithString:[txtField text]]; 
                }
                else if(k == @"5")
                {
                    self.mortgage.term = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                }
                else if(k == @"24")
                {
                    self.mortgage.amortization = [NSDecimalNumber decimalNumberWithString:[txtField text]];
                }
            }
        }
        
    }
}

-(void)updateReport:(NSDictionary *)packages :(Property *)propertyIn{
    
    self.report = (Report *)[self.property.report anyObject];
    
    [self setCalcVarAllPckg:packages];
    [self calculate];
    [self saveToRepDataObj];
    
    AppDataObjects *sharedObj = [self dataObjects];
    
    self.report.totalRev = sharedObj.repData.totalRev;
    self.report.totalExp = sharedObj.repData.totalExp;
    self.report.netRev = sharedObj.repData.netRev;
    self.report.debtCoverRatio = sharedObj.repData.debtCoverRatio;
    self.report.retCF = sharedObj.repData.retCF;
    self.report.grossRevRatio = sharedObj.repData.grossRevRatio;
    self.report.netRevRatio = sharedObj.repData.netRevRatio;
    self.report.capRate = sharedObj.repData.capRate; 
    self.report.effectRate = sharedObj.repData.effectRate;
    self.report.mthPmt = sharedObj.repData.mthPmt;
    self.report.numPmt = sharedObj.repData.numPmt;
    self.report.mthMtgConst = sharedObj.repData.mthMtgConst;
    self.report.annMtgConst = sharedObj.repData.annMtgConst;
    self.report.annDebtServ = sharedObj.repData.annDebtServ;
    
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


-(void)dealloc{
    
    [property release];
    [expense release];
    [revenue release];
    [report release];
    
    [revInc release];
    [mNr release];
    [structRes release];
    [admin release];
    [munTax release];
    [elecHeat release];
    [insurance release];
    [downPmt release];
    [purchPrice release];
    [mtgIntr release];
    [amortization release];
    [term release];
    [mtgAmt release];
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

#pragma mark - Calculation Methods

/* Gross Effective Revenue */
-(NSDecimalNumber *)getGrossEffecRev:(NSDecimalNumber *)grossPotRevM:(NSDecimalNumber *)vacancyM:(NSDecimalNumberHandler *)handler{
    
    //$vacancy = %vacancy * $grossPotRev    
    NSDecimalNumber *vacancyDecNum = [vacancyM decimalNumberByMultiplyingBy:grossPotRevM withBehavior:handler];
    
    //$GrossEffecRev = $GrossPotRev - $vacancy
    return [grossPotRevM decimalNumberBySubtracting:vacancyDecNum];
}


// Tally amounts in Revenue 
-(NSDecimalNumber *)getTotalRev:(NSDecimalNumber *)grossPotRevM{
    
    if(grossPotRevM == [NSDecimalNumber notANumber] || grossPotRevM == nil)
        grossPotRevM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    return grossPotRevM; 
}

// Tally amounts in Expenses
-(NSDecimalNumber *)getTotalExp:(NSDecimalNumber *)munTaxM:(NSDecimalNumber *)elecHeatM:(NSDecimalNumber *)insuranceM:(NSDecimalNumber *)mNrM:(NSDecimalNumber *)structResM:(NSDecimalNumber *)adminM{
    
    if(munTaxM == [NSDecimalNumber notANumber] || munTaxM == nil)
        munTaxM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if(elecHeatM == [NSDecimalNumber notANumber] || elecHeatM == nil)
        elecHeatM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if(insuranceM == [NSDecimalNumber notANumber] || insuranceM == nil)
        insuranceM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if(mNrM == [NSDecimalNumber notANumber] || mNrM == nil)
        mNrM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if(structResM == [NSDecimalNumber notANumber] || structResM == nil)
        structResM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if(adminM == [NSDecimalNumber notANumber] || adminM == nil)
        adminM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    
    NSDecimalNumber *totalExpM = [munTaxM decimalNumberByAdding:[elecHeatM decimalNumberByAdding:[insuranceM decimalNumberByAdding:[mNrM decimalNumberByAdding:[structResM decimalNumberByAdding:adminM]]]]];
    
    return totalExpM;
    
}

// Net Revenue
// $netRev = $totalRev - $totalExp
-(NSDecimalNumber *)getNetRev:(NSDecimalNumber *)totalRevM:(NSDecimalNumber *)totalExpM{
    
    if(totalRevM == [NSDecimalNumber notANumber] || totalRevM == nil)
        totalRevM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if(totalExpM == [NSDecimalNumber notANumber] || totalExpM == nil)
        totalExpM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    return [totalRevM decimalNumberBySubtracting:totalExpM];
}

// Converting downPmt to dollars 
// $downPmt = %downPmtPerc * $purchasePrice
-(NSDecimalNumber *)getDownPtmDollar:(NSDecimalNumber *)downPmtPercM:(NSDecimalNumber *)purchPriceM{
    
    
    return [downPmtPercM decimalNumberByMultiplyingBy:purchPriceM];
}

// Converting mortgage to dollars 
// $mtgDoll = $purchPrice - $downPmt
-(NSDecimalNumber *)getMtgDollar:(NSDecimalNumber *)purchPriceM:(NSDecimalNumber *)downPmtDollarM:(NSDecimalNumber *)mtgPercM{
    
    if(purchPriceM == [NSDecimalNumber notANumber] || purchPriceM == nil)
        purchPriceM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if(downPmtDollarM == [NSDecimalNumber notANumber] || downPmtDollarM == nil)
        downPmtDollarM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if(mtgPercM == [NSDecimalNumber notANumber] || mtgPercM == nil)
        return [purchPriceM decimalNumberBySubtracting:downPmtDollarM];
    else
        return [purchPriceM decimalNumberByMultiplyingBy:mtgPercM];
    
    return 0;
}

/* Effective Rate */
-(NSDecimalNumber *)getEffectiveRate:(NSDecimalNumber *)mtgIntrM{
    
    NSDecimalNumber *numberOne = [NSDecimalNumber decimalNumberWithString:@"1"];
    NSDecimalNumber *numberTwo = [NSDecimalNumber decimalNumberWithString:@"2"];
    
    // needed for effect formula
    double division = 1.00 / 6.00 ;
    
    if(mtgIntrM == [NSDecimalNumber notANumber] || mtgIntrM == nil)
        mtgIntrM = [NSDecimalNumber decimalNumberWithString:@"0"]; 
    
    // (%mtgIntr / 2 + 1)
    NSDecimalNumber *part1 =[[mtgIntrM decimalNumberByDividingBy:numberTwo] decimalNumberByAdding:numberOne] ; 
    // (%mtgIntr / 2 + 1) ^ (1/6) 
    double toPwrResultDbl = pow([part1 doubleValue], division);
    // (%mtgIntr / 2 + 1) ^ (1/6) ---> convert to NSNumberDecimal  
    
    NSDecimalNumber *toPwrResultDec = [NSDecimalNumber decimalNumberWithString:[[NSNumber numberWithDouble:toPwrResultDbl] stringValue]];
    
    // ((%mtgIntr / 2 + 1) ^ (1/6)) - 1) 
    return [toPwrResultDec decimalNumberBySubtracting:numberOne];
    
    
}

/* Number of Payments */
-(NSDecimalNumber *)getNumOfPmt:(NSDecimalNumber *)amortizationM{
    
    if (amortizationM == [NSDecimalNumber notANumber] || amortizationM == nil) 
        amortizationM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    return [amortizationM decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];
    
}

/* Monthly Payments */    
-(NSDecimalNumber *)getMthlyPmt:(NSDecimalNumber *)effectRateM:(NSDecimalNumber *)numOfPmtM:(NSDecimalNumber *)mtgDollM{
    
    NSDecimalNumber *pmtPart1;
    NSDecimalNumber *pmtPart2;
    
    NSDecimalNumber *numberOne = [NSDecimalNumber decimalNumberWithString:@"1"];
   
    
    //see if nsdecimalnumberoverflowexception is thrown!!
    @try {
        // (%effectRate*(1+%effectRate)^numOfPmt)
        pmtPart1= [effectRateM decimalNumberByMultiplyingBy:[[effectRateM decimalNumberByAdding:numberOne] decimalNumberByRaisingToPower:[numOfPmtM intValue]]];
        
    }
    @catch (NSException *e) {
        
        return [NSDecimalNumber decimalNumberWithString:@"0"];
    }
    
    
    @try {
        // ((1+%effectRate)^numOfPmt - 1)
        pmtPart2 = [[[effectRateM decimalNumberByAdding:numberOne] decimalNumberByRaisingToPower:[numOfPmtM intValue]] decimalNumberBySubtracting:numberOne];
    }
    @catch (NSException *exception) {
        
        return [NSDecimalNumber decimalNumberWithString:@"0"];
        
    }
    
    
    if(![[pmtPart2 stringValue] isEqualToString:@"0"] || pmtPart1 == nil || pmtPart2 == nil)
    {
        //  $mtgDoll * %pmtPart1/%pmtPart2
        return[[mtgDollM decimalNumberByMultiplyingBy:pmtPart1] decimalNumberByDividingBy:pmtPart2];
    }
    
    
    return [NSDecimalNumber decimalNumberWithString:@"0"];
}


/* Monthly Mortgage Constant */ 
-(NSDecimalNumber *)getMthMtgConst:(NSDecimalNumber *)mthPmtM:(NSDecimalNumber *)mtgDollM{
    
    
    if (mthPmtM == [NSDecimalNumber notANumber] || mthPmtM == nil) 
        mthPmtM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if (mtgDollM == [NSDecimalNumber notANumber] || mtgDollM == nil || [[mtgDollM stringValue] isEqualToString:@"0"]  ) 
        mtgDollM = [NSDecimalNumber decimalNumberWithString:@"1"];
    
    // mthPmt / $mtgDoll
    return [mthPmtM decimalNumberByDividingBy:mtgDollM];
    
}

/* Annual Mortgage Constant*/
-(NSDecimalNumber *)getAnnMtgConst:(NSDecimalNumber *)mthMtgConstM{
    
    if (mthMtgConstM == [NSDecimalNumber notANumber] || mthMtgConstM == nil) 
        mthMtgConstM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    // %mthMtgConst * 12
    return [mthMtgConstM decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];
}

/* Annual Debt Service */
-(NSDecimalNumber *)getAnnDebtServ:(NSDecimalNumber *)mthPmtM{
    
    if (mthPmtM == [NSDecimalNumber notANumber] || mthPmtM == nil) 
        mthPmtM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    // %mthPmt * 12
    return [mthPmtM decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"12"]];
}


/* Deb Cover Ratio */    
-(NSDecimalNumber *)getDebtCovRatio:(NSDecimalNumber *)netRevM:(NSDecimalNumber *)annDebtServM{
    
    if(annDebtServM != nil && ![[annDebtServM stringValue] isEqualToString:@"0"])
        // %debtCovRatio = $netRev / %annDebtServ
        return [netRevM decimalNumberByDividingBy:annDebtServM];
    
    return  0;
}

/* Return Cash Flow ($) */ 
-(NSDecimalNumber *)getRetCFDoll:(NSDecimalNumber *)netRevM:(NSDecimalNumber *)annDebtServM{
    
    if(annDebtServM != nil)
        // $retCFDoll = $netRev - %annDebtServ 
        return [netRevM decimalNumberBySubtracting:annDebtServM];
    
    return 0;
}

-(NSDecimalNumber *)getRetCFPerc:(NSDecimalNumber *)retCFDollM:(NSDecimalNumber *)downPmtM{
    
    if (retCFDollM == [NSDecimalNumber notANumber] || retCFDollM == nil) 
        retCFDollM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    // %retCFPerc = $retCFDoll / $downPmt
    return [retCFDollM decimalNumberByDividingBy:downPmtM];
}


/* Return On Investment */         
-(NSDecimalNumber *)getROI:(NSDecimalNumber *)capAndCashM:(NSDecimalNumber *)downPmtM{
    
    if(downPmtM == [NSDecimalNumber notANumber] || downPmtM == nil || [[downPmtM stringValue] isEqualToString:@"0"])
        return 0;
    if(capAndCashM == [NSDecimalNumber notANumber] || capAndCashM == nil)
        capAndCashM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    // $ROI = $capAndCash / $downPmt
    return [capAndCashM decimalNumberByDividingBy:downPmtM];
    
}

/* Gross Revenue Ratio */         
-(NSDecimalNumber *)getGrossRevRatio:(NSDecimalNumber *)purchPriceM:(NSDecimalNumber *)grossPotRevM{
    
    if(purchPriceM == [NSDecimalNumber notANumber] || purchPriceM == nil)
        purchPriceM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    if([[grossPotRevM stringValue] isEqualToString:@"0"] )
        return 0;
    
    // %grossRevRatio = $purchPrice / $grossPotRev
    return [purchPriceM decimalNumberByDividingBy:grossPotRevM];
}

/* Net Revenue Ratio */             
-(NSDecimalNumber *)getNetRevRatio:(NSDecimalNumber *)purchPriceM:(NSDecimalNumber *)netRevM{
    
    if(netRevM == [NSDecimalNumber notANumber] || netRevM == nil || [[netRevM stringValue] isEqualToString:@"0"]  )
        return 0;
    
    if(purchPriceM == [NSDecimalNumber notANumber] || purchPriceM == nil)
        purchPriceM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    
    
    // %netRevRatio = $purchPrice / netRev
    return [purchPriceM decimalNumberByDividingBy:netRevM];
}

/* Cap Rate */
-(NSDecimalNumber *)getCapRate:(NSDecimalNumber *)netRevM:(NSDecimalNumber *)purchPriceM{
    
    if(purchPriceM  == [NSDecimalNumber notANumber] || purchPriceM == nil || [[purchPriceM stringValue] isEqualToString:@"0"])
        purchPriceM = [NSDecimalNumber decimalNumberWithString:@"1"];
    
    if(netRevM == [NSDecimalNumber notANumber] || netRevM == nil)
        netRevM = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    
    return [[netRevM decimalNumberByDividingBy:purchPriceM] decimalNumberByMultiplyingBy:[NSDecimalNumber decimalNumberWithString:@"100"]];
    
}


@end
