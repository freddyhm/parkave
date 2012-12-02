//
//  PropertyTabViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-08-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PropertyTabViewController.h"


@implementation PropertyTabViewController

@synthesize purchasePrice, downPayment;
@synthesize buildingType, address, postalzip, country;
@synthesize units, size;

#pragma mark - Custom methods


//Display textfields
-(void)showFieldsLabels{
    
    //Create txtFields
    self.buildingType = [self txtFieldMaker:170:15:UIKeyboardTypeAlphabet:@"Commercial"];
    self.address = [self txtFieldMaker:170 :55:UIKeyboardTypeAlphabet:@"123 Park Ave"];
    self.postalzip = [self txtFieldMaker:170 :95:UIKeyboardTypeAlphabet:@"A1B 2C3"];
    self.country = [self txtFieldMaker:170 :135:UIKeyboardTypeAlphabet:@"Canada"];
    self.units = [self txtFieldMaker:170 :175:UIKeyboardTypeAlphabet:@"15 units"];
    self.size = [self txtFieldMaker:170 :215:UIKeyboardTypeAlphabet:@"12000 sqft"];
    self.purchasePrice = [self txtFieldMaker:170 :255:UIKeyboardTypeNumberPad:@"$1,000,000"];
    self.downPayment = [self txtFieldMaker:170 : 295:UIKeyboardTypeNumberPad:@"$150,000"];


    //Add txtFields to screen
    [self.view addSubview:self.buildingType];
    [self.view addSubview:self.address];
    [self.view addSubview:self.postalzip];
    [self.view addSubview:self.country];
    [self.view addSubview:self.units];
    [self.view addSubview:self.size];
    [self.view addSubview:self.purchasePrice];
    [self.view addSubview:self.downPayment];
    
    //Add default labels to screen
    [self.view addSubview:[self lblMaker:@"Property Type":10:15]];
    [self.view addSubview:[self lblMaker:@"Address":10:55]];
    [self.view addSubview:[self lblMaker:@"Postal/Zip":10:95]];
    [self.view addSubview:[self lblMaker:@"Country":10:135]];
    [self.view addSubview:[self lblMaker:@"Units":10:175]];
    [self.view addSubview:[self lblMaker:@"Size":10:215]];
    [self.view addSubview:[self lblMaker:@"Purchase Price":10:255]];
    [self.view addSubview:[self lblMaker:@"Down Payment":10:295]];
            
}

-(void)loadValues:(Property *)propertyIn{
    
    self.property = propertyIn;
    
    self.buildingType.text = self.property.type;
    self.address.text = self.property.address;
    self.postalzip.text = self.property.postalzip;
    self.country.text = self.property.country;
    self.units.text = self.property.unit;
    self.size.text = self.property.size;
    self.purchasePrice.text = [self nAnToZero:self.property.purchasePrice];
    self.downPayment.text = [self nAnToZero:self.property.downPaymentSize];
    
    
}

// Hide keyboard when tapping background while editing
- (IBAction)backgroundTap:(id)sender{
    
    [purchasePrice resignFirstResponder];
    [downPayment resignFirstResponder];
    [buildingType resignFirstResponder];
    [address resignFirstResponder];
    [postalzip resignFirstResponder];
    [country resignFirstResponder];
    [units resignFirstResponder];
    [size resignFirstResponder];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewDidLoad
{
    UIControl *propControl = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    UIImage *bckgdimg = [UIImage imageNamed:@"PLAINBG.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:bckgdimg];
    [propControl addSubview:imgView];    
    [propControl addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    
    self.view = propControl;
    
    [propControl release];
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}


- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc. that aren't in use.
}


- (void)viewDidUnload
{
    self.numberFormatter = nil;
    self.source = nil;
    self.property = nil;
    self.buildingType = nil;
    self.address = nil;
    self.postalzip = nil;
    self.country = nil;
    self.units = nil;
    self.size = nil;
    self.settings = nil;
    [super viewDidUnload];
}

#pragma mark - Memory management

- (void)dealloc
{
    [buildingType release];
    [address release];
    [postalzip release];
    [country release];
    [units release];
    [size release];
    [super dealloc];
}


@end
