//
//  PropertyAgentViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-01-18.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import "PropertyAgentViewController.h"

@implementation PropertyAgentViewController

@synthesize viewControllers, source, deleteBtn;
@synthesize tabBar, selectedViewController;
@synthesize propertyTabBarItem, revenueTabBarItem;
@synthesize expenseTabBarItem, mortgageTabBarItem, reportTabBarItem;
@synthesize propViewController, revViewController, expViewController, mtgViewController, repViewController;
@synthesize property, contractor;
@synthesize delegate, managedObjectContext;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil contractor:(PropertyContractor *)contractorIn 
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        
        self.contractor = contractorIn;
    }
    return self;
}

#pragma mark - Delegated Actions - Custom Methods 


-(void)buildProperty{
    
    NSMutableDictionary *packagedViews = [self packageRawViews];
    
    [self.contractor setBuildPackage:packagedViews:self.managedObjectContext];
    
    if([delegate respondsToSelector:@selector(saveProperty)])
    {
        [delegate saveProperty];
    }
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(NSMutableDictionary *)packageRawViews{
    
    NSMutableDictionary *packagedDict = [[[NSMutableDictionary alloc] init] autorelease];
    
    [packagedDict setValue:self.propViewController.address.text forKey:@"address"];
    [packagedDict setValue:self.propViewController.buildingType.text forKey:@"buildingType"];
    [packagedDict setValue:self.propViewController.postalzip.text forKey:@"postalzip"];
    [packagedDict setValue:self.propViewController.country.text forKey:@"country"];
    [packagedDict setValue:self.propViewController.units.text forKey:@"units"];
    [packagedDict setValue:self.propViewController.size.text forKey:@"size"];
    [packagedDict setValue:[self currencyStrToDecimalNum:self.propViewController.purchasePrice.text] forKey:@"purchasePrice"];
    [packagedDict setValue:[self currencyStrToDecimalNum:self.propViewController.downPayment.text] forKey:@"downPayment"];
    
    [packagedDict setValue:[self currencyStrToDecimalNum:self.revViewController.txtRent.text] forKey:@"rentAmount"];
    
    [packagedDict setValue:[self currencyStrToDecimalNum:self.expViewController.txtAdmin.text] forKey:@"admin"];
    [packagedDict setValue:[self currencyStrToDecimalNum:self.expViewController.txtElecHeat.text] forKey:@"elecHeat"];
    [packagedDict setValue:[self currencyStrToDecimalNum:self.expViewController.txtInsurance.text] forKey:@"insurance"];
    [packagedDict setValue:[self currencyStrToDecimalNum:self.expViewController.txtMnR.text] forKey:@"mNr"];
    [packagedDict setValue:[self currencyStrToDecimalNum:self.expViewController.txtMunTax.text] forKey:@"munTax"];
    [packagedDict setValue:[self currencyStrToDecimalNum:self.expViewController.txtStructRes.text] forKey:@"structRes"];
    
    [packagedDict setValue:[self currencyStrToDecimalNum:self.mtgViewController.txtAmort.text] forKey:@"amort"];
    [packagedDict setValue:[self currencyStrToDecimalNum:self.mtgViewController.txtMtgSize.text] forKey:@"mtg"];
    [packagedDict setValue:[self currencyStrToDecimalNum:self.mtgViewController.txtRate.text] forKey:@"rate"];
    [packagedDict setValue:[self currencyStrToDecimalNum:self.mtgViewController.txtTerm.text] forKey:@"term"];
    
    return packagedDict;
}

-(void)updateProperty{
    
    NSMutableDictionary *updatedFormattedPckg = [self getFormattedTxtFields]; 
    NSMutableDictionary *updatedRawPckg = [self packageRawViews];
    
    [self.contractor setPropertyUpdatePackage:updatedFormattedPckg:self.property];
    [self.contractor setReportUpdatePackage:updatedRawPckg:self.property];
    
    if([delegate respondsToSelector:@selector(saveProperty:)])
    {
        [delegate saveProperty];
    }

    [self.navigationController popViewControllerAnimated:YES];
}

-(void)deleteProperty{

    if([delegate respondsToSelector:@selector(deleteProperty:)])
    {
        [delegate deleteProperty:self.property];
    }
    
    [self.navigationController popViewControllerAnimated:YES];

}

-(void)confirmDelete{
    
    UIActionSheet *actionSheet = [[UIActionSheet alloc] initWithTitle:@"Delete Property?"
															 delegate:self
													cancelButtonTitle:@"Cancel"
											   destructiveButtonTitle:@"OK"
													otherButtonTitles:nil];
	[actionSheet showInView:self.view];
	[actionSheet autorelease];
}

-(void)showProperty:(Property *)propertyIn{
    
    self.property = propertyIn;
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(updateProperty)];
    
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    [saveBtn release];
    
    self.deleteBtn = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [self.deleteBtn addTarget:self action:@selector(confirmDelete) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteBtn setFrame:CGRectMake(95, 330, 130, 28)];
    [self.deleteBtn setTitle:@"Delete" forState:UIControlStateNormal];
    
    [self.deleteBtn setBackgroundImage:[[UIImage imageNamed:@"iphone_delete_button.png"]
                                        stretchableImageWithLeftCapWidth:8.0f
                                        topCapHeight:0.0f]
                              forState:UIControlStateNormal];
    
    [self.deleteBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    self.deleteBtn.titleLabel.font = [UIFont boldSystemFontOfSize:15];
    self.deleteBtn.titleLabel.shadowColor = [UIColor lightGrayColor];
    self.deleteBtn.titleLabel.shadowOffset = CGSizeMake(0, -1);
    
    [self.propViewController.view addSubview:self.deleteBtn];
    
    [self.propViewController loadValues:self.property];
    [self.revViewController loadValues:self.property];
    [self.expViewController loadValues:self.property];
    [self.mtgViewController loadValues:self.property];
}

-(void)addProperty:(NSManagedObjectContext *)context{
    
    self.managedObjectContext = context;
    
    UIBarButtonItem *saveBtn = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(buildProperty)];
    
    self.navigationItem.rightBarButtonItem = saveBtn;
    
    [saveBtn release];
    
    UIBarButtonItem *cancelBtnItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel target:self action:@selector(cancel)];
    self.navigationItem.leftBarButtonItem = cancelBtnItem;
    
    [cancelBtnItem release];
    
    
}


