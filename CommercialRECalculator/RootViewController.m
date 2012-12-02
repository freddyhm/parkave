//
//  RootViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-27.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "RootViewController.h"



@implementation UINavigationBar (UINavigationBarCategory)



@end

@implementation RootViewController
@synthesize tabBarController;
@synthesize fetchedResultsController=__fetchedResultsController;

@synthesize managedObjectContext=__managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
       
       
    }
    return self;
}

#pragma mark - Custom Methods

//Pushes the calculator controller
- (void)propModule{
    
    ListPropertyViewController *propList = [[ListPropertyViewController alloc] initWithNibName:@"ListPropertyViewController" bundle:nil];
    propList.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:propList animated:YES];
    [propList release];
    
}

//Pushes the property controller
- (void)calcModule{
    
    CalculatorModule *calcView = [[CalculatorModule alloc] initWithNibName:@"CalculatorModule" bundle:nil];
    calcView.managedObjectContext = self.managedObjectContext;
    [self.navigationController pushViewController:calcView animated:YES];
    [calcView release];
    
}

//Pushes the settings controller
- (void)setModule{
    
    SettingsParameterViewController *parameterViewController = [[SettingsParameterViewController alloc] initWithNibName:@"SettingsParameterViewController" bundle:nil];
    [self.navigationController pushViewController:parameterViewController animated:YES];
    [parameterViewController release];

}

#pragma mark - Memory Management

- (void)dealloc
{
    [tabBarController release];
    [__fetchedResultsController release];
    [__managedObjectContext release];
    [super dealloc];
}

- (void)viewDidUnload
{
    self.tabBarController = nil;
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
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
    self.title = @"Park Ave";
    
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}


-(void)viewWillAppear:(BOOL)animated{
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    
     [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

@end
