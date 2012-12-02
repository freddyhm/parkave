//
//  SettingsParameterViewController.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-11-05.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ParameterViewController.h"


@interface SettingsParameterViewController : UIViewController <UITableViewDataSource, UITableViewDelegate> {
    
    NSArray *controllers;
    
    
}

@property (nonatomic, retain) NSArray *controllers;

@end
