//
//  SEStateManager.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEStateManager.h"
#import "SETrainingSession.h"
#import "SEServiceLocator.h"
#import "SEDataManager.h"

@interface SEStateManager ()

@property (nonatomic, strong, readwrite) SETrainingSession *trainingSession;

@end

@implementation SEStateManager

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.trainingSession = [SETrainingSession new];
    }
    return self;
}

#pragma mark - Training Session

#pragma mark -- Actions

- (void)trainingSessionGenerateWithTasksCount:(NSInteger)tasksCount
{
    NSInteger totalCount = [self.serviceLocator.dataManager totalDictionarySize];
    NSArray *rndIndexes = [self.trainingSession generateSequenceWithTasksCount:tasksCount totalCount:totalCount];
    NSArray *ids = [self.serviceLocator.dataManager meaningsIdsForRndIndexes:rndIndexes];
    NSAssert(ids.count == rndIndexes.count, NSLS(@"Неверное количество идентификаторов слов"));
    self.trainingSession.tasksIds = ids;
}

- (void)trainingSessionStart
{
    [self.trainingSession start];
}

- (void)trainingSessionSetAlternativesForTask:(SEWordTaskPonso *)task
{
    [self.trainingSession setAlternativesForTask:task];
}

- (void)trainingSessionSkipTaskAtIndex:(NSInteger)taskIndex
{
    [self.trainingSession skipTaskAtIndex:taskIndex];
}

- (void)trainingSessionSelectAlternativeAtIndex:(NSInteger)alternativeIndex forTaskAtIndex:(NSInteger)taskIndex
{
    [self.trainingSession selectAlternativeAtIndex:alternativeIndex forTaskAtIndex:taskIndex];
}

- (void)trainingSessionNextTask
{
    self.trainingSession.currentTaskIndex++;
}

- (void)trainingSessionReset
{
    [self.trainingSession reset];
}

#pragma mark -- Getters

- (BOOL)trainingSessionIsStarted
{
    return (self.trainingSession.currentTaskIndex >= 0);
}

- (BOOL)trainingSessionIsFinished
{
    return (self.trainingSession.currentTaskIndex == self.trainingSession.totalTasksCount);
}

- (NSInteger)trainingSessionCurrentTaskIndex
{
    return self.trainingSession.currentTaskIndex;
}

- (NSInteger)trainingSessionTotalTasksCount
{
    return self.trainingSession.totalTasksCount;
}

- (NSInteger)trainingSessionTaskIdAtIndex:(NSInteger)taskIndex
{
    return [self.trainingSession taskIdAtIndex:taskIndex];
}

- (NSArray *)trainingSessionTasksIds
{
    return [self.trainingSession tasksIds];
}

- (NSArray *)trainingSessionAlternativesForTaskAtIndex:(NSInteger)index
{
    return [self.trainingSession alternativesForTaskAtIndex:index];
}

- (NSInteger)trainingSessionCorrectAlternativeIndexForTaskAtIndex:(NSInteger)taskIndex
{
    return [self.trainingSession correctAnswerIndexForTaskAtIndex:taskIndex];
}

- (NSInteger)trainingSessionAnswerIndexForTaskAtIndex:(NSInteger)taskIndex
{
    return [self.trainingSession answerIndexForTaskAtIndex:taskIndex];
}

- (NSUInteger)trainingSessionCorrectAnswersCount
{
    return [self.trainingSession correctAnswersCount];
}

@end
