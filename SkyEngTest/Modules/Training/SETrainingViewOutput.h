//
//  SETrainingViewOutput.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#ifndef SETrainingViewOutput_h
#define SETrainingViewOutput_h

@class SEWordTaskPonso;

@protocol SETrainingViewOutput <NSObject>

- (void)viewWillAppear;
- (void)didSelectAlternativeAtIndex:(NSInteger)index;
- (void)didSkipTask;
- (void)actionStart;
- (void)actionNext;
- (void)actionRestart;
- (void)alertActionRepeat;

- (SEWordTaskPonso *)taskAtIndex:(NSInteger)index;
- (NSArray *)alternativesAtIndex:(NSInteger)index;

@end

#endif /* SETrainingViewOutput_h */
