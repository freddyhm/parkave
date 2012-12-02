//
//  MtgData.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-26.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "MortgageData.h"


@implementation MortgageData

@synthesize amortization;
@synthesize interest;
@synthesize term;
@synthesize amt;
@synthesize property;

-(void)dealloc{
    
    [amortization release];
    [interest release];
    [term release];
    [amt release];
    [property release];
    [super dealloc];
}



@end
