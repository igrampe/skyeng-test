//
//  SEDataManager.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 15/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

#import <Realm/Realm.h>

@class SEWordTaskPonso;

@interface SEDataManager : NSObject

- (NSArray *)meaningsIdsForRndIndexes:(NSArray *)indexes;
- (NSInteger)totalDictionarySize;
- (SEWordTaskPonso *)taskWithMeaningId:(NSInteger)meaningId;
- (void)addTasks:(NSArray *)tasks;
- (void)clearTasks;

@end
