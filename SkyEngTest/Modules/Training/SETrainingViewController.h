//
//  SETrainingViewController.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UIViewController+APL.h"
#import "SETrainingViewInput.h"
#import "SETrainingViewOutput.h"

@interface SETrainingViewController : UIViewController <SETrainingViewInput>

@property (nonatomic, weak) id<SETrainingViewOutput> output;

@end
