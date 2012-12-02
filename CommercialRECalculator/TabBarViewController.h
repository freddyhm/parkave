//
//  TabBarViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-01-14.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <QuartzCore/QuartzCore.h>
#import "AppDataObjects.h"
#import "AppDataContainer.h"
#import "AppDelegateProtocol.h"
#import "Property.h"


@interface TabBarViewController : UIViewController <UITextFieldDelegate>{
    
    NSString *source;
    NSArray *settings;
    Property *property;
    CGFloat animatedDistance;
    NSNumberFormatter *numberFormatter;
    NSMutableDictionary *editedTxtFieldDict;

}

@property(nonatomic, retain) NSString *source;
@property(nonatomic, retain) NSArray *settings;
@property(nonatomic, retain) Property *property;
@property(nonatomic, retain) NSNumberFormatter *numberFormatter;
@property(nonatomic, retain) NSMutableDictionary *editedTxtFieldDict;


-(AppDataObjects *) dataObjects;
-(NSString *)nilToStr:(NSString *)input;
-(UILabel *)lblMaker:(NSString *)labelText:(int)posX:(int)posY;
-(void)showFieldsLabels:(BOOL)propExist;
-(IBAction)backgroundTap:(id)sender;
- (NSString *)dataFilePath:(NSString *)filename;
-(void)loadSettings:(NSString *)filePath;
-(UITextField *)txtFieldMaker:(int)posX:(int)posY:(UIKeyboardType)kbtype:(NSString *)holder;
-(NSString *)nAnToZero:(NSDecimalNumber *)input;
-(void)delete;

@end
