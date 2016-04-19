//
//  SETrainingSession.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 16/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <Foundation/Foundation.h>

@class SEWordTaskPonso;

@interface SETrainingSession : NSObject

@property (nonatomic, strong) NSArray *tasksIds;
@property (nonatomic, assign) NSInteger currentTaskIndex;
@property (nonatomic, assign, readonly) NSInteger totalTasksCount;

#pragma mark - Actions

- (void)start;
- (void)reset;

- (NSArray *)generateSequenceWithTasksCount:(NSInteger)tasksCount totalCount:(NSInteger)totalCount;
- (void)setAlternativesForTask:(SEWordTaskPonso *)task;
- (void)skipTaskAtIndex:(NSInteger)taskIndex;
- (void)selectAlternativeAtIndex:(NSInteger)alternativeAtIndex forTaskAtIndex:(NSInteger)taskIndex;

#pragma mark - Gettes

- (NSInteger)taskIdAtIndex:(NSInteger)index;
- (NSArray *)alternativesForTaskAtIndex:(NSInteger)taskIndex;
- (NSInteger)correctAnswerIndexForTaskAtIndex:(NSInteger)taskIndex;
- (NSInteger)answerIndexForTaskAtIndex:(NSInteger)taskIndex;
- (NSInteger)correctAnswersCount;

@end
