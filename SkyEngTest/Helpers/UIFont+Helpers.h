//
//  UIFont+Helpers.h
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIFont (Helpers)

+ (UIFont *)app_primaryFontWithSize:(CGFloat)size;
+ (UIFont *)app_startButtonFont;
+ (UIFont *)app_alternativeFont;
+ (UIFont *)app_taskTitleFont;
+ (UIFont *)app_taskTranslationFont;
+ (UIFont *)app_resultsFont;

@end
