//
//  CommercialRECalculatorAppDelegate.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RootViewController.h"
#import "AppDataObjects.h"
#import "AppDelegateProtocol.h"

@class AppDataObjects;

@interface CommercialRECalculatorAppDelegate : NSObject <UIApplicationDelegate, UITabBarControllerDelegate, UIAlertViewDelegate> {
        
    AppDataObjects *dataObjects;
    UINavigationController *navigationController;
    NSManagedObjectContext *managedObjectContext;
    NSManagedObjectModel *managedObjectModel;

}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain, readonly) NSManagedObjectContext *managedObjectContext;
@property (nonatomic, retain, readonly) NSManagedObjectModel *managedObjectModel;
@property (nonatomic, retain, readonly) NSPersistentStoreCoordinator *persistentStoreCoordinator;
@property (nonatomic, retain) AppDataObjects *dataObjects;
@property (nonatomic, retain) IBOutlet UINavigationController *navigationController;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;
- (void)showCoreDataError;

@end
