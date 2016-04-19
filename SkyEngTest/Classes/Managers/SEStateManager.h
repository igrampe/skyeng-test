//
//  SEStateManager.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SEServiceLocator;
@class SEWordTaskPonso;

@interface SEStateManager : NSObject

@property (nonatomic, weak) SEServiceLocator *serviceLocator;

#pragma mark - Training Session

#pragma mark -- Actions

- (void)trainingSessionGenerateWithTasksCount:(NSInteger)tasksCount;
- (void)trainingSessionStart;
- (void)trainingSessionSetAlternativesForTask:(SEWordTaskPonso *)task;
- (void)trainingSessionSkipTaskAtIndex:(NSInteger)taskIndex;
- (void)trainingSessionSelectAlternativeAtIndex:(NSInteger)alternativeIndex forTaskAtIndex:(NSInteger)taskIndex;
- (void)trainingSessionNextTask;
- (void)trainingSessionReset;

#pragma mark -- Getters

- (BOOL)trainingSessionIsStarted;
- (BOOL)trainingSessionIsFinished;

- (NSInteger)trainingSessionCurrentTaskIndex;
- (NSInteger)trainingSessionTotalTasksCount;
- (NSInteger)trainingSessionTaskIdAtIndex:(NSInteger)taskIndex;
- (NSArray *)trainingSessionTasksIds;

- (NSArray *)trainingSessionAlternativesForTaskAtIndex:(NSInteger)index;
- (NSInteger)trainingSessionCorrectAlternativeIndexForTaskAtIndex:(NSInteger)taskIndex;

- (NSInteger)trainingSessionAnswerIndexForTaskAtIndex:(NSInteger)taskIndex;
- (NSUInteger)trainingSessionCorrectAnswersCount;

@end
