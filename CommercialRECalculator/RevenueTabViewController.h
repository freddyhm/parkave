//
//  RevenueTabViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabBarViewController.h"
#import "Revenue.h"

@interface RevenueTabViewController : TabBarViewController
{
    UITextField *txtRent;
    UITextField *txtExpRec;
    UITextField *txtIncreases;
    Revenue *revenue;
    
}

@property(nonatomic, retain) UITextField *txtRent;
@property(nonatomic, retain) UITextField *txtExpRec;
@property(nonatomic, retain) UITextField *txtIncreases;
@property(nonatomic, retain) Revenue *revenue;

-(void)showFieldsLabels;
-(void)loadValues:(Property *)propertyIn;
-(IBAction)backgroundTap:(id)sender;

@end
