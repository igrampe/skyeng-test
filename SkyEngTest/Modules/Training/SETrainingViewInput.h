//
//  SETrainingViewInput.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#ifndef SETrainingViewInput_h
#define SETrainingViewInput_h

@class SEWordTaskPonso;

@protocol SETrainingViewInput <NSObject>

- (void)configWithTasksCount:(NSInteger)tasksCount;
- (void)reset;

- (void)showStartAnimated:(BOOL)animated;
- (void)showResultsWithCorrect:(NSInteger)correct total:(NSInteger)total animated:(BOOL)animated;
- (void)showTaskAtIndex:(NSInteger)index animated:(BOOL)animated;
- (void)showTaskInfoAtIndex:(NSInteger)index;

- (void)highlightItemAtIndex:(NSInteger)index asCorrect:(BOOL)correct forTaskAtIndex:(NSInteger)taskIndex;

- (void)showProgress:(double)progress animated:(BOOL)animated;
- (void)hideProgressAnimated:(BOOL)animated;

- (void)showErrorWithMessage:(NSString *)message;
- (void)showLoader;
- (void)hideLoader;

@end

#endif /* SETrainingViewInput_h */
