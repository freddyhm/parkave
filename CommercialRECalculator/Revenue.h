//
//  Revenue.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-11-03.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>

@class Property;

@interface Revenue : NSManagedObject {
@private
}
@property (nonatomic, retain) NSDecimalNumber * rentAmount;
@property (nonatomic, retain) Property * property;

@end
