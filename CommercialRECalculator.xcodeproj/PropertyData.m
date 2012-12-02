//
//  PropertyData.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PropertyData.h"


@implementation PropertyData
@synthesize unit;
@synthesize postalzip;
@synthesize downPaymentSize;
@synthesize address;
@synthesize type;
@synthesize size;
@synthesize totalExpense;
@synthesize totalRevenue;
@synthesize purchasePrice;
@synthesize country;
@synthesize revenue;
@synthesize expense;
@synthesize mortgage;
@synthesize report;
@synthesize moduleList;


-(void)dealloc {
    
    [unit release];
    [postalzip release];
    [downPaymentSize release];
    [address release];
    [type release];
    [size release];
    [totalExpense release];
    [totalRevenue release];
    [purchasePrice release];
    [country release];
    [revenue release];
    [expense release];
    [mortgage release];
    [report release];
    [moduleList release];
    [super dealloc];
}

@end
