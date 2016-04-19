//
//  SEAsynImageView.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <UIKit/UIKit.h>

@class SEAsyncImageView;

@protocol SMAsyncImageViewDelegate <NSObject>

- (void)imageViewDidFinishLoadImage:(SEAsyncImageView *)imageView;
- (void)imageView:(SEAsyncImageView *)imageView didFailLoadImageWithError:(NSError *)error;

@end

@interface SEAsyncImageView : UIImageView

@property (nonatomic, strong) NSString *imageUrl;
@property (nonatomic, weak) id<SMAsyncImageViewDelegate> delegate;
@property (nonatomic, strong) NSIndexPath *indexPath;

@end
