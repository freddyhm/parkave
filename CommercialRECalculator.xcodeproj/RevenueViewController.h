//
//  RevenueViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Property.h"
#import "Revenue.h"

@interface RevenueViewController : UIViewController
<UITextFieldDelegate>
{
    NSManagedObjectContext *managedObjectContext;
    IBOutlet UITextField *txtRent;
    IBOutlet UITextField *txtExpRec;
    IBOutlet UITextField *txtIncreases;
    Property *property;
    Revenue *revenue;
}

@property(nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic, retain) IBOutlet UITextField *txtRent;
@property(nonatomic, retain) IBOutlet UITextField *txtExpRec;
@property(nonatomic, retain) IBOutlet UITextField *txtIncreases;
@property(nonatomic, retain) Property *property;
@property(nonatomic, retain) Revenue *revenue;

-(IBAction)backgroundTap:(id)sender;

@end
