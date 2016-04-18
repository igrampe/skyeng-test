//
//  SEAppDependency.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SEAppDependency : NSObject

- (void)applicationSetup:(UIApplication *)application launchOptions:(NSDictionary *)options;
- (void)installRootViewControllerIntoWindow:(UIWindow *)window;

@end
