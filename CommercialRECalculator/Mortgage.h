//
//  Mortgage.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-11-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Property;

@interface Mortgage : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDecimalNumber * term;
@property (nonatomic, retain) NSDecimalNumber * amortization;
@property (nonatomic, retain) NSDecimalNumber * interest;
@property (nonatomic, retain) NSDecimalNumber * amt;
@property (nonatomic, retain) Property * property;

@end
