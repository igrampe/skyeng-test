//
//  SETrainingTaskCell.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 18/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SETrainingTaskCell.h"

#import "SEWordTaskPonso.h"
#import "SEWordTaskAlternativePonso.h"

#import "UIFont+Helpers.h"
#import "SEColorScheme.h"

#import "SEAlternativeCell.h"
#import "SERoundedButton.h"
#import "SEAsyncImageView.h"

@interface SETrainingTaskCell ()
<UITableViewDataSource,
UITableViewDelegate,
SMAsyncImageViewDelegate>

@property (nonatomic, strong) UIScrollView *scrollView;

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) SEAsyncImageView *imageView;
@property (nonatomic, strong) UILabel *answerLabel;
@property (nonatomic, strong) UIButton *nextButton;

@property (nonatomic, strong) NSArray *alternatives;
@property (nonatomic, assign) NSInteger correctIndex;
@property (nonatomic, assign) NSInteger wrongIndex;

@end

@implementation SETrainingTaskCell

- (void)setupView
{
    [self resetHighlighting];
    
    self.scrollView = [UIScrollView new];
    self.scrollView.pagingEnabled = YES;
    self.scrollView.scrollEnabled = NO;
    self.scrollView.showsHorizontalScrollIndicator = NO;
    [self.contentView addSubview:self.scrollView];
    
    self.titleLabel = [UILabel new];
    self.titleLabel.font = [UIFont app_taskTitleFont];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    self.titleLabel.numberOfLines = 0;
    self.titleLabel.textColor = SECSC(Color_Black);
    [self.contentView addSubview:self.titleLabel];
    
    self.tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    [self.tableView registerClass:[SEAlternativeCell class]
           forCellReuseIdentifier:[SEAlternativeCell identifier]];
    [self.scrollView addSubview:self.tableView];
    
    self.imageView = [SEAsyncImageView new];
    self.imageView.delegate = self;
    [self.scrollView addSubview:self.imageView];
    
    self.answerLabel = [UILabel new];
    self.answerLabel.font = [UIFont app_taskTranslationFont];
    [self.scrollView addSubview:self.answerLabel];
    
    self.nextButton = [SERoundedButton new];
    [self.nextButton addTarget:self
                        action:@selector(actionNext)
              forControlEvents:UIControlEventTouchUpInside];
    self.nextButton.backgroundColor = SECSC(Color_NextTaskButton);
    [self.nextButton setTitleColor:SECSC(Color_White) forState:UIControlStateNormal];
    [self.nextButton setTitle:NSLS(@"Дальше") forState:UIControlStateNormal];
    [self.scrollView addSubview:self.nextButton];
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    self.scrollView.frame = self.bounds;
    
    CGSize size = [self.titleLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds)-32, CGRectGetHeight(self.bounds))];
    self.titleLabel.frame = CGRectMake((CGRectGetWidth(self.bounds)-size.width)/2, 76, size.width, size.height);
    
    CGFloat height = [SEAlternativeCell height]*[self tableView:self.tableView numberOfRowsInSection:0];
    self.tableView.frame = CGRectMake(0, CGRectGetHeight(self.bounds)-height, CGRectGetWidth(self.bounds), height);
    
    if (self.imageView.image)
    {
        height = self.imageView.image.size.height*CGRectGetWidth(self.bounds)/self.imageView.image.size.width;
    } else
    {
        height = CGRectGetWidth(self.bounds);
    }
    self.imageView.frame = CGRectMake(CGRectGetWidth(self.bounds),
                                      CGRectGetMaxY(self.titleLabel.frame)+17,
                                      CGRectGetWidth(self.bounds),
                                      height);
    
    size = [self.answerLabel sizeThatFits:CGSizeMake(CGRectGetWidth(self.bounds)-32, CGRectGetHeight(self.bounds))];
    self.answerLabel.frame = CGRectMake(CGRectGetWidth(self.bounds)+(CGRectGetWidth(self.bounds)-size.width)/2,
                                       CGRectGetMaxY(self.imageView.frame)+11,
                                       size.width,
                                       size.height);
    
    self.nextButton.frame = CGRectMake(CGRectGetWidth(self.bounds)+24,
                                       CGRectGetHeight(self.bounds)-32-48,
                                       CGRectGetWidth(self.bounds)-24*2, 48);
    
    self.scrollView.contentSize = CGSizeMake(CGRectGetWidth(self.bounds)*2, CGRectGetHeight(self.bounds));
}

#pragma mark - Public

- (void)configureWithWordTask:(SEWordTaskPonso *)task alternatives:(NSArray *)alternatives
{
    self.titleLabel.text = task.text;
    self.alternatives = alternatives;
    [self.tableView reloadData];
    
    NSString *imageUrlStr = [task.images firstObject];
    if (imageUrlStr)
    {
        [self.imageView setImageUrl:imageUrlStr];
    }
    self.answerLabel.text = task.translation;
    
    [self layoutSubviews];
}

- (void)highlightItemAtIndex:(NSInteger)index asCorrect:(BOOL)correct
{
    if (correct)
    {
        self.correctIndex = index;
    } else
    {
        self.wrongIndex = index;
    }
    
    SEAlternativeCell *cell = (SEAlternativeCell *)[self.tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:index inSection:0]];
    if ([cell isKindOfClass:[SEAlternativeCell class]])
    {
        cell.style = correct?SEAlternativeCellStyleCorrect:SEAlternativeCellStyleWrong;
    }
}

- (void)resetHighlighting
{
    self.correctIndex = -1;
    self.wrongIndex = -1;
}

- (void)showTaskInfo
{
    [self.scrollView scrollRectToVisible:CGRectMake(CGRectGetWidth(self.bounds),
                                                    0,
                                                    CGRectGetWidth(self.bounds),
                                                    CGRectGetHeight(self.bounds))
                                animated:YES];
}

- (void)reset
{
    [self.scrollView scrollRectToVisible:self.bounds animated:NO];
    [self resetHighlighting];
}

#pragma mark - UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.alternatives.count+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SEAlternativeCell *cell = [tableView dequeueReusableCellWithIdentifier:[SEAlternativeCell identifier]];
    
    if (indexPath.row < self.alternatives.count)
    {
        SEWordTaskAlternativePonso *ponso = self.alternatives[indexPath.row];
        [cell configureWithTitle:ponso.translation];
    } else
    {
        [cell configureWithTitle:NSLS(@"Не помню")];
    }
    
    return cell;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView willDisplayCell:(nonnull UITableViewCell *)cell forRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    SEAlternativeCell *c = (SEAlternativeCell *)cell;
    if (indexPath.row < self.alternatives.count)
    {
        if (indexPath.row == self.correctIndex)
        {
            c.style = SEAlternativeCellStyleCorrect;
        } else if (indexPath.row == self.correctIndex)
        {
            c.style = SEAlternativeCellStyleWrong;
        } else
        {
            c.style = SEAlternativeCellStyleCommon;
        }
    } else
    {
        c.style = SEAlternativeCellStyleSkip;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [SEAlternativeCell height];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == self.alternatives.count)
    {
        [self.delegate taskCellActionSkip:self];
    } else
    {
        [self.delegate taskCell:self actionSelectAlternativeAtIndex:indexPath.row];
    }
}

#pragma mark - SMAsyncImageViewDelegate

- (void)imageViewDidLoadImage:(SEAsyncImageView *)imageView
{
    [self layoutSubviews];
}

#pragma mark - Actions

- (void)actionNext
{
    [self.delegate taskCellActionNext:self];
}

@end
