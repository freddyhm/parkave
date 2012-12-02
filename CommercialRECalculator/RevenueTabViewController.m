//
//  RevenueTabViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-18.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//



#import "RevenueTabViewController.h"

@implementation RevenueTabViewController
@synthesize revenue;
@synthesize txtRent, txtExpRec, txtIncreases;


#pragma mark - Custom Methods


-(void)showFieldsLabels{
    
    self.txtRent = [self txtFieldMaker:170 :10:UIKeyboardTypeNumberPad:@"$2,000,000"];

    [self.view addSubview:self.txtRent];
    
    [self.view addSubview:[self lblMaker:@"Total Revenue":10:10]];
    
}

-(void)loadValues:(Property *)propertyIn{
    
    self.property = propertyIn;
    
    self.revenue = (Revenue *)[self.property.revenue anyObject];
    self.txtRent.text = [self nAnToZero:self.revenue.rentAmount];
}

// Hide keyboard when tapping background while editing
- (IBAction)backgroundTap:(id)sender{

    [txtRent resignFirstResponder];
    [txtExpRec resignFirstResponder];
    [txtIncreases resignFirstResponder];
}


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

#pragma mark - Memory Management

- (void)viewDidUnload
{
    self.numberFormatter = nil;
    self.source = nil;
    self.settings = nil;
    self.property = nil;
    
    self.revenue = nil;
    self.txtExpRec = nil;
    self.txtIncreases = nil;
    self.txtRent = nil;
    
    [super viewDidUnload];
}

- (void)dealloc
{
    [revenue release];
    [txtExpRec release];
    [txtIncreases release];
    [txtRent release];
    [super dealloc];
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
    UIControl *revControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    UIImage *bckgdimg = [UIImage imageNamed:@"PLAINBG.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:bckgdimg];
    [revControl addSubview:imgView];    
    [revControl addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    
    self.view = revControl;

    [revControl release];
    [super viewDidLoad];
 }


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


@end
