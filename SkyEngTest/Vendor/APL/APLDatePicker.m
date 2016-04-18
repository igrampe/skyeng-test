//
//  APLDatePicker.m
//  Client
//
//  Created by Semyon Belokovsky on 29/11/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import "APLDatePicker.h"
#import <PureLayout.h>

@interface APLDatePicker ()

@property (nonatomic, strong) UIView *wrapperView;
@property (nonatomic, strong) UIView *backgroundView;

@end

@implementation APLDatePicker

+ (CGFloat)height
{
    return 200;
}

- (void)setupView
{
    [super setupView];
    [self.wrapperView addSubview:self.backgroundView];
    [self.wrapperView addSubview:self];
    
    self.backgroundColor = [UIColor whiteColor];
    
    self.headerView = [UIView newAutoLayoutView];
    [self addSubview:self.headerView];
    
    self.cancelButon = [UIButton newAutoLayoutView];
    [self.cancelButon addTarget:self action:@selector(cancelAction) forControlEvents:UIControlEventTouchUpInside];
    self.cancelButon.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.cancelButon setTitle:NSLS(@"cancel") forState:UIControlStateNormal];
    [self.cancelButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.cancelButon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
    [self addSubview:self.cancelButon];
    
    self.doneButon = [UIButton newAutoLayoutView];
    [self.doneButon addTarget:self action:@selector(doneAction) forControlEvents:UIControlEventTouchUpInside];
    self.doneButon.titleLabel.font = [UIFont systemFontOfSize:17];
    [self.doneButon setTitle:NSLS(@"select") forState:UIControlStateNormal];
    [self.doneButon setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    self.doneButon.contentHorizontalAlignment = UIControlContentHorizontalAlignmentRight;
    [self addSubview:self.doneButon];
    
    self.datePicker = [UIDatePicker newAutoLayoutView];
    self.datePicker.datePickerMode = UIDatePickerModeDateAndTime;
    [self addSubview:self.datePicker];
    
    [self setupConstraints];
}

- (void)setupConstraints
{
    [self.backgroundView autoPinEdgesToSuperviewEdges];
    
    [self.headerView autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.headerView autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.headerView autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.headerView autoSetDimension:ALDimensionHeight toSize:44];
    
    [self.cancelButon autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:8];
    [self.cancelButon autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.cancelButon autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.headerView];
    
    [self.doneButon autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:8];
    [self.doneButon autoPinEdgeToSuperviewEdge:ALEdgeTop];
    [self.doneButon autoPinEdge:ALEdgeBottom toEdge:ALEdgeBottom ofView:self.headerView];
    
    [self.datePicker autoPinEdgeToSuperviewEdge:ALEdgeBottom];
    [self.datePicker autoPinEdgeToSuperviewEdge:ALEdgeLeft];
    [self.datePicker autoPinEdgeToSuperviewEdge:ALEdgeRight];
    [self.datePicker autoPinEdge:ALEdgeTop toEdge:ALEdgeBottom ofView:self.headerView];
}

- (UIView *)wrapperView
{
    if (!_wrapperView)
    {
        _wrapperView = [UIView new];
    }
    return _wrapperView;
}

- (UIView *)backgroundView
{
    if (!_backgroundView)
    {
        _backgroundView = [UIView newAutoLayoutView];
        _backgroundView.backgroundColor = [[UIColor blackColor] colorWithAlphaComponent:0.5];
    }
    return _backgroundView;
}

#pragma mark - Public

- (void)setBackgroundColor:(UIColor *)backgroundColor
{
    [super setBackgroundColor:backgroundColor];
    self.datePicker.backgroundColor = backgroundColor;
}

- (void)show
{
    UIView *parentView = [[UIApplication sharedApplication] keyWindow].rootViewController.view;
    self.wrapperView.frame = parentView.bounds;
    [parentView addSubview:self.wrapperView];
    
    self.frame = CGRectMake(0, CGRectGetHeight(self.wrapperView.frame),
                            CGRectGetWidth(self.wrapperView.frame), [APLDatePicker height]);
    self.backgroundView.alpha = 0;
    
    [UIView animateWithDuration:0.25
                     animations:
    ^
    {
        self.backgroundView.alpha = 1;
        self.frame = CGRectMake(0, CGRectGetHeight(self.wrapperView.frame)-[APLDatePicker height],
                                CGRectGetWidth(self.wrapperView.frame), [APLDatePicker height]);
    } completion:
    ^(BOOL finished)
    {
        
    }];
}

- (void)hide
{
    __weak typeof(self) welf = self;
    [UIView animateWithDuration:0.25
                     animations:
     ^
     {
         self.backgroundView.alpha = 0;
         self.frame = CGRectMake(0, CGRectGetHeight(self.wrapperView.frame),
                                 CGRectGetWidth(self.wrapperView.frame), [APLDatePicker height]);
     } completion:
     ^(BOOL finished)
     {
         [welf.wrapperView removeFromSuperview];
     }];
}

- (void)cancelAction
{
    [self.delegate datePickerDidCancel:self];
    [self hide];
}

- (void)doneAction
{
    [self.delegate datePicker:self didSelectDate:self.datePicker.date];
    [self hide];
}

@end