-(NSMutableDictionary *)getFormattedTxtFields{
    
    NSMutableDictionary *changesProp = [[NSMutableDictionary alloc] initWithDictionary:self.propViewController.editedTxtFieldDict];
    
    NSMutableDictionary *changesRev = [[NSMutableDictionary alloc] initWithDictionary:self.revViewController.editedTxtFieldDict];
    
    NSMutableDictionary *changesExp = [[NSMutableDictionary alloc] initWithDictionary:self.expViewController.editedTxtFieldDict];
    
    NSMutableDictionary *changesMtg = [[NSMutableDictionary alloc] initWithDictionary:self.mtgViewController.editedTxtFieldDict]; 
    
    NSMutableDictionary *changesViews = [[NSMutableDictionary alloc] initWithObjectsAndKeys:changesProp,@"property",changesRev,@"revenue",changesExp,@"expense",changesMtg,@"mortgage", nil];
    
    NSMutableDictionary *changesPropFormatted = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *changesRevFormatted = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *changesExpFormatted = [[NSMutableDictionary alloc] init];
    NSMutableDictionary *changesMtgFormatted = [[NSMutableDictionary alloc] init];
    
    NSMutableDictionary *changesViewsFormatted = [[NSMutableDictionary alloc] initWithObjectsAndKeys:changesPropFormatted,@"property",changesRevFormatted,@"revenue",changesExpFormatted,@"expense",changesMtgFormatted,@"mortgage", nil];
    
    
    UITextField *txtField;
    
    for(id key in changesViews)
    {
        for(id k in [changesViews objectForKey:key])
        {
            NSDictionary *currentView = [changesViewsFormatted objectForKey:key];
            
            txtField = [[changesViews objectForKey:key] objectForKey:k];
            UITextField *cleanTxtField = [[UITextField alloc] init];
            
            if([txtField keyboardType] == UIKeyboardTypeNumberPad)
            {
                cleanTxtField.text = [txtField text];
                NSDecimalNumber *num = [self currencyStrToDecimalNum:[cleanTxtField text]];
                
                cleanTxtField.text = [num stringValue]; 
            }
            else
            {
                cleanTxtField = txtField;
            }
            
            [currentView setValue:cleanTxtField forKey:k];
            
            [cleanTxtField release];
        }
    }
    
    [changesPropFormatted release];
    [changesRevFormatted release];
    [changesExpFormatted release];
    [changesMtgFormatted release];
    
    [changesProp release];
    [changesRev release];
    [changesExp release];
    [changesMtg release];
    
    return changesViewsFormatted;
}

