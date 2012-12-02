    
//  ListPropertyViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-10-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "ListPropertyViewController.h"
#import "CommercialRECalculatorAppDelegate.h"

@interface ListPropertyViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end


@implementation ListPropertyViewController

@synthesize fetchedResultsController=__fetchedResultsController;

@synthesize managedObjectContext=__managedObjectContext;

@synthesize builder, contractor, agent;



- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
    }
    return self;
}


#pragma mark - Memory Management

- (void)dealloc
{
    [__fetchedResultsController release];
    [__managedObjectContext release];
    [builder release];
    [agent release];
    [super dealloc];
}

- (void) viewDidUnload{
    
    self.fetchedResultsController = nil;
    self.managedObjectContext = nil;
    self.agent = nil;
    self.contractor = nil;
    self.builder = nil;
    [super viewDidUnload];
    
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - Custom Methods

- (void)addProperty{
    
    [self.agent addProperty:self.managedObjectContext];
    
    [self.navigationController pushViewController:self.agent animated:YES];
        
}

-(void)popToRoot{
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

-(void)saveProperty{

    
    Property *finalProperty = [self.builder property];
    
    NSError *error = nil;
    
	if (![finalProperty.managedObjectContext save:&error]) {
        
        CommercialRECalculatorAppDelegate *appDelegate = (CommercialRECalculatorAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate showCoreDataError];
	}
}

-(void)deleteProperty:(Property *)propertyIn{
    
    Property *finalProperty = propertyIn;

    NSError *error = nil;
    
    [finalProperty.managedObjectContext deleteObject:finalProperty];

    if(![finalProperty.managedObjectContext save:&error])
    {
        CommercialRECalculatorAppDelegate *appDelegate = (CommercialRECalculatorAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate showCoreDataError];
    }

    
}

#pragma mark - Custom Methods

- (void)viewDidLoad
{
    
    self.title = @"Properties";
       
    self.navigationItem.rightBarButtonItem = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addProperty)]autorelease];
    
    self.navigationItem.leftBarButtonItem = [[[UIBarButtonItem alloc] initWithTitle:@"Park Ave" style:UIBarButtonItemStylePlain target:self action:@selector(popToRoot)]autorelease];
    
    
    PropertyBuilder *propbuilder = [[PropertyBuilder alloc] init];
    
    self.builder = propbuilder;
    
    [propbuilder release];
    
    
    PropertyContractor *propcontractor = [[PropertyContractor alloc] initWithBuilder:self.builder];
    
    self.contractor = propcontractor;
    
    [propcontractor release];
    
    
    PropertyAgentViewController *propagent = [[PropertyAgentViewController alloc] initWithNibName:@"TabViewController" bundle:nil contractor:self.contractor];
    
    propagent.delegate = self;
    
    self.agent = propagent;

    
    [propagent release];
    [super viewDidLoad];

}


- (void)viewWillAppear:(BOOL)animated
{
    [self.tableView reloadData];
    
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return [[self.fetchedResultsController sections] count];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    id <NSFetchedResultsSectionInfo> sectionInfo = [[self.fetchedResultsController sections] objectAtIndex:section];
    return [sectionInfo numberOfObjects];

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    [self configureCell:cell atIndexPath:indexPath];	
    return cell;
}


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        
        NSError *error;
        
        NSManagedObjectContext *context = [__fetchedResultsController managedObjectContext];

        [context deleteObject:[__fetchedResultsController objectAtIndexPath:indexPath]];
        
        
        if(![context save:&error])
        {
            CommercialRECalculatorAppDelegate *appDelegate = (CommercialRECalculatorAppDelegate *)[[UIApplication sharedApplication] delegate];
            [appDelegate showCoreDataError];
        }
        
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    Property *selectedProperty = (Property *)[__fetchedResultsController objectAtIndexPath:indexPath];
        
    [self.navigationController pushViewController:self.agent animated:YES]; 
    
    [self.agent showProperty:selectedProperty];
}


#pragma mark - Table Data Source Delegates

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    NSManagedObject *managedObject = [self.fetchedResultsController objectAtIndexPath:indexPath];
    cell.textLabel.text = [[managedObject valueForKey:@"address"] description];
}

#pragma mark - Fetched results controller

- (NSFetchedResultsController *)fetchedResultsController
{
    if (__fetchedResultsController != nil)
    {
        return __fetchedResultsController;
    }
    
    /*
     Set up the fetched results controller.
     */
    // Create the fetch request for the entity.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    // Edit the entity name as appropriate.
    
   // NSManagedObjectContext *context = [self managedObjectContext];
    
    NSEntityDescription *entity = [NSEntityDescription entityForName:@"Property" inManagedObjectContext:self.managedObjectContext];
    [fetchRequest setEntity:entity];
    
    // Set the batch size to a suitable number.
    [fetchRequest setFetchBatchSize:20];
    
    // Edit the sort key as appropriate.
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"timeStamp" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortDescriptor, nil];
    
    [fetchRequest setSortDescriptors:sortDescriptors];
    
    // Edit the section name key path and cache name if appropriate.
    // nil for section name key path means "no sections".
    NSFetchedResultsController *aFetchedResultsController = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext sectionNameKeyPath:nil cacheName:@"Root"];
    aFetchedResultsController.delegate = self;
    self.fetchedResultsController = aFetchedResultsController;
    
    [aFetchedResultsController release];
    [fetchRequest release];
    [sortDescriptor release];
    [sortDescriptors release];
    
	NSError *error = nil;
	if (![self.fetchedResultsController performFetch:&error])
    {
        
	    CommercialRECalculatorAppDelegate *appDelegate = (CommercialRECalculatorAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate showCoreDataError];
         
	}
    
    return __fetchedResultsController;
}    

#pragma mark - Fetched results controller delegate

- (void)controllerWillChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView beginUpdates];
}

- (void)controller:(NSFetchedResultsController *)controller didChangeSection:(id <NSFetchedResultsSectionInfo>)sectionInfo
           atIndex:(NSUInteger)sectionIndex forChangeType:(NSFetchedResultsChangeType)type
{
    switch(type)
    {
        case NSFetchedResultsChangeInsert:
            [self.tableView insertSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [self.tableView deleteSections:[NSIndexSet indexSetWithIndex:sectionIndex] withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject
       atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type
      newIndexPath:(NSIndexPath *)newIndexPath
{
    UITableView *tableView = self.tableView;
    
    switch(type)
    {
            
        case NSFetchedResultsChangeInsert:
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeDelete:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            break;
            
        case NSFetchedResultsChangeUpdate:
            [self configureCell:[tableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
            break;
            
        case NSFetchedResultsChangeMove:
            [tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            [tableView insertRowsAtIndexPaths:[NSArray arrayWithObject:newIndexPath]withRowAnimation:UITableViewRowAnimationFade];
            break;
    }
}

- (void)controllerDidChangeContent:(NSFetchedResultsController *)controller
{
    [self.tableView endUpdates];
}




@end
