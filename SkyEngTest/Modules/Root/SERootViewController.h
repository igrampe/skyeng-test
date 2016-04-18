//
//  SERootViewController.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+APL.h"

#import "SERootViewInput.h"
#import "SERootViewOutput.h"

@interface SERootViewController : UIViewController <SERootViewInput>

@property (nonatomic, weak) id<SERootViewOutput> output;

@end
