//
//  UIFont+Helpers.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "UIFont+Helpers.h"

@implementation UIFont (Helpers)

+ (UIFont *)app_primaryFontWithSize:(CGFloat)size
{
    UIFont *font = [UIFont fontWithName:@"SFUIDisplay-Regular" size:size];
    return font;
}

+ (UIFont *)app_secondaryFontWithSize:(CGFloat)size
{
    UIFont *font = [UIFont fontWithName:@"SFUIDisplay-Light" size:size];
    return font;
}

+ (UIFont *)app_startButtonFont
{
    return [self app_primaryFontWithSize:22];
}

+ (UIFont *)app_alternativeFont
{
    return [self app_primaryFontWithSize:18];
}

+ (UIFont *)app_taskTitleFont
{
    return [self app_primaryFontWithSize:36];
}

+ (UIFont *)app_taskTranslationFont
{
    return [self app_secondaryFontWithSize:30];
}

+ (UIFont *)app_resultsFont
{
    return [self app_secondaryFontWithSize:48];
}

@end
