//
//  SEAlternativeCell.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SEAlternativeCell.h"

#import "SERoundedButton.h"
#import "SEColorScheme.h"

#import <PureLayout.h>

@interface SEAlternativeCell ()

@property (nonatomic, strong) SERoundedButton *actionButton;

@end

@implementation SEAlternativeCell

+ (NSString *)identifier
{
    return NSStringFromClass([self class]);
}

+ (CGFloat)height
{
    return 56+12;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self)
    {
        [self setupView];
    }
    return self;
}

- (void)setupView
{
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    self.actionButton = [SERoundedButton newAutoLayoutView];
    self.actionButton.userInteractionEnabled = NO;
//    [self.actionButton addTarget:self
//                          action:@selector(buttonAction)
//                forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:self.actionButton];
    
    [self setupConstraints];
    
    self.style = SEAlternativeCellStyleCommon;
}

- (void)setupConstraints
{
    [self.actionButton autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:24];
    [self.actionButton autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:24];
    [self.actionButton autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:6];
    [self.actionButton autoPinEdgeToSuperviewEdge:ALEdgeBottom withInset:6];
    [self.actionButton autoSetDimension:ALDimensionHeight toSize:56];
}

- (void)setStyle:(SEAlternativeCellStyle)style
{
    _style = style;
    [self updateUI];
}

- (void)updateUI
{
    UIColor *buttonColor = nil;
    UIColor *buttonTitleColor = nil;
    self.actionButton.layer.borderWidth = 0;
    
    switch (_style)
    {
        case SEAlternativeCellStyleCommon:
            self.actionButton.layer.borderWidth = 1;
            self.actionButton.layer.borderColor = SECSC(Color_ButtonBorder).CGColor;
            buttonColor = SECSC(Color_White);
            buttonTitleColor = SECSC(Color_Black);
            break;
        case SEAlternativeCellStyleCorrect:
            buttonColor = SECSC(Color_AlternativeButtonCorrect);
            buttonTitleColor = SECSC(Color_White);
            break;
        case SEAlternativeCellStyleWrong:
            buttonColor = SECSC(Color_AlternativeButtonWrong);
            buttonTitleColor = SECSC(Color_White);
            break;
        case SEAlternativeCellStyleSkip:
            buttonColor = [UIColor clearColor];
            buttonTitleColor = SECSC(Color_SkipButtonTitle);
            break;
        default:
            break;
    }
    
    self.actionButton.backgroundColor = buttonColor;
    [self.actionButton setTitleColor:buttonTitleColor forState:UIControlStateNormal];
}

- (void)configureWithTitle:(NSString *)title
{
    [self.actionButton setTitle:title forState:UIControlStateNormal];
}

@end
