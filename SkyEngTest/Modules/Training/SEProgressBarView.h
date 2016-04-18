//
//  SEProgressBarView.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SEProgressBarView : UIView

@property (nonatomic, assign) double progress;

- (void)setProgress:(double)progress animated:(BOOL)animated;

@end
