//
//  SETrainingStartCell.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SETrainingStartCell.h"
#import "SERoundedButton.h"
#import "SEColorScheme.h"
#import "UIFont+Helpers.h"

#import <PureLayout.h>

@interface SETrainingStartCell ()

@property (nonatomic, strong) SERoundedButton *button;

@end

@implementation SETrainingStartCell

- (void)setupView
{
    self.button = [SERoundedButton newAutoLayoutView];
    self.button.backgroundColor = SECSC(Color_StartButton);
    self.button.titleLabel.font = [UIFont app_startButtonFont];
    [self.button setTitle:NSLS(@"Начать тренировку") forState:UIControlStateNormal];
    [self.button setTitleColor:SECSC(Color_White)
                      forState:UIControlStateNormal];
    [self.button addTarget:self
                    action:@selector(actionStart)
          forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.button];
    
    [self setupConstraints];
}

- (void)setupConstraints
{
    [self.button autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.button autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
    [self.button autoSetDimension:ALDimensionHeight toSize:56];
    [self.button autoAlignAxisToSuperviewAxis:ALAxisHorizontal];
}

- (void)actionStart
{
    [self.delegate trainingStartCellActionStart:self];
}

@end
