//
//  SETrainingResultCell.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SETrainingResultCell.h"

#import <PureLayout.h>

#import "SEColorScheme.h"
#import "UIFont+Helpers.h"

#import "SERoundedButton.h"

@interface SETrainingResultCell ()

@property (nonatomic, strong) UILabel *resultsLabel;
@property (nonatomic, strong) SERoundedButton *repeatButton;

@end

@implementation SETrainingResultCell

- (void)setupView
{
    self.resultsLabel = [UILabel newAutoLayoutView];
    self.resultsLabel.font = [UIFont app_resultsFont];
    self.resultsLabel.textColor = SECSC(Color_Black);
    self.resultsLabel.textAlignment = NSTextAlignmentCenter;
    [self.contentView addSubview:self.resultsLabel];
    
    self.repeatButton = [SERoundedButton newAutoLayoutView];
    [self.repeatButton addTarget:self
                          action:@selector(repeatAction)
                forControlEvents:UIControlEventTouchUpInside];
    [self.repeatButton setTitle:NSLS(@"Еще раз") forState:UIControlStateNormal];
    [self.repeatButton setBackgroundColor:SECSC(Color_RestartButton)];
    [self.repeatButton setTitleColor:SECSC(Color_White) forState:UIControlStateNormal];
    self.repeatButton.titleLabel.font = [UIFont app_startButtonFont];
    [self.contentView addSubview:self.repeatButton];
    
    [self setupConstraints];
}

- (void)setupConstraints
{
    [self.resultsLabel autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:16];
    [self.resultsLabel autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:16];
    [self.resultsLabel autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView withOffset:-(47+29)];
    
    [self.repeatButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.repeatButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
    [self.repeatButton autoAlignAxis:ALAxisHorizontal toSameAxisOfView:self.contentView withOffset:11+28];
    [self.repeatButton autoSetDimension:ALDimensionHeight toSize:56];
}

#pragma mark - Public

- (void)configureWithCorrect:(NSInteger)correct total:(NSInteger)total
{
    self.resultsLabel.text = [NSString stringWithFormat:@"%ld/%ld", (long)correct, (long)total];
    [self layoutSubviews];
}

#pragma mark - Actions

- (void)repeatAction
{
    [self.delegate trainingResultCellRepeatAction:self];
}

@end
