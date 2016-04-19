//
//  SETrainingSession.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 16/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SETrainingSession.h"
#import "SEWordTaskAlternativePonso.h"

#import "SEWordTaskPonso.h"
#import "NSMutableArray+Helpers.h"

@interface SETrainingSession ()

@property (nonatomic, strong) NSMutableDictionary *alternatives;
@property (nonatomic, strong) NSSet *meaningRandomIndexesSet;
@property (nonatomic, assign, readwrite) NSInteger totalTasksCount;
@property (nonatomic, strong) NSMutableDictionary *answers;
@property (nonatomic, strong) NSMutableDictionary *correctAnswers;

@end

@implementation SETrainingSession

- (instancetype)init
{
    self = [super init];
    if (self)
    {
        self.currentTaskIndex = -1;
        self.alternatives = [NSMutableDictionary new];
        self.answers = [NSMutableDictionary new];
        self.correctAnswers = [NSMutableDictionary new];
    }
    return self;
}

#pragma mark - Private

- (NSArray *)_randomAlternativesWithCount:(NSInteger)count fromAlternatives:(NSArray *)alternatives
{
    NSArray *result = nil;
    if (count < alternatives.count)
    {
        NSMutableArray *arr = [NSMutableArray new];
        NSMutableArray *indexes = [NSMutableArray new];
        for (NSInteger i = 0; i < alternatives.count; i++)
        {
            [indexes addObject:@(i)];
        }
        
        NSInteger maxRndIndex = alternatives.count-1;
        for (NSInteger i = 0; i < count; i++)
        {
            NSInteger rndIndex = arc4random()%maxRndIndex;
            NSInteger index = [indexes[rndIndex] integerValue];
            [indexes removeObjectAtIndex:rndIndex];
            maxRndIndex--;
            SEWordTaskAlternativePonso *ponso = alternatives[index];
            [arr addObject:ponso];
        }
        result = arr;
    } else
    {
        result = alternatives;
    }
    
    return result;
}

#pragma mark - Public

- (NSArray *)generateSequenceWithTasksCount:(NSInteger)tasksCount totalCount:(NSInteger)totalCount
{
    self.totalTasksCount = tasksCount;
    // naive implementation, takes a lot of memory, when totalCount is very large (~totalCount)
    
    NSMutableSet *seq = [NSMutableSet new];
    NSMutableArray *tasks = [NSMutableArray new];
    
    // Generate tasks from 1 to totalCount
    for (NSInteger i = 1; i <= totalCount; i++)
    {
        [tasks addObject:@(i)];
    }
    
    // Maximum random index
    NSInteger randomLength = totalCount-1;
    
    for (NSInteger i = 0; i < tasksCount && randomLength >= 0; i++)
    {
        // Get a random index from 0 to randomLength,
        // add the task with this index to our set.
        // Remove this task from avaliable tasks,
        // educe maximum random index
        
        NSInteger rnd = arc4random()%randomLength;
        [seq addObject:[tasks objectAtIndex:rnd]];
        [tasks removeObjectAtIndex:rnd];
        randomLength--;
    }
    
    self.meaningRandomIndexesSet = [NSSet setWithSet:seq];
    
    return [self.meaningRandomIndexesSet allObjects];
}

- (void)start
{
    self.currentTaskIndex = 0;
    [self.correctAnswers removeAllObjects];
}

- (void)reset
{
    self.currentTaskIndex = 0;
    self.totalTasksCount = 0;
    [self.alternatives removeAllObjects];
    [self.answers removeAllObjects];
    [self.correctAnswers removeAllObjects];
    self.meaningRandomIndexesSet = nil;
}

- (NSInteger)taskIdAtIndex:(NSInteger)index
{
    NSInteger result = 0;
    if (index < self.totalTasksCount)
    {
        result = [[self.tasksIds objectAtIndex:index] integerValue];
    }
    return result;
}

- (void)setAlternativesForTask:(SEWordTaskPonso *)task
{
    SEWordTaskAlternativePonso *alt = [SEWordTaskAlternativePonso new];
    alt.text = task.text;
    alt.translation = task.translation;
    NSMutableArray *alts = [[self _randomAlternativesWithCount:3 fromAlternatives:task.alternatives] mutableCopy];
    [alts addObject:alt];
    [alts shuffle];
    [self.correctAnswers setObject:alt forKey:@(task.meaningId)];
    [self.alternatives setObject:alts forKey:@(task.meaningId)];
}

- (NSArray *)alternativesForTaskAtIndex:(NSInteger)taskIndex
{
    NSInteger taskId = [self taskIdAtIndex:taskIndex];
    NSArray *alternatives = [self.alternatives objectForKey:@(taskId)];
    return alternatives;
}

- (NSInteger)correctAnswerIndexForTaskAtIndex:(NSInteger)taskIndex
{
    NSInteger taskId = [self taskIdAtIndex:taskIndex];
    SEWordTaskAlternativePonso *alt = [self.correctAnswers objectForKey:@(taskId)];
    NSArray *alternatives = [self.alternatives objectForKey:@(taskId)];
    NSInteger result = -1;
    for (NSInteger i = 0; i < alternatives.count; i++)
    {
        SEWordTaskAlternativePonso *a = alternatives[i];
        if ([a.translation isEqualToString:alt.translation])
        {
            result = i;
        }
    }
    return result;
}

- (void)skipTaskAtIndex:(NSInteger)taskIndex
{
    NSInteger taskId = [self taskIdAtIndex:taskIndex];
    [self.answers setObject:@(-1) forKey:@(taskId)];
}

- (void)selectAlternativeAtIndex:(NSInteger)alternativeAtIndex forTaskAtIndex:(NSInteger)taskIndex
{
    NSInteger taskId = [self taskIdAtIndex:taskIndex];
    [self.answers setObject:@(alternativeAtIndex) forKey:@(taskId)];
}

- (NSInteger)answerIndexForTaskAtIndex:(NSInteger)taskIndex
{
    NSInteger result = -1;
    NSInteger taskId = [self taskIdAtIndex:taskIndex];
    NSNumber *indexNumber = [self.answers objectForKey:@(taskId)];
    if (indexNumber)
    {
        result = [indexNumber integerValue];
    }
    return result;
}

- (NSInteger)correctAnswersCount
{
    NSInteger result = 0;
    for (NSNumber *taskId in self.tasksIds)
    {
        NSInteger index = [[self.answers objectForKey:taskId] integerValue];
        if (index >= 0)
        {
            SEWordTaskAlternativePonso *alt = [self.correctAnswers objectForKey:taskId];
            NSArray *alternatives = [self.alternatives objectForKey:taskId];
            SEWordTaskAlternativePonso *a = alternatives[index];
            if ([a.translation isEqualToString:alt.translation])
            {
                result++;
            }
        }
    }
    
    return result;
}

@end
