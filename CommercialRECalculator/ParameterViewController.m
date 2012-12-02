//
//  ParameterViewController.m
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-01-14.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import "ParameterViewController.h"

@implementation ParameterViewController

@synthesize txt1Ban1;
@synthesize txt2Ban1;
@synthesize txt1Ban2;
@synthesize txt2Ban2;
@synthesize txt1Ban3;
@synthesize txt2Ban3;

@synthesize fileName;
@synthesize lblTitle;

// Needed to have the screen scroll up when editing text field 
static const CGFloat KEYBOARD_ANIMATION_DURATION = 0.3;
static const CGFloat MINIMUM_SCROLL_FRACTION = 0.2;
static const CGFloat MAXIMUM_SCROLL_FRACTION = 0.8;
static const CGFloat PORTRAIT_KEYBOARD_HEIGHT = 156;
static const CGFloat LANDSCAPE_KEYBOARD_HEIGHT = 140;

-(id)initWithFilename:(NSString *)filename:(NSString *)heading{
    
    if(self)
    {
        self.title = @"Indicators";
        
        self.lblTitle = [[UILabel alloc] initWithFrame:CGRectMake(1, 10, 310, 50)];
        self.lblTitle.text = heading;
        self.lblTitle.backgroundColor = [UIColor clearColor];
        [self.lblTitle setFont:[UIFont systemFontOfSize:25]];
        self.lblTitle.textAlignment = UITextAlignmentCenter; 
        
        self.fileName = filename;
    }
    
    return self;
}

#pragma mark - Custom Methods

- (NSString *)dataFilePath{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory,
                                                         NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    
    return [documentsDirectory stringByAppendingPathComponent:self.fileName];
}

- (IBAction)done{
    
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    
    NSNumber *numTxt1Ban1 =  [NSNumber numberWithFloat:[[self.txt1Ban1 text] floatValue]];
    NSNumber *numTxt2Ban1 =  [NSNumber numberWithFloat:[[self.txt2Ban1 text] floatValue]];
    NSNumber *numTxt1Ban2 =  [NSNumber numberWithFloat:[[self.txt1Ban2 text] floatValue]];
    NSNumber *numTxt2Ban2 =  [NSNumber numberWithFloat:[[self.txt2Ban2 text] floatValue]];
    NSNumber *numTxt1Ban3 =  [NSNumber numberWithFloat:[[self.txt1Ban3 text] floatValue]];
    NSNumber *numTxt2Ban3 =  [NSNumber numberWithFloat:[[self.txt2Ban3 text] floatValue]];        
    
    [array addObject:numTxt1Ban1];
    [array addObject:numTxt2Ban1];
    [array addObject:numTxt1Ban2];
    [array addObject:numTxt2Ban2];
    [array addObject:numTxt1Ban3];
    [array addObject:numTxt2Ban3];
    
    [array writeToFile:[self dataFilePath] atomically:YES];
    
    [array release];
    
    [self.navigationController popViewControllerAnimated:YES];
     
}



- (void)loadSettings{
    
    NSString *filePath = [self dataFilePath];
    
    if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
        
        NSArray *array = [[NSArray alloc] initWithContentsOfFile:filePath];
        
        
        NSNumber *numTxt1Ban1 =  [array objectAtIndex:0];
        NSNumber *numTxt2Ban1 =  [array objectAtIndex:1];
        NSNumber *numTxt1Ban2 =  [array objectAtIndex:2];
        NSNumber *numTxt2Ban2 =  [array objectAtIndex:3];
        NSNumber *numTxt1Ban3 =  [array objectAtIndex:4];
        NSNumber *numTxt2Ban3 =  [array objectAtIndex:5];
        
        self.txt1Ban1.text = [self floatToRoundedString:[numTxt1Ban1 floatValue]];
        self.txt2Ban1.text = [self floatToRoundedString:[numTxt2Ban1 floatValue]];
        self.txt1Ban2.text = [self floatToRoundedString:[numTxt1Ban2 floatValue]];
        self.txt2Ban2.text = [self floatToRoundedString:[numTxt2Ban2 floatValue]];
        self.txt1Ban3.text = [self floatToRoundedString:[numTxt1Ban3 floatValue]];
        self.txt2Ban3.text = [self floatToRoundedString:[numTxt2Ban3 floatValue]];
        
        
        [array release];
    }
}

