//
//  SEAsynImageView.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEAsyncImageView.h"
#import <UIImageView+WebCache.h>

@interface SEAsyncImageView ()

@property (nonatomic, strong) UIActivityIndicatorView *activityView;

@end

@implementation SEAsyncImageView

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
    self.activityView = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleGray];
    self.activityView.hidesWhenStopped = YES;
    [self addSubview:self.activityView];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.activityView.frame = CGRectMake(CGRectGetWidth(self.bounds)-25, CGRectGetHeight(self.bounds)-25, 25, 25);
}

#pragma mark - Public

- (void)setImageUrl:(NSString *)imageUrlStr
{
    [self setImageUrl:imageUrlStr animated:NO];
}

- (void)setImageUrl:(NSString *)imageUrlStr animated:(BOOL)animated
{
    if (imageUrlStr)
    {
        NSURL *url = [NSURL URLWithString:imageUrlStr];
        if (url)
        {
            [self.activityView startAnimating];
            __weak typeof(self) welf = self;
            [self sd_setImageWithURL:url
                           completed:
            ^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL)
            {
                [welf.activityView stopAnimating];
                [welf.delegate imageViewDidLoadImage:welf];
                if (animated)
                {
                    welf.layer.opacity = 0;
                    [UIView animateWithDuration:0.5
                                     animations:
                    ^
                    {
                        welf.layer.opacity = 1;
                    }];
                }
            }];
        }
    }
}

@end
