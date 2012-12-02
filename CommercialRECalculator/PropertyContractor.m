//
//  PropertyContractor.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-01-18.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import "PropertyContractor.h"

@implementation PropertyContractor
@synthesize builder;
@synthesize unit, postalzip, buildingType, downPaymentSize, address, type, size, country, purchasePrice;
@synthesize rentAmount;
@synthesize structuralReserve, administration, insurance, electricityHeating, municipalTax, maintenanceRepairs;
@synthesize amortization, interest, amt, term;
@synthesize totalRev, totalExp, netRev, debtCovRatio, retCF, grossRevRatio, netRevRatio, capRate;


-(id)initWithBuilder:(PropertyBuilder *)builderIn{
    if(self = [super init])
    {
        self.builder = builderIn;
    }
    
    return self;
}


#pragma mark - Delegated Actions - Custom Methods

-(void)setBuildPackage:(NSDictionary *)packagedInfo:(NSManagedObjectContext *)context{

    NSMutableDictionary *allViews = [self repackAllViews:packagedInfo];

    [self.builder createReportWithAllViews:allViews];
    [self.builder createProperty:allViews:context];
    
}

-(NSMutableDictionary *)repackAllViews:(NSDictionary *)packagedInfo{
    
    self.address = [packagedInfo objectForKey:@"address"];
    
    if ([self.address isEqualToString:@""] || self.address == nil)
        self.address = @"New Property";
    
    self.buildingType =[packagedInfo objectForKey:@"buildingType"];
    self.postalzip = [packagedInfo objectForKey:@"postalzip"];
    self.country = [packagedInfo objectForKey:@"country"];
    self.unit = [packagedInfo objectForKey:@"units"];
    self.size = [packagedInfo objectForKey:@"size"];
    self.purchasePrice = [packagedInfo objectForKey:@"purchasePrice"];
    self.downPaymentSize = [packagedInfo objectForKey:@"downPayment"];
    
    self.rentAmount = [packagedInfo objectForKey:@"rentAmount"];
    
    self.administration = [packagedInfo objectForKey:@"admin"];
    self.electricityHeating = [packagedInfo objectForKey:@"elecHeat"];
    self.insurance = [packagedInfo objectForKey:@"insurance"];
    self.maintenanceRepairs = [packagedInfo objectForKey:@"mNr"];
    self.municipalTax = [packagedInfo objectForKey:@"munTax"];
    self.structuralReserve = [packagedInfo objectForKey:@"structRes"];
    
    self.amortization = [packagedInfo objectForKey:@"amort"];
    self.amt = [packagedInfo objectForKey:@"mtg"];
    self.interest = [packagedInfo objectForKey:@"rate"];
    self.term = [packagedInfo objectForKey:@"term"];
    
    
    NSMutableDictionary *packages = [[[NSMutableDictionary alloc] init] autorelease];
    
    NSMutableDictionary *propPackage = [[NSMutableDictionary alloc] init];
    
    [propPackage setValue:[self cleanInput:self.address] forKey:@"address"];
    [propPackage setValue:[self cleanInput:self.buildingType] forKey:@"buildingType"];
    [propPackage setValue:[self cleanInput:self.postalzip] forKey:@"postalzip"];
    [propPackage setValue:[self cleanInput:self.country] forKey:@"country"];
    [propPackage setValue:[self cleanInput:self.unit] forKey:@"units"];
    [propPackage setValue:[self cleanInput:self.size] forKey:@"size"];
    [propPackage setValue:[self cleanInput:self.purchasePrice] forKey:@"purchasePrice"];
    [propPackage setValue:[self cleanInput:self.downPaymentSize] forKey:@"downpayment"];
    
    [packages setValue:propPackage forKey:@"property"];
    [propPackage release];
    
    
    NSMutableDictionary *revPackage = [[NSMutableDictionary alloc] init];
    
    [revPackage setValue:[self cleanInput:self.rentAmount] forKey:@"rentAmount"];
    
    [packages setValue:revPackage forKey:@"revenue"];
    [revPackage release];
    
    
    NSMutableDictionary *expPackage = [[NSMutableDictionary alloc] init];
    
    [expPackage setValue:[self cleanInput:self.administration] forKey:@"administration"];
    [expPackage setValue:[self cleanInput:self.electricityHeating] forKey:@"elecHeat"];
    [expPackage setValue:[self cleanInput:self.insurance] forKey:@"insurance"];
    [expPackage setValue:[self cleanInput:self.maintenanceRepairs] forKey:@"mNr"];
    [expPackage setValue:[self cleanInput:self.municipalTax] forKey:@"munTax"];
    [expPackage setValue:[self cleanInput:self.structuralReserve] forKey:@"structRes"];
    
    [packages setValue:expPackage forKey:@"expense"];
    [expPackage release];
    
    
    NSMutableDictionary *mtgPackage = [[NSMutableDictionary alloc] init];
    
    [mtgPackage setValue:[self cleanInput:self.amortization] forKey:@"amort"];
    [mtgPackage setValue:[self cleanInput:self.term] forKey:@"term"];
    [mtgPackage setValue:[self cleanInput:self.amt] forKey:@"mtg"];
    [mtgPackage setValue:[self cleanInput:self.interest] forKey:@"rate"];
    
    [packages setValue:mtgPackage forKey:@"mortgage"];
    [mtgPackage release];
    
    return packages;
}


