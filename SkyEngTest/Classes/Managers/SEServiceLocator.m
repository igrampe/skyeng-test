//
//  SEServiceLocator.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEServiceLocator.h"

#import "SEApiManager.h"
#import "SEDataManager.h"
#import "SEStateManager.h"

@interface SEServiceLocator ()

@property (nonatomic, strong, readwrite) SEApiManager *apiManager;
@property (nonatomic, strong, readwrite) SEDataManager *dataManager;
@property (nonatomic, strong, readwrite) SEStateManager *stateManager;

@end

@implementation SEServiceLocator

#pragma mark - Public

- (void)start
{
    [self.dataManager isProxy];
}

#pragma mark - Lazy

- (SEApiManager *)apiManager
{
    if (!_apiManager)
    {
        _apiManager = [SEApiManager new];
    }
    return _apiManager;
}

- (SEDataManager *)dataManager
{
    if (!_dataManager)
    {
        _dataManager = [SEDataManager new];
    }
    return _dataManager;
}

- (SEStateManager *)stateManager
{
    if (!_stateManager)
    {
        _stateManager = [SEStateManager new];
        _stateManager.serviceLocator = self;
    }
    return _stateManager;
}


@end
