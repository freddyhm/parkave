//
//  RevData.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-10-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyData.h"

@interface RevenueData : NSObject {
    
    NSDecimalNumber *rentAmount;
    PropertyData *property;
    
}

@property (nonatomic, retain) NSDecimalNumber *rentAmount;
@property (nonatomic, retain) PropertyData *property;

@end
