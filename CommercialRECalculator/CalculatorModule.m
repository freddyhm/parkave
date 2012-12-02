//
//  CalculatorModule.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "CalculatorModule.h"


@implementation CalculatorModule
@synthesize controllers;
@synthesize managedObjectContext=__managedObjectContext;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}


#pragma mark - Memory Management

- (void)dealloc
{
    [__managedObjectContext release];
    [controllers release];
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    self.title = @"Calculator";
    
    NSMutableArray *array = [[NSMutableArray alloc] init];

    CapRateCalcController *capRateCalcController = [[CapRateCalcController alloc] init];
    capRateCalcController.title = @"Cap Rate";
    capRateCalcController.managedObjectContext = __managedObjectContext;
    [array addObject:capRateCalcController];
    [CapRateCalcController release];
    
    MtgCalcController *mtgCalcController = [[MtgCalcController alloc] init];
    mtgCalcController.managedObjectContext = __managedObjectContext;
    mtgCalcController.title = @"Mortgage";
    [array addObject:mtgCalcController];
    [mtgCalcController release];
    
    self.controllers = array;
    
    [array release];
    [super viewDidLoad];

}

- (void)viewDidUnload
{
    self.controllers = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
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
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [self.controllers count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell...
    UIViewController *controller = [self.controllers objectAtIndex:indexPath.row];

    cell.textLabel.text = controller.title;
    
    return cell;
}

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller = [self.controllers objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:controller animated:YES];
}

@end
