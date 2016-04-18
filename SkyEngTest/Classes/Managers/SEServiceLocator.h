//
//  SEServiceLocator.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SEApiManager;
@class SEDataManager;
@class SEStateManager;

@interface SEServiceLocator : NSObject

@property (nonatomic, strong, readonly) SEApiManager *apiManager;
@property (nonatomic, strong, readonly) SEDataManager *dataManager;
@property (nonatomic, strong, readonly) SEStateManager *stateManager;

- (void)start;

@end
