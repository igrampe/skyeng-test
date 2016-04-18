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

- (void)restartTrainingSessionWithTasksCount:(NSInteger)tasksCount;
- (void)saveTrainingSession;

- (BOOL)isTrainingSessionStarted;
- (void)startTrainingSession;

- (NSInteger)currentTrainingTaskIndex;
- (NSInteger)trainingSessionTotalTasksCount;
- (NSInteger)trainingSessionTaskIdAtIndex:(NSInteger)taskIndex;
- (NSArray *)trainingSessionTasksIds;
- (void)trainingSessionSetAlternativesForTask:(SEWordTaskPonso *)task;
- (NSArray *)trainingSessionAlternativesForTaskAtIndex:(NSInteger)index;
- (NSInteger)trainingSessionCorrectAlternativeIndexForTaskAtIndex:(NSInteger)taskIndex;
- (void)trainingSessionSkipTaskAtIndex:(NSInteger)taskIndex;
- (void)trainingSessionSelectAlternativeAtIndex:(NSInteger)alternativeIndex forTaskAtIndex:(NSInteger)taskIndex;
- (NSInteger)trainingSessionAnswerIndexForTaskAtIndex:(NSInteger)taskIndex;
- (void)trainingSessionNextTask;
- (BOOL)isTrainingSessionFinished;
- (NSUInteger)trainingSessionCorrectAnswersCount;
- (void)trainingSessionReset;

@end
