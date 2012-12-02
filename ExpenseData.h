//
//  ExpData.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-10-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyData.h"


@interface ExpenseData : NSObject {
    
    NSDecimalNumber *structuralReserve;
    NSDecimalNumber *administration;
    NSDecimalNumber *electricityHeating;
    NSDecimalNumber *insurance;
    NSDecimalNumber *maintenanceRepairs;
    NSDecimalNumber *municipalTax;
    PropertyData *property;
    
}

@property (nonatomic, retain) NSDecimalNumber * structuralReserve;
@property (nonatomic, retain) NSDecimalNumber * administration;
@property (nonatomic, retain) NSDecimalNumber * electricityHeating;
@property (nonatomic, retain) NSDecimalNumber * insurance;
@property (nonatomic, retain) NSDecimalNumber * maintenanceRepairs;
@property (nonatomic, retain) NSDecimalNumber * municipalTax;
@property (nonatomic, retain) PropertyData * property;

@end
