//
//  MtgData.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "PropertyData.h"

@interface MortgageData : NSObject {
    
    NSDecimalNumber *amortization;
    NSDecimalNumber *amt;
    NSDecimalNumber *interest;
    NSDecimalNumber *term;
    PropertyData *property;
    
}

@property (nonatomic, retain) NSDecimalNumber *amortization;
@property (nonatomic, retain) NSDecimalNumber *amt;
@property (nonatomic, retain) NSDecimalNumber *interest;
@property (nonatomic, retain) NSDecimalNumber *term;
@property (nonatomic, retain) PropertyData *property;


@end
