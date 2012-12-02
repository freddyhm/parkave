//
//  CalcViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-02-01.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "PropertyBuilder.h"
#import "ListPropertyViewController.h"
#import "AppDelegateProtocol.h"
#import "AppDataObjects.h"

@class CommercialRECalculatorAppDelegate;

@interface CalcViewController : UIViewController <UITextFieldDelegate, UIAlertViewDelegate>{

    NSManagedObjectContext *managedObjectContext;
    PropertyBuilder *builder;
    NSNumberFormatter *numberFormatter;
    NSString *propertyAddress;
    NSMutableDictionary *package;
    
}

@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain) PropertyBuilder *builder;
@property (nonatomic, retain) NSNumberFormatter *numberFormatter;
@property (nonatomic, retain) NSString *propertyAddress;
@property (nonatomic, retain) NSMutableDictionary *package;


-(IBAction)backgroundTap:(id)sender;
-(AppDataObjects *) dataObjects;
-(void)displayResults;
-(void)save;
-(NSDecimalNumber *)nAnToZero:(NSDecimalNumber *)input;
-(UITextField *)txtFieldMaker:(int)posX:(int)posY:(UIKeyboardType)kbtype:(NSString *)holder;
-(UILabel *)lblMaker:(NSString *)labelText:(int)posX:(int)posY;
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
-(NSDecimalNumber *)currencyStrToDecimalNum:(NSString *)currencystr;
-(NSString *)decimalNumToCurrency:(NSDecimalNumber *)decimalNum;
- (void)getAddressFromAlert;
-(void)sendPackageToBuilder;

@end