-(void)setPropertyUpdatePackage:(NSMutableDictionary *)formattedPackages:(Property *)property{

     [self.builder updateProperty:[self getEditedTxtFields:formattedPackages]:property];
    
}

-(void)setReportUpdatePackage:(NSDictionary *)rawPackages:(Property *)property{
    
    NSDictionary *repackedViews = [self repackAllViews:rawPackages];
    
    [self.builder updateReport:repackedViews:property];
}

-(NSMutableDictionary *)getEditedTxtFields:(NSMutableDictionary *)packagedInfo{
    
    NSMutableDictionary *changedTxtFields = [[[NSMutableDictionary alloc] init] autorelease];
    
    // Add dictionaries that actually have entries (viewControllers that have been changed) 
    for(id key in packagedInfo)
    {
        if([[packagedInfo objectForKey:key] count] > 0)
        {
            [changedTxtFields setValue:[packagedInfo objectForKey:key] forKey:key] ;
        }
    }
    
    return changedTxtFields;
}


-(ReportData *)showReport:(NSMutableDictionary *)changedTextField:(NSMutableDictionary *)allTextField:(Property *)property{
    
    
    NSMutableDictionary *editedViews = [self getEditedTxtFields:changedTextField];
    NSMutableDictionary *cleanFields = [[[NSMutableDictionary alloc]init] autorelease];
    NSMutableDictionary *cleanViews = [[[NSMutableDictionary alloc] init] autorelease];
    UITextField *txtField;
    
    
    for(id key in editedViews)
    {
         
        for(id k in [editedViews objectForKey:key])
        {
            NSDictionary *currentView = [editedViews objectForKey:key];
            txtField = [currentView objectForKey:k];
            txtField.text = [self cleanInput:[txtField text]];           
            [cleanFields setValue:txtField forKey:k];
        }
        
        [cleanViews setValue:cleanFields forKey:key];
    }
    
    NSMutableDictionary *allViews = [self repackAllViews:allTextField];
    
    ReportData *compiledReport = [self.builder createReport:editedViews:allViews:property];
    
    return compiledReport;
}
     
#pragma mark - Data Cleaning - Custom Methods

// Sets an object to a number or a string if it's   
-(id)cleanInput:(id)input{
    
    id cleanOutput = input;
    
    if (input == nil)
        cleanOutput =  @"";
    else if(input == [NSDecimalNumber notANumber])
        cleanOutput = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    return cleanOutput;
}




#pragma mark - Memory Management - Custom Methods

-(void)dealloc{
    
    [builder release];
    [super dealloc];
}
     
     

@end
