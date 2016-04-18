//
//  SEAlternativeCell.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_ENUM(NSInteger, SEAlternativeCellStyle)
{
    SEAlternativeCellStyleCommon = 0,
    SEAlternativeCellStyleCorrect,
    SEAlternativeCellStyleWrong,
    SEAlternativeCellStyleSkip,
};

@interface SEAlternativeCell : UITableViewCell

@property (nonatomic, assign) SEAlternativeCellStyle style;

- (void)configureWithTitle:(NSString *)title;


+ (NSString *)identifier;
+ (CGFloat)height;

@end
