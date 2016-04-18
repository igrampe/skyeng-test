//
//  SETrainingStartCell.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SECollectionViewCellBase.h"

@class SETrainingStartCell;

@protocol SETrainingStartCellDelegate <NSObject>

- (void)trainingStartCellActionStart:(SETrainingStartCell *)cell;

@end

@interface SETrainingStartCell : SECollectionViewCellBase

@property (nonatomic, weak) id<SETrainingStartCellDelegate> delegate;

@end
