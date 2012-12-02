//
//  PropertyTabViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "TabBarViewController.h"


@interface PropertyTabViewController : TabBarViewController
{
     UITextField *purchasePrice;
     UITextField *downPayment;
     UITextField *buildingType;
     UITextField *address;
     UITextField *postalzip;
     UITextField *country;
     UITextField *units;
     UITextField *size;
}

@property (nonatomic, retain) UITextField *purchasePrice;
@property (nonatomic, retain) UITextField *downPayment;
@property (nonatomic, retain) UITextField *buildingType;
@property (nonatomic, retain) UITextField *address;
@property (nonatomic, retain) UITextField *postalzip;
@property (nonatomic, retain) UITextField *country;
@property (nonatomic, retain) UITextField *units;
@property (nonatomic, retain) UITextField *size;

-(void)showFieldsLabels;
-(void)loadValues:(Property *)propertyIn;

@end
