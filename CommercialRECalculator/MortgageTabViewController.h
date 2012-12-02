//
//  MortgageTabViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabBarViewController.h"
#import "Mortgage.h"

@interface MortgageTabViewController : TabBarViewController{
    
    UITextField *txtMtgSize;
    UITextField *txtRate;
    UITextField *txtAmort;
    UITextField *txtTerm;
    Mortgage *mortgage;
}

@property (nonatomic, retain) UITextField *txtMtgSize;
@property (nonatomic, retain) UITextField *txtAmort;
@property (nonatomic, retain) UITextField *txtTerm;
@property (nonatomic, retain) UITextField *txtRate;
@property (nonatomic, retain) Mortgage *mortgage;

-(void)loadValues:(Property *)propertyIn;
-(void)showFieldsLabels;
- (IBAction)backgroundTap:(id)sender;

@end
