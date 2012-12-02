//
//  ExpenseTabViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabBarViewController.h"
#import "Expense.h"

@interface ExpenseTabViewController : TabBarViewController
{
    UITextField *txtMunTax;
    UITextField *txtElecHeat;
    UITextField *txtInsurance;
    UITextField *txtMnR;
    UITextField *txtStructRes;
    UITextField *txtAdmin;
    UITextField *txtExpIncr;
    UITextField *txtVacBad;
    Expense *expense;
}

@property (nonatomic, retain) UITextField *txtMunTax;;
@property (nonatomic, retain) UITextField *txtElecHeat;
@property (nonatomic, retain) UITextField *txtInsurance;
@property (nonatomic, retain) UITextField *txtMnR;
@property (nonatomic, retain) UITextField *txtStructRes;
@property (nonatomic, retain) UITextField *txtAdmin;
@property (nonatomic, retain) UITextField *txtExpIncr;
@property (nonatomic, retain) UITextField *txtVacBad;
@property (nonatomic, retain) Expense *expense;


-(void)loadValues:(Property *)propertyIn;
-(void)showFieldsLabels;
-(IBAction)backgroundTap:(id)sender;

@end

