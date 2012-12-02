//
//  TabBarViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-01-14.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import "TabBarViewController.h"
#import "CommercialRECalculatorAppDelegate.h"

@implementation TabBarViewController

@synthesize source;
@synthesize property;
@synthesize settings;
@synthesize numberFormatter;
@synthesize editedTxtFieldDict;


// Needed to have the screen scroll up when editing text field 
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 156;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
                
        NSNumberFormatter *numFormat = [[NSNumberFormatter alloc] init];
        [numFormat setFormatterBehavior:NSNumberFormatterBehavior10_4];
        [numFormat setNumberStyle:NSNumberFormatterCurrencyStyle];
        [numFormat setMaximumFractionDigits:10];
        [numFormat setMinimumFractionDigits:0];

        self.numberFormatter = numFormat; 
        
        [numFormat release];
        
                
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        
        self.editedTxtFieldDict = dict;
        
        [dict release];
        
        
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - AppDelegateProtocol
//must include this for each controller that will need shared objects
//return data object
- (AppDataObjects *) dataObjects
{
	id<AppDelegateProtocol> theDelegate = (id<AppDelegateProtocol>) [UIApplication sharedApplication].delegate;
	AppDataObjects *dataObj;
    dataObj = (AppDataObjects *) theDelegate.dataObjects;
	return dataObj;
}

#pragma mark - Custom Methods


- (NSString *)dataFilePath:(NSString *)filename{
    
    return @"";
    
}

-(NSString *)nilToStr:(NSString *)input
{
    if(input == nil)
        input = @"0";
    
    return input;
}

-(NSString *)nAnToZero:(NSDecimalNumber *)input{
    
    if(input == [NSDecimalNumber notANumber])
        input = [NSDecimalNumber decimalNumberWithString:@"0"];
    
    NSString *formattedStr = [self.numberFormatter stringFromNumber:input];
    
    return formattedStr;
}

-(void)showFieldsLabels:(BOOL)propExist{
    

}


- (IBAction)backgroundTap:(id)sender{
}


- (void)loadSettings:(NSString *)filePath{
    
    NSArray *array;
    
    if(self.property.moduleList != nil)
        array = [self.property.moduleList componentsSeparatedByString:@","];
    else if([[NSFileManager defaultManager] fileExistsAtPath:filePath])        
        array = [[NSArray alloc] initWithContentsOfFile:filePath];
    
    self.settings = array;
    [array release];
    
}

-(UILabel *)lblMaker:(NSString *)labelText:(int)posX:(int)posY{
    
    UILabel *label = [[[UILabel alloc] initWithFrame:CGRectMake(posX, posY, 200, 20)] autorelease];
    label.backgroundColor = [UIColor clearColor];
    label.text = labelText;
    
    return label;
    
}

-(UITextField *)txtFieldMaker:(int)posX:(int)posY:(UIKeyboardType)kbtype:(NSString *)holder{

    
    UITextField *txtField = [[[UITextField alloc] initWithFrame:CGRectMake(posX, posY, 145, 25)] autorelease];
    txtField.borderStyle = UITextBorderStyleRoundedRect;
    [txtField setDelegate:self];
    [txtField setReturnKeyType:UIReturnKeyDone];
    
    [txtField setPlaceholder:holder];
    [txtField setKeyboardType:kbtype];


    return txtField;
}


-(void)delete{
    
    NSError *error;
    
    
    [self.property.managedObjectContext deleteObject:self.property];
    
    
    if(![self.property.managedObjectContext save:&error])
    {
        CommercialRECalculatorAppDelegate *appDelegate = (CommercialRECalculatorAppDelegate *)[[UIApplication sharedApplication] delegate];
        [appDelegate showCoreDataError];
    }
    
    CommercialRECalculatorAppDelegate *del = (CommercialRECalculatorAppDelegate *)[UIApplication sharedApplication].delegate;
    
    [del.navigationController popViewControllerAnimated:YES];
}


#pragma mark - View lifecycle


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Memory Management

- (void)viewDidUnload
{
    [super viewDidUnload];
}

-(void)dealloc{
    
    [source release];
    [settings release];
    [property release];
    [numberFormatter release];
    [editedTxtFieldDict release];
    [super dealloc];
}

#pragma mark - Text Field Delegates



// Resigns the keyboard when the return/done btn is pressed
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

// Scrolls screen when editing text field
- (void)textFieldDidBeginEditing:(UITextField *)textField{
    
    //converts textfield into CGRect object
    CGRect textFieldRect = [self.view.window convertRect:textField.bounds fromView:textField];
    //converts the current view to CGRect object
	CGRect viewRect = [self.view.window convertRect:self.view.bounds fromView:self.view];
    //Gets the halfway point of the textfield
	CGFloat midline = textFieldRect.origin.y + 0.5 * textFieldRect.size.height;
    
	CGFloat numerator = midline - viewRect.origin.y - MINIMUM_SCROLL_FRACTION * viewRect.size.height;
	CGFloat denominator = (MAXIMUM_SCROLL_FRACTION - MINIMUM_SCROLL_FRACTION) * viewRect.size.height;
	CGFloat heightFraction = numerator / denominator;
    
	if (heightFraction < 0.0)
		heightFraction = 0.0;
	else if (heightFraction > 1.0)
		heightFraction = 1.0;
    
	UIInterfaceOrientation orientation =
	[[UIApplication sharedApplication] statusBarOrientation];
    
	if (orientation == UIInterfaceOrientationPortrait ||
		orientation == UIInterfaceOrientationPortraitUpsideDown)
		animatedDistance = floor(PORTRAIT_KEYBOARD_HEIGHT * heightFraction);
	else
		animatedDistance = floor(LANDSCAPE_KEYBOARD_HEIGHT * heightFraction);
    
	CGRect viewFrame = self.view.frame;
	viewFrame.origin.y -= animatedDistance;
	[UIView beginAnimations:nil context:NULL];
	[UIView setAnimationBeginsFromCurrentState:YES];
	[UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
	[self.view setFrame:viewFrame];
	[UIView commitAnimations];
    
    if([editedTxtFieldDict objectForKey:[textField placeholder]] != textField)
        [editedTxtFieldDict setObject:textField forKey:[textField placeholder]];
}

// Scrolls screen when finished editing
- (void)textFieldDidEndEditing:(UITextField *)textField {
    
    CGRect viewFrame = self.view.frame;
    viewFrame.origin.y += animatedDistance;
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationBeginsFromCurrentState:YES];
    [UIView setAnimationDuration:KEYBOARD_ANIMATION_DURATION];
    [self.view setFrame:viewFrame];
    [UIView commitAnimations];
    
}


- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    
    
      if([textField keyboardType] == UIKeyboardTypeNumberPad)
      {
      
          // Retrieve the old string from the textField to work with.
          NSString *text = [textField text];  
          NSString *decimalSeperator = @",";  

          // Appropriate decimalSeperator for the current localisation can be found with help of the
          // NSNumberFormatter and NSLocale classes.
          
          // Define a characterSet to filter all invalid chars. 
          // Entered string will be trimmed down to the valid chars only.

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

@end
