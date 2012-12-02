//
//  CalculatorModule.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CapRateCalcController.h"
#import "MtgCalcController.h"
#import "ListPropertyViewController.h"

@interface CalculatorModule : UITableViewController{
    
    NSMutableArray *controllers;
    NSManagedObjectContext *context;
    
}

@property (nonatomic, retain) NSMutableArray *controllers;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

@end
