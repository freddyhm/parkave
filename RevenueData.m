//
//  RevData.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-10-29.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RevenueData.h"


@implementation RevenueData
@synthesize rentAmount;
@synthesize property;


-(void)dealloc{
    
    [rentAmount release];
    [property release];
    [super dealloc];
}

@end
