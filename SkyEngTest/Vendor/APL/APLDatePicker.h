//
//  APLDatePicker.h
//  Client
//
//  Created by Semyon Belokovsky on 29/11/15.
//  Copyright © 2015 App Plus. All rights reserved.
//

#import "APLView.h"

@class APLDatePicker;

@protocol APLDatePickerDelegate <NSObject>

- (void)datePicker:(APLDatePicker *)datePicker didSelectDate:(NSDate *)date;
- (void)datePickerDidCancel:(APLDatePicker *)datePicker;

@end

@interface APLDatePicker : APLView

@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, strong) UIButton *cancelButon;
@property (nonatomic, strong) UIButton *doneButon;
@property (nonatomic, strong) UIView *headerView;

@property (nonatomic, weak) id <APLDatePickerDelegate> delegate;

- (void)show;
- (void)setBackgroundColor:(UIColor *)backgroundColor;

+ (CGFloat)height;

@end
