//
//  ListPropertyViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-10-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "PropertyAgentViewController.h"

@interface ListPropertyViewController : UITableViewController <NSFetchedResultsControllerDelegate, PropertyDelegate>{
    
    NSFetchedResultsController *fetchedResultsController;
    NSManagedObjectContext *managedObjectContext;
    PropertyAgentViewController *agent;
    PropertyBuilder *builder;
    PropertyContractor *contractor;
    
}


@property (nonatomic, retain) PropertyAgentViewController *agent;
@property (nonatomic, retain) PropertyBuilder *builder;
@property (nonatomic, retain) PropertyContractor *contractor;
@property (nonatomic, retain) NSFetchedResultsController *fetchedResultsController;
@property (nonatomic, retain) NSManagedObjectContext *managedObjectContext;

-(void)addProperty;
-(void)saveProperty;
-(void)popToRoot;


@end

