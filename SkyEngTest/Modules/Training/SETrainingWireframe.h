//
//  SETrainingWireframe.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "SETrainingViewOutput.h"

@class SEServiceLocator;

@interface SETrainingWireframe : NSObject <SETrainingViewOutput>

- (void)presentViewControllerInCtl:(UIViewController *)inCtl withServiceLocator:(SEServiceLocator *)serviceLocator;

@end
