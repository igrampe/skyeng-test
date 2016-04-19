//
//  SETrainingWireframe.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SETrainingWireframe.h"
#import "SETrainingViewController.h"

#import "SEServiceLocator.h"
#import "SEStateManager.h"
#import "SEDataManager.h"
#import "SEApiManager.h"

#import "SEWordTaskPonso.h"

@interface SETrainingWireframe ()

@property (nonatomic, strong) SETrainingViewController *viewController;
@property (nonatomic, strong) SEServiceLocator *serviceLocator;
@property (nonatomic, strong) NSTimer *showAnswerTimer;
@property (nonatomic, assign) BOOL lockSelectAnswer;

@end

@implementation SETrainingWireframe

- (void)presentViewControllerInCtl:(UIViewController *)inCtl withServiceLocator:(SEServiceLocator *)serviceLocator
{
    self.serviceLocator = serviceLocator;
    
    self.viewController = [SETrainingViewController createVC];
    self.viewController.output = self;
    
    [inCtl addChildViewController:self.viewController];
    self.viewController.view.frame = inCtl.view.bounds;
    [inCtl.view addSubview:self.viewController.view];
}

#pragma mark - SETrainingViewOutput

- (void)viewWillAppear
{
    if ([self.serviceLocator.stateManager trainingSessionIsStarted])
    {
        NSInteger currentTaskIndex = [self.serviceLocator.stateManager trainingSessionCurrentTaskIndex];
        if (currentTaskIndex < [self.serviceLocator.stateManager trainingSessionTotalTasksCount])
        {
            [self _showNextTaskAnimated:NO];
        } else
        {
            [self _showResults];
        }
    } else
    {
        [self _showStart];
    }
}

- (void)didSelectAlternativeAtIndex:(NSInteger)index
{
    // If we select an answer or skipped we can't select again
    if (self.lockSelectAnswer)
    {
        return;
    }
    self.lockSelectAnswer = YES;
    self.showAnswerTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                            target:self
                                                          selector:@selector(_showTaskInfoTrigger)
                                                          userInfo:nil
                                                           repeats:NO];
    NSInteger taskIndex = [self.serviceLocator.stateManager trainingSessionCurrentTaskIndex];
    [self.serviceLocator.stateManager trainingSessionSelectAlternativeAtIndex:index forTaskAtIndex:taskIndex];
    [self _showAnswer];
}

- (void)didSkipTask
{
    // If we select an answer or skipped we can't select again
    if (self.lockSelectAnswer)
    {
        return;
    }
    self.lockSelectAnswer = YES;
    self.showAnswerTimer = [NSTimer scheduledTimerWithTimeInterval:1
                                                            target:self
                                                          selector:@selector(_showTaskInfoTrigger)
                                                          userInfo:nil
                                                           repeats:NO];
    NSInteger taskIndex = [self.serviceLocator.stateManager trainingSessionCurrentTaskIndex];
    [self.serviceLocator.stateManager trainingSessionSkipTaskAtIndex:taskIndex];
    [self _showAnswer];
}

- (void)actionStart
{
    [self.serviceLocator.stateManager trainingSessionGenerateWithTasksCount:3];
    [self.viewController showLoader];
    [self _obtainInfoForTrainingSession];
}

- (void)actionNext
{
    self.lockSelectAnswer = NO;
    [self.serviceLocator.stateManager trainingSessionNextTask];
    if ([self.serviceLocator.stateManager trainingSessionIsFinished])
    {
        [self _showResults];
    } else
    {
        [self _showNextTaskAnimated:YES];
    }
}

- (void)actionRestart
{
    [self.viewController reset];
    [self.serviceLocator.stateManager trainingSessionReset];
    [self actionStart];
}

- (void)alertActionRepeat
{
    [self actionStart];
}

- (SEWordTaskPonso *)taskAtIndex:(NSInteger)index
{
    NSInteger taskId = [self.serviceLocator.stateManager trainingSessionTaskIdAtIndex:index];
    SEWordTaskPonso *task = nil;
    if (taskId)
    {
        task = [self.serviceLocator.dataManager taskWithMeaningId:taskId];
    }
    return task;
}

