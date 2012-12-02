//
//  SettingsParameterViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-11-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "SettingsParameterViewController.h"



@implementation SettingsParameterViewController
@synthesize controllers;



- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = @"Settings";
    }
    return self;
}

#pragma mark - Memory Management

- (void)dealloc
{
    [controllers release];
    [super dealloc];
}

- (void)viewDidUnload
{
    self.controllers = nil;
    [super viewDidUnload];

}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    ParameterViewController *capRate = [[ParameterViewController alloc] initWithFilename:@"capRateData.plist" :@"Cap Rate"];
    
    //ParameterViewController *netRev = [[ParameterViewController alloc] initWithFilename:@"netRevData.plist" :@"Net Revenue"];
    
    ParameterViewController *netRevRatio = [[ParameterViewController alloc] initWithFilename:@"netRevRatioData.plist" :@"Net Revenue Ratio"];
    
    ParameterViewController *grossRevRatio = [[ParameterViewController alloc] initWithFilename:@"grossRevRatioData.plist" :@"Gross Revenue Ratio"];
    
    ParameterViewController *debtCovRatio = [[ParameterViewController alloc] initWithFilename:@"debtCovRatioData.plist" :@"Debt Cover Ratio"];
    
    //ParameterViewController *retCashFlow = [[ParameterViewController alloc] initWithFilename:@"retCashFlowData.plist" :@"Return Cash Flow"]; 
    
    //ParameterViewController *annDebtServ = [[ParameterViewController alloc] initWithFilename:@"annDebtServData.plist" : @"Annual Debt Service Data"];
    
    //ParameterViewController *mthPmt = [[ParameterViewController alloc] initWithFilename:@"mthPmtData.plist" : @"Monthly Payments"];
    
    //ParameterViewController *numPmt = [[ParameterViewController alloc] initWithFilename:@"numPmtData.plist" : @"Number Of Payments"];
    
    //ParameterViewController *mthMtgConst = [[ParameterViewController alloc] initWithFilename:@"mthMtgConstData.plist" : @"Monthly Mortgage Const"];
    
   // ParameterViewController *annMtgConst = [[ParameterViewController alloc] initWithFilename:@"annMtgConstData.plist" : @"Annual Mortgage Const"];
    
    ParameterViewController *effectRate = [[ParameterViewController alloc] initWithFilename:@"effectRateData.plist" : @"Effective Rate"];
    
    
    NSArray *array = [NSArray arrayWithObjects:capRate, netRevRatio,grossRevRatio,debtCovRatio, effectRate, nil];
    
    [capRate release];
    [netRevRatio release];
    
    self.controllers = array;
    [super viewDidLoad];
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
    ParameterViewController *controller = [self.controllers objectAtIndex:indexPath.row]; 
    cell.textLabel.text = controller.lblTitle.text;
    
    return cell;
}


#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    UIViewController *controller = [self.controllers objectAtIndex:indexPath.row];
 
    [self.navigationController pushViewController:controller animated:YES];
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
	
	NSString *sectionHeader = nil;
	
	if(section == 0) {
		sectionHeader = @"Indicators";
	}
	
	
	return sectionHeader;
}

@end
