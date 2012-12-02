//
//  Property.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-02-03.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Expense, Mortgage, Report, Revenue;

@interface Property : NSManagedObject

@property (nonatomic, retain) NSDate * timeStamp;
@property (nonatomic, retain) NSString * unit;
@property (nonatomic, retain) NSString * postalzip;
@property (nonatomic, retain) NSDecimalNumber * downPaymentSize;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSString * size;
@property (nonatomic, retain) NSString * moduleList;
@property (nonatomic, retain) NSString * address;
@property (nonatomic, retain) NSDecimalNumber * totalRevenue;
@property (nonatomic, retain) NSDecimalNumber * totalExpense;
@property (nonatomic, retain) NSDecimalNumber * purchasePrice;
@property (nonatomic, retain) NSString * country;
@property (nonatomic, retain) NSSet *revenue;
@property (nonatomic, retain) NSSet *expense;
@property (nonatomic, retain) NSSet *mortgage;
@property (nonatomic, retain) NSSet *report;
@end

@interface Property (CoreDataGeneratedAccessors)

- (void)addRevenueObject:(Revenue *)value;
- (void)removeRevenueObject:(Revenue *)value;
- (void)addRevenue:(NSSet *)values;
- (void)removeRevenue:(NSSet *)values;
- (void)addExpenseObject:(Expense *)value;
- (void)removeExpenseObject:(Expense *)value;
- (void)addExpense:(NSSet *)values;
- (void)removeExpense:(NSSet *)values;
- (void)addMortgageObject:(Mortgage *)value;
- (void)removeMortgageObject:(Mortgage *)value;
- (void)addMortgage:(NSSet *)values;
- (void)removeMortgage:(NSSet *)values;
- (void)addReportObject:(Report *)value;
- (void)removeReportObject:(Report *)value;
- (void)addReport:(NSSet *)values;
- (void)removeReport:(NSSet *)values;
@end
