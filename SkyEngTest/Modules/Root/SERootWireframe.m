//
//  SERootWireframe.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SERootWireframe.h"
#import "SERootViewOutput.h"
#import "SERootViewController.h"

#import "SEServiceLocator.h"
#import "SEStateManager.h"

#import "SETrainingWireframe.h"

@interface SERootWireframe () <SERootViewOutput>

@property (nonatomic, strong) SERootViewController *viewController;
@property (nonatomic, strong) SEServiceLocator *serviceLocator;
@property (nonatomic, strong) SETrainingWireframe *trainingWireframe;

@end

@implementation SERootWireframe

- (void)presentViewControllerInWindow:(UIWindow *)window withServiceLocator:(SEServiceLocator *)serviceLocator
{
    window.backgroundColor = [UIColor whiteColor];
    
    self.viewController = [SERootViewController createVC];
    self.viewController.output = self;
    
    self.serviceLocator = serviceLocator;
    
    [self presentViewController:self.viewController inWindow:window];
}

- (void)presentViewController:(UIViewController *)vc
                     inWindow:(UIWindow *)window
{
    window.rootViewController = vc;
}

#pragma mark - SERootViewOutput

- (void)viewDidLoad
{
    
}

- (void)viewDidAppear
{
    
}

- (void)viewWillAppear
{
    [self _showTraining];
}

#pragma mark - Private

- (void)_showTraining
{
    self.trainingWireframe = [SETrainingWireframe new];
    [self.trainingWireframe presentViewControllerInCtl:self.viewController withServiceLocator:self.serviceLocator];
}

@end