- (NSArray *)alternativesAtIndex:(NSInteger)index
{
    return [self.serviceLocator.stateManager trainingSessionAlternativesForTaskAtIndex:index];
}

#pragma mark - Private

- (void)_showStart
{
    [self.viewController hideProgressAnimated:NO];
    [self.viewController configWithTasksCount:[self.serviceLocator.stateManager trainingSessionTotalTasksCount]];
    [self.viewController showStartAnimated:NO];
}

- (void)_showNextTaskAnimated:(BOOL)animated
{
    NSInteger currentTaskIndex = [self.serviceLocator.stateManager trainingSessionCurrentTaskIndex];            
    [self.viewController showTaskAtIndex:currentTaskIndex animated:animated];
    [self.viewController showProgress:((double)(currentTaskIndex))/[self.serviceLocator.stateManager trainingSessionTotalTasksCount]
                             animated:YES];
}

- (void)_showAnswer
{
    NSInteger currentTaskIndex = [self.serviceLocator.stateManager trainingSessionCurrentTaskIndex];
    NSInteger correctIndex = [self.serviceLocator.stateManager trainingSessionCorrectAlternativeIndexForTaskAtIndex:currentTaskIndex];
    NSInteger answerIndex = [self.serviceLocator.stateManager trainingSessionAnswerIndexForTaskAtIndex:currentTaskIndex];
    [self.viewController highlightItemAtIndex:correctIndex asCorrect:YES forTaskAtIndex:currentTaskIndex];
    if (answerIndex != correctIndex)
    {
        [self.viewController highlightItemAtIndex:answerIndex asCorrect:NO forTaskAtIndex:currentTaskIndex];
    }
}

- (void)_showTaskInfoTrigger
{
    [self.showAnswerTimer invalidate];
    self.showAnswerTimer = nil;
    NSInteger currentTaskIndex = [self.serviceLocator.stateManager trainingSessionCurrentTaskIndex];
    [self.viewController showTaskInfoAtIndex:currentTaskIndex];
}

- (void)_showResults
{
    NSInteger correct = [self.serviceLocator.stateManager trainingSessionCorrectAnswersCount];
    NSInteger total = [self.serviceLocator.stateManager trainingSessionTotalTasksCount];
    [self.viewController showResultsWithCorrect:correct total:total animated:YES];
    [self.viewController hideProgressAnimated:NO];
}

- (void)_obtainInfoForTrainingSession
{
    NSArray *tasksIds = [self.serviceLocator.stateManager trainingSessionTasksIds];
    __weak typeof(self) welf = self;
    
    [self.serviceLocator.apiManager apiGetWordTasksForMeaningIds:tasksIds
                                                      imageWidth:CGRectGetWidth(self.viewController.view.bounds)*[UIScreen mainScreen].scale
                                                         handler:
    ^(NSArray *objects, NSError *error)
    {
        if (error)
        {
            [welf.viewController hideLoader];
            [welf.viewController showErrorWithMessage:error.localizedDescription];
        } else
        {
            [self.serviceLocator.dataManager clearTasks];
            [self.serviceLocator.dataManager addTasks:objects];
            [self.serviceLocator.stateManager trainingSessionStart];
            NSInteger count = [self.serviceLocator.stateManager trainingSessionTotalTasksCount];
            for (NSInteger i = 0; i < count; i++)
            {
                NSInteger taskId = [self.serviceLocator.stateManager trainingSessionTaskIdAtIndex:i];
                SEWordTaskPonso *task = [self.serviceLocator.dataManager taskWithMeaningId:taskId];
                [self.serviceLocator.stateManager trainingSessionSetAlternativesForTask:task];
            }
            [welf.viewController configWithTasksCount:[self.serviceLocator.stateManager trainingSessionTotalTasksCount]];
            [welf.viewController hideLoader];
            [welf _showNextTaskAnimated:YES];
        }
    }];
}

@end
