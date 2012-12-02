//
//  PropertyDataObject.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "AppDataObjects.h"


@implementation AppDataObjects
@synthesize propData;
@synthesize revData;
@synthesize expData;
@synthesize mtgData;
@synthesize repData;

-(id)init
{
    self.propData = [[PropertyData alloc] init];
    self.revData = [[RevenueData alloc] init];
    self.expData = [[ExpenseData alloc] init];
    self.mtgData = [[MortgageData alloc] init];
    self.repData = [[ReportData alloc] init];
    
    
    return [super init];
}

- (void)dealloc 
{
	//Release shared property.
	[propData release];
    [revData release];
    [expData release];
    [mtgData release];
    [repData release];
	[super dealloc];
}

@end