-(void)displayReport:(Property *)propertyIn{
    
    [self.deleteBtn removeFromSuperview];
    
    self.property = propertyIn;
    
    NSMutableDictionary *changedFields = [self getFormattedTxtFields];
    NSMutableDictionary *allFields = [self packageRawViews];
    
    ReportData *rep = [self.contractor showReport:changedFields:allFields:self.property];
    
    ReportTabViewController *repTabViewController = [[ReportTabViewController alloc] init];
                                                     
    self.repViewController = repTabViewController;
                                                     
    [self.repViewController showFieldsLabels];
    [self.repViewController loadValues:rep];
    
    [repTabViewController release];
}

-(void)resetEditedTxtFields{
    
    self.propViewController.editedTxtFieldDict = [[[NSMutableDictionary alloc] init] autorelease];
    self.expViewController.editedTxtFieldDict = [[[NSMutableDictionary alloc] init] autorelease];
    self.revViewController.editedTxtFieldDict = [[[NSMutableDictionary alloc] init] autorelease];
    self.mtgViewController.editedTxtFieldDict = [[[NSMutableDictionary alloc] init] autorelease];
}


#pragma mark - Data Formatting - Custom Methods 

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

    currencystr = [currencystr stringByReplacingOccurrencesOfString:@"$" withString:@""];
    currencystr = [currencystr stringByReplacingOccurrencesOfString:@"," withString:@""];
    
    return [NSDecimalNumber decimalNumberWithString:currencystr];
}

-(NSString *)decimalNumToCurrency:(NSDecimalNumber *)decimalNum{
    
    NSNumberFormatter *numberFormatter = [[[NSNumberFormatter alloc] init] autorelease]; 
    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setMaximumFractionDigits:10];
    [numberFormatter setMinimumFractionDigits:0];



    [numberFormatter setFormatterBehavior:NSNumberFormatterBehavior10_4];
    [numberFormatter setNumberStyle:NSNumberFormatterCurrencyStyle];
    [numberFormatter setMaximumFractionDigits:10];
    [numberFormatter setMinimumFractionDigits:0];

    NSNumber *number = [[[NSNumber alloc] initWithInt:[decimalNum intValue]] autorelease];  

    NSString *formattedStr = [numberFormatter stringFromNumber:number];
      
    return formattedStr;
    
}



#pragma mark - Standard Methods  - Custom Methods

-(void)cancel{
    
    [self.navigationController popViewControllerAnimated:YES];
}


#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc {
    
    [source release];
    [propViewController release];
    [revViewController release];
    [expViewController release];
    [mtgViewController release];
    [repViewController release];
    
    [property release];
    
	[tabBar release];
	[propertyTabBarItem release];
    [revenueTabBarItem release];
    [expenseTabBarItem release];
    [mortgageTabBarItem release];
    [reportTabBarItem release];
	[viewControllers release];
	[selectedViewController release];
    
    [super dealloc];
}

#pragma mark - View lifecycle

