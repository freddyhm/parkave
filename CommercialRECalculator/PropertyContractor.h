//
//  PropertyContractor.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-01-18.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyBuilder.h"

@class Property;

@interface PropertyContractor : NSObject{
    
    PropertyBuilder *builder;
    
    NSDecimalNumber *unit;
    NSString *postalzip;
    NSString *address;
    NSString *buildingType;
    NSDecimalNumber *size;
    NSDecimalNumber *downPaymentSize;
    NSDecimalNumber *purchasePrice;
    NSString *country;
    
    NSDecimalNumber *rentAmount;
    
    NSDecimalNumber *structuralReserve;
    NSDecimalNumber *administration;
    NSDecimalNumber *electricityHeating;
    NSDecimalNumber *insurance;
    NSDecimalNumber *maintenanceRepairs;
    NSDecimalNumber *municipalTax;
    
    NSDecimalNumber *amortization;
    NSDecimalNumber *amt;
    NSDecimalNumber *interest;
    NSDecimalNumber *term;
    
    NSDecimalNumber *totalRev;
    NSDecimalNumber *totalExp;
    NSDecimalNumber *netRev;
    NSDecimalNumber *debtCovRatio;
    NSDecimalNumber *retCF;
    NSDecimalNumber *grossRevRatio;
    NSDecimalNumber *netRevRatio;
    NSDecimalNumber *capRate;

}

@property (nonatomic, retain) PropertyBuilder *builder;

@property (nonatomic, retain) NSDecimalNumber *unit;
@property (nonatomic, retain) NSString * postalzip;
@property (nonatomic, retain) NSString *buildingType;
@property (nonatomic, retain) NSDecimalNumber * downPaymentSize;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDecimalNumber * size;
@property (nonatomic, retain) NSDecimalNumber * purchasePrice;
@property (nonatomic, retain) NSString * country;

@property (nonatomic, retain) NSDecimalNumber * rentAmount;


@property (nonatomic, retain) NSDecimalNumber * structuralReserve;
@property (nonatomic, retain) NSDecimalNumber * administration;
@property (nonatomic, retain) NSDecimalNumber * electricityHeating;
@property (nonatomic, retain) NSDecimalNumber * insurance;
@property (nonatomic, retain) NSDecimalNumber * maintenanceRepairs;
@property (nonatomic, retain) NSDecimalNumber * municipalTax;

@property (nonatomic, retain) NSDecimalNumber *amortization;
@property (nonatomic, retain) NSDecimalNumber *amt;
@property (nonatomic, retain) NSDecimalNumber *interest;
@property (nonatomic, retain) NSDecimalNumber *term;

@property (nonatomic, retain) NSDecimalNumber *totalRev;
@property (nonatomic, retain) NSDecimalNumber *totalExp;
@property (nonatomic, retain) NSDecimalNumber *netRev;
@property (nonatomic, retain) NSDecimalNumber *debtCovRatio;
@property (nonatomic, retain) NSDecimalNumber *retCF;
@property (nonatomic, retain) NSDecimalNumber *grossRevRatio;
@property (nonatomic, retain) NSDecimalNumber *netRevRatio;
@property (nonatomic, retain) NSDecimalNumber *capRate;


-(id)initWithBuilder:(PropertyBuilder *)builderIn;
-(void)setBuildPackage:(NSDictionary *)packagedInfo:(NSManagedObjectContext *)context;
-(void)setPropertyUpdatePackage:(NSMutableDictionary *)formattedPackages:(Property *)property;
-(void)setReportUpdatePackage:(NSDictionary *)rawPackages:(Property *)property;
-(ReportData *)showReport:(NSMutableDictionary *)changedTextField:(NSMutableDictionary *)allTextField:(Property *)property;
-(NSMutableDictionary *)getEditedTxtFields:(NSMutableDictionary *)packagedInfo;
-(id)cleanInput:(id)input;
-(NSMutableDictionary *)repackAllViews:(NSDictionary *)packagedInfo;

@end
