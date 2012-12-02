//
//  PropertyData.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface PropertyData : NSObject {
    
    NSDecimalNumber *unit;
    NSString *postalzip;
    NSDecimalNumber *downPaymentSize;
    NSString *address;
    NSString *type;
    NSDecimalNumber *size;
    NSDecimalNumber *totalExpense;
    NSDecimalNumber *totalRevenue;
    NSDecimalNumber *purchasePrice;
    NSString *country;
    NSSet *revenue;
    NSSet *expense;
    NSSet *mortgage;
    NSSet *report;
    NSString *moduleList;

    
}

@property (nonatomic, retain) NSDecimalNumber *unit;
@property (nonatomic, retain) NSString * postalzip;
@property (nonatomic, retain) NSDecimalNumber * downPaymentSize;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDecimalNumber * size;
@property (nonatomic, retain) NSDecimalNumber * totalExpense;
@property (nonatomic, retain) NSDecimalNumber * totalRevenue;
@property (nonatomic, retain) NSDecimalNumber * purchasePrice;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSSet* revenue;
@property (nonatomic, retain) NSSet* expense;
@property (nonatomic, retain) NSSet* mortgage;
@property (nonatomic, retain) NSSet* report;
@property (nonatomic, retain) NSString *moduleList;

@end
