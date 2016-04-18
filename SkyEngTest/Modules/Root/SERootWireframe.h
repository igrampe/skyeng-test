//
//  SERootWireframe.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SEServiceLocator;

@interface SERootWireframe : NSObject

- (void)presentViewControllerInWindow:(UIWindow *)window withServiceLocator:(SEServiceLocator *)serviceLocator;

@end