-(NSString *)floatToRoundedString:(float)fl{
    
    float progressAsFloat = (float)(fl + 0.0005f);
    progressAsFloat = round((progressAsFloat * 100)) / 100;
    NSString *newText =[[NSString alloc] initWithFormat:@"%g",progressAsFloat];
    
    return newText;
    
}

// Hide keyboard when tapping background while editing
- (void)backgroundTap:(id)sender{
  
    [self.txt1Ban1 resignFirstResponder];
    [self.txt2Ban1 resignFirstResponder];
    
    [self.txt1Ban2 resignFirstResponder];
    [self.txt2Ban2 resignFirstResponder];
    
    [self.txt1Ban3 resignFirstResponder];
    [self.txt2Ban3 resignFirstResponder];
}

-(void)showFieldsLabels{
    
    //arrow down
    UIImage *arrowDown = [UIImage imageNamed:@"arrowdown.png"];
    UIImageView *imgViewAD = [[UIImageView alloc] initWithFrame:CGRectMake(40, 100, 47, 43)];
    [imgViewAD setImage:arrowDown];
    
    
    //min 1
    UILabel *lblmin1 = [[[UILabel alloc] init] initWithFrame:CGRectMake(125, 75, 52, 23)];
    lblmin1.backgroundColor = [UIColor clearColor];
    lblmin1.text = @"min.";
    [self.view addSubview:lblmin1];
    [lblmin1 release];
    
    //txt 1.1
    self.txt1Ban1 = [[[[UITextField alloc] init] initWithFrame:CGRectMake(115, 110, 62, 23)]autorelease];
    [self.txt1Ban1 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.txt1Ban1 setPlaceholder:@"0.0"];
    [self.txt1Ban1 setDelegate:self];
    [self.view addSubview:self.txt1Ban1];
    
    //to 1 
    UILabel *lblto1 = [[[UILabel alloc] init] initWithFrame:CGRectMake(187, 110, 52, 23)];
    lblto1.backgroundColor = [UIColor clearColor];
    lblto1.text = @"to";
    [self.view addSubview:lblto1];
    [lblto1 release];
    
    //txt 2.1
    self.txt2Ban1 = [[[UITextField alloc] init] initWithFrame:CGRectMake(210, 110, 62, 23)];
    [self.txt2Ban1 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.txt2Ban1 setPlaceholder:@"5.0"];
    [self.txt2Ban1 setDelegate:self];
    [self.view addSubview:self.txt2Ban1];
    
    //max 1
    UILabel *lblmax1 = [[[UILabel alloc] init] initWithFrame:CGRectMake(220, 75, 52, 23)];
    lblmax1.backgroundColor = [UIColor clearColor];
    lblmax1.text = @"max.";
    [self.view addSubview:lblmax1];
    [lblmax1 release];

    
    
    //arrow up
    UIImage *arrowMid = [UIImage imageNamed:@"arrow.png"];
    UIImageView *imgViewAM = [[UIImageView alloc] initWithFrame:CGRectMake(40, 175, 47, 43)];
    [imgViewAM setImage:arrowMid];
    
    
    /*
    //min 2 
    UILabel *lblmin2 = [[[UILabel alloc] init] initWithFrame:CGRectMake(65, 175, 52, 23)];
    lblmin2.backgroundColor = [UIColor clearColor];
    lblmin2.text = @"min";
    [self.view addSubview:lblmin2];
    [lblmin2 release];
     */
    
    //txt 1.2
    self.txt1Ban2 = [[[UITextField alloc] init] initWithFrame:CGRectMake(115, 185, 62, 23)];
    [self.txt1Ban2 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.txt1Ban2 setPlaceholder:@" 0.0"];
    [self.txt1Ban2 setDelegate:self];
    [self.view addSubview:self.txt1Ban2];
    
    //to 2
    UILabel *lblto2 = [[[UILabel alloc] init] initWithFrame:CGRectMake(187, 185, 52, 23)];
    lblto2.backgroundColor = [UIColor clearColor];
    lblto2.text = @"to";
    [self.view addSubview:lblto2];
    [lblto2 release];
    
    //txt 2.2
    self.txt2Ban2 = [[[UITextField alloc] init] initWithFrame:CGRectMake(210, 185, 62, 23)];
    [self.txt2Ban2 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.txt2Ban2 setPlaceholder:@" 5 .0"];
    [self.txt2Ban2 setDelegate:self];
    [self.view addSubview:self.txt2Ban2];
    
    /*
    //max 2
    UILabel *lblmax2 = [[[UILabel alloc] init] initWithFrame:CGRectMake(270, 175, 52, 23)];
    lblmax2.backgroundColor = [UIColor clearColor];
    lblmax2.text = @"max.";
    [self.view addSubview:lblmax2];
    [lblmax2 release];
*/

    
    
    UIImage *arrowUp = [UIImage imageNamed:@"arrowup.png"];
    UIImageView *imgViewAU = [[UIImageView alloc] initWithFrame:CGRectMake(40, 250, 47, 43)];
    [imgViewAU setImage:arrowUp];
    
    
    /*
    //min 3
    UILabel *lblmin3 = [[[UILabel alloc] init] initWithFrame:CGRectMake(65, 260, 52, 23)];
    lblmin3.backgroundColor = [UIColor clearColor];
    lblmin3.text = @"min.";
    [self.view addSubview:lblmin3];
    [lblmin3 release];
     */
    
    //txt 1.3
    self.txt1Ban3 = [[[UITextField alloc] init] initWithFrame:CGRectMake(115, 260, 62, 23)];
    [self.txt1Ban3 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.txt1Ban3 setPlaceholder:@"0.0"];
    [self.txt1Ban3 setDelegate:self];
    [self.view addSubview:self.txt1Ban3];
    
    //to 3
    UILabel *lblto3 = [[[UILabel alloc] init] initWithFrame:CGRectMake(187, 260, 52, 23)];
    lblto3.backgroundColor = [UIColor clearColor];
    lblto3.text = @"to";
    [self.view addSubview:lblto3];
    [lblto3 release];
    
    //txt 2.3
    self.txt2Ban3 = [[[UITextField alloc] init] initWithFrame:CGRectMake(210, 260, 62, 23)];
    [self.txt2Ban3 setBorderStyle:UITextBorderStyleRoundedRect];
    [self.txt2Ban3 setPlaceholder:@"5.0"];
    [self.txt2Ban3 setDelegate:self];
    [self.view addSubview:self.txt2Ban3];
    
    /*
    //max 3
    UILabel *lblmax3 = [[[UILabel alloc] init] initWithFrame:CGRectMake(270, 260, 52, 23)];
    lblmax3.backgroundColor = [UIColor clearColor];
    lblmax3.text = @"max.";
    [self.view addSubview:lblmax3];
    [lblmax3 release];

    */
    
    
    UIImage *applyImg = [UIImage imageNamed:@"applybutton.png"];
    UIButton *btnApply = [[UIButton alloc] initWithFrame:CGRectMake(100, 320, 115, 57)];
    [btnApply setBackgroundImage:applyImg forState:UIControlStateNormal];
    [btnApply addTarget:self action:@selector(done) forControlEvents:UIControlEventTouchDown];
    
    [self.view addSubview:imgViewAD];
    [arrowDown release];
    
    [self.view addSubview:imgViewAM];
    [arrowMid release];
       
    [self.view addSubview:imgViewAU];
    [arrowUp release];
  
    [self.view addSubview:btnApply];
    [btnApply release];
}



