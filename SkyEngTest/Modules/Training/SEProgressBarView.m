//
//  SEProgressBarView.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEProgressBarView.h"
#import "SEColorScheme.h"

@interface SEProgressBarView ()

@property (nonatomic, strong) CALayer *progressLayer;

@end

@implementation SEProgressBarView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self)
    {
        [self setupView];
    }
    
    return self;
}

- (void)setupView
{
    self.layer.borderWidth = 1;
    self.layer.borderColor = SECSC(Color_Gray).CGColor;
    
    self.progressLayer = [CALayer new];
    self.progressLayer.backgroundColor = SECSC(Color_Gray).CGColor;
    self.progressLayer.anchorPoint = CGPointMake(0, 0.5);
    [self.layer addSublayer:self.progressLayer];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.layer.cornerRadius = CGRectGetHeight(self.bounds)/2;
    self.progressLayer.cornerRadius = CGRectGetHeight(self.bounds)/2;
    self.progressLayer.frame = CGRectMake(0, 0, CGRectGetWidth(self.bounds)*self.progress, CGRectGetHeight(self.bounds));
}

- (void)setProgress:(double)progress
{
    [self setProgress:progress animated:NO];
}

- (void)setProgress:(double)progress animated:(BOOL)animated
{
    CGFloat lastValue = _progress;
    _progress = progress;
    if (animated)
    {
        CABasicAnimation *animation = [CABasicAnimation animation];
        animation.keyPath = @"bounds.size.width";
        animation.fromValue = @(CGRectGetWidth(self.bounds)*lastValue);
        animation.duration = 0.5;
        animation.toValue = @(CGRectGetWidth(self.bounds)*_progress);
        animation.delegate = self;
        animation.removedOnCompletion = NO;
        animation.fillMode = kCAFillModeForwards;
        [self.progressLayer addAnimation:animation forKey:@"progress"];
    }
}

@end
