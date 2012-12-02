//
//  Expense.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-11-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Property;

@interface Expense : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDecimalNumber * structuralReserve;
@property (nonatomic, retain) NSDecimalNumber * administration;
@property (nonatomic, retain) NSDecimalNumber * electricityHeating;
@property (nonatomic, retain) NSDecimalNumber * insurance;
@property (nonatomic, retain) NSDecimalNumber * maintenanceRepairs;
@property (nonatomic, retain) NSDecimalNumber * municipalTax;
@property (nonatomic, retain) Property * property;

@end
