//
//  SEAppDependency.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEAppDependency.h"

#import <AFNetworkActivityLogger.h>
#import <SVProgressHUD.h>

#import "SEServiceLocator.h"
#import "SERootWireframe.h"
#import "SEColorScheme.h"

@interface SEAppDependency ()

@property (nonatomic, strong) SEServiceLocator *serviceLocator;
@property (nonatomic, strong) SERootWireframe *rootWireframe;

@end

@implementation SEAppDependency

- (void)applicationSetup:(UIApplication *)application launchOptions:(NSDictionary *)options
{
#ifdef API_DEBUG
    [[AFNetworkActivityLogger sharedLogger] setLevel:AFLoggerLevelDebug];
    [[AFNetworkActivityLogger sharedLogger] startLogging];
#endif
    [self _startServiceLocator];
    [SEColorScheme registerColorScheme];
    [self _patchAppearance];
}

- (void)installRootViewControllerIntoWindow:(UIWindow *)window
{
    [self.rootWireframe presentViewControllerInWindow:window withServiceLocator:self.serviceLocator];
}

- (void)_startServiceLocator
{
    [self.serviceLocator start];
}

- (void)_patchAppearance
{
    [SVProgressHUD setDefaultStyle:SVProgressHUDStyleDark];
}

#pragma mark - Lazy

- (SERootWireframe *)rootWireframe
{
    if (!_rootWireframe)
    {
        _rootWireframe = [SERootWireframe new];
    }
    return _rootWireframe;
}

- (SEServiceLocator *)serviceLocator
{
    if (!_serviceLocator)
    {
        _serviceLocator = [SEServiceLocator new];
    }
    return _serviceLocator;
}

@end
