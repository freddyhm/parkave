//
//  PropertyDataObject.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AppDataContainer.h"
#import "PropertyData.h"
#import "RevenueData.h"
#import "ExpenseData.h"
#import "MortgageData.h"
#import "ReportData.h"

//extends appdataobject
@interface AppDataObjects : AppDataContainer {
    
    PropertyData *propData;
    RevenueData *revData;
    ExpenseData *expData;
    MortgageData *mtgData;
    ReportData *repData;
    
}

@property (nonatomic, retain) PropertyData *propData;
@property (nonatomic, retain) RevenueData *revData;
@property (nonatomic, retain) ExpenseData *expData;
@property (nonatomic, retain) MortgageData *mtgData;
@property (nonatomic, retain) ReportData *repData;


@end
