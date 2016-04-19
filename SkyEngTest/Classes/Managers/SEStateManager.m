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

- (void)start
{
    
}

#pragma mark - Public

- (void)restartTrainingSessionWithTasksCount:(NSInteger)tasksCount
{
    NSInteger totalCount = [self.serviceLocator.dataManager totalDictionarySize];
    NSArray *rndIndexes = [self.trainingSession generateSequenceWithTasksCount:tasksCount totalCount:totalCount];
    NSArray *ids = [self.serviceLocator.dataManager meaningsIdsForRndIndexes:rndIndexes];
    NSAssert(ids.count == rndIndexes.count, NSLS(@"Неверное количество идентификаторов слов"));
    self.trainingSession.tasksIds = ids;
}

- (BOOL)isTrainingSessionStarted
{
    return (self.trainingSession.currentTaskIndex >= 0);
}

- (void)startTrainingSession
{
    [self.trainingSession start];
}

- (NSInteger)currentTrainingTaskIndex
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

- (void)trainingSessionSetAlternativesForTask:(SEWordTaskPonso *)task
{
    [self.trainingSession setAlternativesForTask:task];
}

- (NSArray *)trainingSessionAlternativesForTaskAtIndex:(NSInteger)index
{
    return [self.trainingSession alternativesForTaskAtIndex:index];
}

- (NSInteger)trainingSessionCorrectAlternativeIndexForTaskAtIndex:(NSInteger)taskIndex
{
    return [self.trainingSession correctAnswerIndexForTaskAtIndex:taskIndex];
}

- (void)trainingSessionSkipTaskAtIndex:(NSInteger)taskIndex
{
    [self.trainingSession skipTaskAtIndex:taskIndex];
}

- (void)trainingSessionSelectAlternativeAtIndex:(NSInteger)alternativeIndex forTaskAtIndex:(NSInteger)taskIndex
{
    [self.trainingSession selectAlternativeAtIndex:alternativeIndex forTaskAtIndex:taskIndex];
}

- (NSInteger)trainingSessionAnswerIndexForTaskAtIndex:(NSInteger)taskIndex
{
    return [self.trainingSession answerIndexForTaskAtIndex:taskIndex];
}

- (void)trainingSessionNextTask
{
    self.trainingSession.currentTaskIndex++;
}

- (BOOL)isTrainingSessionFinished
{
    return (self.trainingSession.currentTaskIndex == self.trainingSession.totalTasksCount);
}

- (NSUInteger)trainingSessionCorrectAnswersCount
{
    return [self.trainingSession correctAnswersCount];
}

- (void)trainingSessionReset
{
    [self.trainingSession reset];
}

@end