#pragma mark - Memory Management

- (void)didReceiveMemoryWarning
{
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)dealloc{
    
    [fileName release];
    
    [txt1Ban1 release];
    [txt1Ban2 release];
    [txt1Ban2 release];
    [txt2Ban2 release];
    [txt1Ban3 release];
    [txt2Ban3 release];
    [super dealloc];
}

- (void)viewDidUnload
{    
    self.txt1Ban1 = nil;
    self.txt1Ban2 = nil;
    self.txt2Ban1 = nil;
    self.txt2Ban2 = nil;
    self.txt1Ban3 = nil;
    self.txt2Ban3 = nil;
    [super viewDidUnload];
}

#pragma mark - View lifecycle

-(void)viewDidLoad{
    
    UIControl *customView = [[UIControl alloc] initWithFrame:CGRectMake(0, 0, 320, 416)];
    UIImage *bckgdimg = [UIImage imageNamed:@"PLAINBG.png"];
    UIImageView *imgView = [[UIImageView alloc] initWithImage:bckgdimg];
    [customView addSubview:imgView];    
    [customView addTarget:self action:@selector(backgroundTap:) forControlEvents:UIControlEventTouchDown];
    
    self.view = customView;
    
    if(self.lblTitle)
    {
        [self.view addSubview:self.lblTitle];
    }
    
    [customView release];
    [self showFieldsLabels];
    [self loadSettings];
    [super viewDidLoad];
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
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
	CGFloat midline = textFieldRect.origin.y + 3.0 * textFieldRect.size.height;
    
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




@end
