//
//  CalcViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-02-01.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import "CalcViewController.h"



@implementation CalcViewController
@synthesize managedObjectContext, builder, numberFormatter;
@synthesize propertyAddress;
@synthesize package;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    
    //initialize number formatter and builder
    if (self) {
        
        NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
        [numFormat setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numFormat setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numFormat setMaximumFractionDigits:10];
        [numFormat setMinimumFractionDigits:0];
        
        self.numberFormatter = numFormat; 
        self.builder = [[PropertyBuilder alloc] init];
        
        [numFormat release];

    }
    return self;
}

#pragma mark - AppDelegateProtocol

//Shares common objects
- (AppDataObjects *) dataObjects
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	AppDataObjects *dataObj;
    dataObj = (AppDataObjects *) theDelegate.dataObjects;
	return dataObj;
}


#pragma mark - Custom Methods

-(void)sendPackageToBuilder{
    
    [self.builder createProperty:self.package:self.managedObjectContext];
    [self getAddressFromAlert];
}

//Show calculations and prepare property for saving
-(void)displayResults{
    
}

//Checks for a nil or NaN number 
-(NSDecimalNumber *)nAnToZero:(NSDecimalNumber *)input{
    
    if(input == [NSDecimalNumber notANumber] || input == nil)
        input = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    return input;    
}

//Create labels
-(UILabel *)lblMaker:(NSString *)labelText:(int)posX:(int)posY{
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(posX, posY, 200, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.text = labelText;
    
    return label;
    
}

//Create text fields
-(UITextField *)txtFieldMaker:(int)posX:(int)posY:(UIKeyboardType)kbtype:(NSString *)holder{
    
    
    UITextField *txtField = [[[UITextField alloc] initWithFrame:CGRectMake(posX, posY, 145, 25)] autorelease];
    txtField.borderStyle = UITextBorderStyleRoundedRect;
    [txtField setDelegate:self];
    [txtField setReturnKeyType:UIReturnKeyDone];
    
    [txtField setPlaceholder:holder];
    [txtField setKeyboardType:kbtype];
    
    
    return txtField;
}

//Get builder's property and save the moc 
-(void)save{
    
    NSString *reqSysVer = @"5.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    
    Property *finalProperty = [self.builder property];
    
    //Checks version of iOS
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
    {
        finalProperty.address = self.propertyAddress;
    }
    
    NSError *error = nil;
    
	if (![finalProperty.managedObjectContext save:&error]) {
        
        CommercialRECalculatorAppDelegate *appDelegate = (CommercialRECalculatorAppDelegate *)[[UIApplication sharedApplication] delegate];
        
        [appDelegate showCoreDataError];
        
	}
    
    ListPropertyViewController *listPropertyViewController = [[[ListPropertyViewController alloc] initWithNibName:@"ListPropertyViewController" bundle:nil] autorelease];
    
    listPropertyViewController.managedObjectContext = finalProperty.managedObjectContext;
    
    [self.navigationController pushViewController:listPropertyViewController animated:YES];
}

//Check what version of iOS is installed. If 5.0 or > then prompt alert
- (void)getAddressFromAlert{ 

    NSString *reqSysVer = @"5.0";
    NSString *currSysVer = [[UIDevice currentDevice] systemVersion];
    
    if ([currSysVer compare:reqSysVer options:NSNumericSearch] != NSOrderedAscending)
    {
    
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Save Property Address"
                                                            message:@"Please enter the address of the saved property."
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"OK", nil];
        
        alertView.alertViewStyle = UIAlertViewStylePlainTextInput;
        [alertView show];
        [alertView release];
    }
    else
    {
        [self save];
    }
}

//Dismisses keyboard when view is tapped
- (IBAction)backgroundTap:(id)sender{
    
}

#pragma mark - Data Formatting - Custom Methods 

//Changes a currency format to a decimal number
-(NSDecimalNumber *)currencyStrToDecimalNum:(NSString *)currencystr
{
    
    if(currencystr != nil)
    {
    
        currencystr = [currencystr stringByReplacingOccurrencesOfString:@"$" withString:@""];
        currencystr = [currencystr stringByReplacingOccurrencesOfString:@"," withString:@""];
    }
    else
    {
        currencystr = @"0";
    }
    
    NSDecimalNumber *decimalNum = [NSDecimalNumber decimalNumberWithString:currencystr];
        
    return decimalNum;
}

//Changes a decimal number into a currency string format
-(NSString *)decimalNumToCurrency:(NSDecimalNumber *)decimalNum{
    
    NSString *formattedStr = [self.numberFormatter stringFromNumber:decimalNum];
    
    return formattedStr;
}


#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

-(void)dealloc{
    
    [propertyAddress release];
    [numberFormatter release];
    [builder release];
    [managedObjectContext release];
    [super dealloc];
}

#pragma mark - View lifecycle

- (void)viewDidUnload
{

    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - TextField Delegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    if([textField keyboardType] == UIKeyboardTypeNumberPad)
    {
        
        // Retrieve the old string from the textField to work with.
        NSString *text = [textField text];  
        NSString *decimalSeperator = @",";  
        
        // Define a characterSet to filter all invalid chars.         
        NSCharacterSet *characterSet = nil;
        NSString *numberChars = @"0123456789";
        
        if ([text rangeOfString:decimalSeperator].location != NSNotFound) 
        {
            characterSet = [NSCharacterSet characterSetWithCharactersInString:numberChars];
        }
        else 
        {
            characterSet = [NSCharacterSet characterSetWithCharactersInString:[numberChars stringByAppendingString:decimalSeperator]];
        }
        
        
        NSCharacterSet *invertedCharSet = [characterSet invertedSet];   
        NSString *trimmedString = [string stringByTrimmingCharactersInSet:invertedCharSet];
        text = [text stringByReplacingCharactersInRange:range withString:trimmedString];
        
        // Whenever other chars are entered, calculate the new number and update the textField accordingly.
        if ([text rangeOfString:decimalSeperator].location != NSNotFound) 
            text = [text stringByReplacingOccurrencesOfString:@"," withString:@""];
        
        NSRange dollarRange = [text rangeOfString:@"$"];
        
        // Append dollar sign in front of number on first time
        if(dollarRange.length == 0)
        {
            NSString *dollar = @"$";
            text = [dollar stringByAppendingString:text];
        }
        
        NSNumber *number = [self.numberFormatter numberFromString:text];
        
        if (number == nil) 
            number = [NSNumber numberWithInt:0];
        
        text = [self.numberFormatter stringFromNumber:number];
        [textField setText:text];       
        
        // Return NO because we have manually edited the textField contents.
        return NO; 
    }
    
    return YES;
}

#pragma mark - UIAlertview Delegate

//Gets called after alert view prompt leaves 
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    UITextField *textField = [alertView textFieldAtIndex:0];
    
    //if ok is selected
    if(buttonIndex == 1)
    {
        if(![[textField text] isEqualToString:@""])
           self.propertyAddress = [textField text];
        else
            self.propertyAddress = @"New Property";
        
        [self save];
    }
}

@end
