//
//  RootViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ListPropertyViewController.h"
#import "CalculatorModule.h"
#import "SettingsParameterViewController.h"

@interface RootViewController : UIViewController<NSFetchedResultsControllerDelegate, UITabBarControllerDelegate> {
    
    UITabBarController *tabBarController;
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;

}

@property (nonatomic, retain) UITabBarController *tabBarController;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

- (IBAction) calcModule;
- (IBAction) propModule;
- (IBAction) setModule;


@end
