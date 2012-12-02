//
//  AppDelegateProtocol.h
//  CommercialRECalculator
//
//  Created by Freddy Hidalgo-Monchez on 11-09-16.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AppDataObjects;

@protocol AppDelegateProtocol

//Creates an app data object and returns it.
- (AppDataObjects *) dataObjects;

@end
