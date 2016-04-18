//
//  SETrainingResultCell.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SECollectionViewCellBase.h"

@class SETrainingResultCell;

@protocol SETrainingResultCellDelegate <NSObject>

- (void)trainingResultCellRepeatAction:(SETrainingResultCell *)cell;

@end

@interface SETrainingResultCell : SECollectionViewCellBase

@property (nonatomic, weak) id<SETrainingResultCellDelegate> delegate;

- (void)configureWithCorrect:(NSInteger)correct total:(NSInteger)total;

@end
