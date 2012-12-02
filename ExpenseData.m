//
//  ExpData.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-10-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ExpenseData.h"


@implementation ExpenseData
@synthesize structuralReserve, administration;
@synthesize electricityHeating, insurance;
@synthesize maintenanceRepairs, municipalTax;
@synthesize property;

-(void)dealloc{
    
    [structuralReserve release];
    [administration release];
    [electricityHeating release];
    [maintenanceRepairs release];
    [insurance release];
    [municipalTax release];
    [property release];
    [super dealloc];
}

@end
