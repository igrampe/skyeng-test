//
//  SERootViewController.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SERootViewController.h"

@interface SERootViewController ()

@end

@implementation SERootViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor blackColor];
    [self.output viewDidLoad];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

@end
