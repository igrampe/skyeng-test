//
//  SETrainingTaskCell.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SECollectionViewCellBase.h"

@class SEWordTaskPonso;
@class SETrainingTaskCell;

@protocol SETrainingTaskCellDelegate <NSObject>

- (void)taskCellActionSkip:(SETrainingTaskCell *)cell;
- (void)taskCellActionNext:(SETrainingTaskCell *)cell;
- (void)taskCell:(SETrainingTaskCell *)cell actionSelectAlternativeAtIndex:(NSInteger)index;

@end

@interface SETrainingTaskCell : SECollectionViewCellBase

@property (nonatomic, weak) id<SETrainingTaskCellDelegate> delegate;

- (void)configureWithWordTask:(SEWordTaskPonso *)task alternatives:(NSArray *)alternatives;
- (void)highlightItemAtIndex:(NSInteger)index asCorrect:(BOOL)correct;
- (void)resetHighlighting;
- (void)showTaskInfo;
- (void)reset;

@end
