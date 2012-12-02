//
//  ParameterViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 12-01-14.
//  Copyright (c) 2012 Advis Apps. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ParameterViewController : UIViewController <UITextFieldDelegate>{
    
    UITextField *txt1Ban1;
    UITextField *txt2Ban1;
    UITextField *txt1Ban2;
    UITextField *txt2Ban2;
	UITextField *txt1Ban3;
    UITextField *txt2Ban3;
    
    NSString *fileName;
    UILabel *lblTitle;
    
    CGFloat animatedDistance;
}


@property(nonatomic, retain) UITextField *txt1Ban1;
@property(nonatomic, retain) UITextField *txt2Ban1;
@property(nonatomic, retain) UITextField *txt1Ban2;
@property(nonatomic, retain) UITextField *txt2Ban2;
@property(nonatomic, retain) UITextField *txt1Ban3;
@property(nonatomic, retain) UITextField *txt2Ban3;

@property (nonatomic, retain) UILabel *lblTitle;
@property (nonatomic, retain) NSString *fileName;

- (NSString *)dataFilePath;
- (void)loadSettings;
- (NSString *)floatToRoundedString:(float)fl;
- (IBAction)done;
-(void)showFieldsLabels;
-(id)initWithFilename:(NSString *)filename:(NSString *)heading;


@end