// Implement viewDidLoad to do additional setup after loading the view, typically from a nib.
- (void)viewWillAppear:(BOOL)animated
{
    PropertyTabViewController *prop = [[PropertyTabViewController alloc] init];    
    RevenueTabViewController *rev = [[RevenueTabViewController alloc] init];
    ExpenseTabViewController *exp = [[ExpenseTabViewController alloc] init];
    MortgageTabViewController *mtg = [[MortgageTabViewController alloc] init];
    ReportTabViewController *rep = [[ReportTabViewController alloc] init];
    
    self.propViewController = prop;
    self.revViewController = rev;
    self.expViewController = exp;
    self.mtgViewController = mtg;
    self.repViewController = rep;
    
    [self.propViewController showFieldsLabels];
    [self.revViewController showFieldsLabels];
    [self.expViewController showFieldsLabels];
    [self.mtgViewController showFieldsLabels];

    [self.view insertSubview:self.propViewController.view atIndex:0];
    
    self.selectedViewController = self.propViewController;
    self.tabBar.selectedItem = self.propertyTabBarItem;
    
    
    NSArray *array = [[NSArray alloc] initWithObjects:self.propViewController,self.revViewController, self.expViewController,self.mtgViewController,self.repViewController,nil];
    
    self.viewControllers = array;
    
    [array release];
    
    [prop release];
    [rev  release];
    [exp release];
    [mtg release];
    [rep release];

    [super viewDidLoad];
}

-(void)viewDidDisappear:(BOOL)animated{
    
    if(self.deleteBtn)
    {
        [self.deleteBtn removeFromSuperview];
        self.deleteBtn = nil;
    }
    
    self.property = nil;
    [self.selectedViewController.view removeFromSuperview];
    
}

- (void)viewDidUnload{
    
    self.deleteBtn = nil;
    self.source = nil;
    self.propViewController = nil;
    self.revViewController = nil;
    self.expViewController = nil;
    self.mtgViewController = nil;
    self.repViewController = nil;
    
    self.property = nil;
    
    self.tabBar = nil;
    self.propertyTabBarItem = nil;
    self.revenueTabBarItem = nil;
    self.expenseTabBarItem = nil;
    self.mortgageTabBarItem = nil;
    self.reportTabBarItem = nil;
    
    self.viewControllers = nil;
    self.selectedViewController = nil;
    
    [super viewDidUnload];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Tab Bar Delegate

- (void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item
{
    
	if (item == self.propertyTabBarItem) {
        
        self.propViewController = [self.viewControllers objectAtIndex:0];
		[self.selectedViewController.view removeFromSuperview];
        
        if(self.deleteBtn)
            [self.propViewController.view addSubview:self.deleteBtn];
        
		[self.view insertSubview:self.propViewController.view atIndex:0];
		self.selectedViewController = self.propViewController;
        
	} else if (item == self.revenueTabBarItem ) {
        
        self.revViewController = [self.viewControllers objectAtIndex:1];
        [self.selectedViewController.view removeFromSuperview];
        [self.view insertSubview:self.revViewController.view atIndex:0];
        self.selectedViewController = self.revViewController;
		
        
	} else if (item == self.expenseTabBarItem ) {
        
        self.expViewController = [self.viewControllers objectAtIndex:2];
		[self.selectedViewController.view removeFromSuperview];
		[self.view insertSubview:self.expViewController.view atIndex:0];
		self.selectedViewController = self.expViewController;
        
    } else if (item == self.mortgageTabBarItem) {
		
        self.mtgViewController = [self.viewControllers objectAtIndex:3];
		[self.selectedViewController.view removeFromSuperview];
		[self.view insertSubview:self.mtgViewController.view atIndex:0];
		self.selectedViewController = self.mtgViewController;
        
    } else if (item == self.reportTabBarItem) {
    
        self.repViewController = [self.viewControllers objectAtIndex:4];
		[self.selectedViewController.view removeFromSuperview];
        [self displayReport:self.property];
		[self.view insertSubview:self.repViewController.view atIndex:0];
        self.selectedViewController = self.repViewController;
        
	}
    
}

#pragma mark - UIActionSheet Delegate

- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
	// the user clicked one of the OK/Cancel buttons
	if (buttonIndex == [actionSheet destructiveButtonIndex])
	{
		[self deleteProperty];
        
	}
	else if (buttonIndex == [actionSheet cancelButtonIndex])
	{
        
        
	}
}



@end
