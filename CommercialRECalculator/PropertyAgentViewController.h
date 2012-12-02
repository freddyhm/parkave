//
//  PropertyAgentViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-01-18.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PropertyContractor.h"
#import "PropertyTabViewController.h"
#import "RevenueTabViewController.h"
#import "ExpenseTabViewController.h"
#import "MortgageTabViewController.h"
#import "ReportTabViewController.h"
#import "Property.h"

//delegate to return property to be saved
@protocol PropertyDelegate <NSObject>

-(void)saveProperty;
-(void)deleteProperty:(Property *)propertyIn;

@end

@interface PropertyAgentViewController : UIViewController <UITabBarDelegate, UIActionSheetDelegate>{
    
	NSArray *viewControllers;
    
    UIButton *deleteBtn;
	
    UITabBar *tabBar;
	UITabBarItem *propertyTabBarItem;
	UITabBarItem *revenueTabBarItem;
    UITabBarItem *expenseTabBarItem;
    UITabBarItem *mortgageTabBarItem;
    UITabBarItem *reportTabBarItem;
    
	UIViewController *selectedViewController;
    
    Property *property;
    PropertyContractor *contractor;
        
    PropertyTabViewController *propViewController;    
    RevenueTabViewController *revViewController;
    ExpenseTabViewController *expViewController;
    MortgageTabViewController *mtgViewController;
    ReportTabViewController *repViewController;
    
    id<PropertyDelegate> delegate;
    
    NSManagedObjectContext *managedObjectContext;
}


@property (nonatomic, retain) PropertyTabViewController *propViewController; 
@property (nonatomic, retain) RevenueTabViewController *revViewController;
@property (nonatomic, retain) ExpenseTabViewController *expViewController;
@property (nonatomic, retain) MortgageTabViewController *mtgViewController;
@property (nonatomic, retain) ReportTabViewController *repViewController;

@property (nonatomic, retain) Property *property;
@property (nonatomic, retain) PropertyContractor *contractor;

@property (nonatomic, retain) UIButton *deleteBtn;
@property (nonatomic, retain) NSString *source;
@property (nonatomic, retain) NSArray *viewControllers;
@property (nonatomic, retain) UITabBar *tabBar;
@property (nonatomic, retain) UITabBarItem *propertyTabBarItem;
@property (nonatomic, retain) UITabBarItem *revenueTabBarItem;
@property (nonatomic, retain) UITabBarItem *expenseTabBarItem;
@property (nonatomic, retain) UITabBarItem *mortgageTabBarItem;
@property (nonatomic, retain) UITabBarItem *reportTabBarItem;
@property (nonatomic, retain) UIViewController *selectedViewController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;
@property(nonatomic,assign)id delegate;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contractor:(PropertyContractor *)contractorIn; 

-(void)buildProperty;
-(void)updateProperty;
-(void)showProperty:(Property *)propertyIn;
-(void)deleteProperty;
-(NSString *)decimalNumToCurrency:(NSDecimalNumber *)decimalNum;
-(NSDecimalNumber *)currencyStrToDecimalNum:(NSString *)currencystr;
-(void)addProperty:(NSManagedObjectContext *)context;
-(NSMutableDictionary *)getFormattedTxtFields;
-(void)displayReport:(Property *)property;
-(void)resetEditedTxtFields;
-(NSMutableDictionary *)packageRawViews;
-(void)confirmDelete;

@end
