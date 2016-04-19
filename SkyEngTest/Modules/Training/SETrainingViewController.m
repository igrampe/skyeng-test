//
//  SETrainingViewController.m
//  SkyEngTest
//
//  Created by Semyon Belokovsky on 17/04/16.
//  Copyright © 2016 igrampe. All rights reserved.
//

#import "SETrainingViewController.h"

#import <UIAlertView+Blocks.h>
#import <SVProgressHUD.h>
#import <PureLayout.h>

#import "SETrainingStartCell.h"
#import "SETrainingTaskCell.h"
#import "SETrainingResultCell.h"

#import "SEProgressBarView.h"

@interface SETrainingViewController ()
<UICollectionViewDataSource,
UICollectionViewDelegate,
SETrainingStartCellDelegate,
SETrainingTaskCellDelegate,
SETrainingResultCellDelegate>

@property (nonatomic, strong) SEProgressBarView *progressBar;
@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, assign) NSInteger tasksCount;
@property (nonatomic, assign) NSInteger correct;

@end

@implementation SETrainingViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setupView];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.output viewWillAppear];
}

- (void)setupView
{
    self.view.backgroundColor = [UIColor whiteColor];
    
    UICollectionViewFlowLayout *layout = [UICollectionViewFlowLayout new];
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    
    self.collectionView = [[UICollectionView alloc] initWithFrame:self.view.bounds
                                             collectionViewLayout:layout];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    [self.collectionView registerClass:[SETrainingStartCell class]
            forCellWithReuseIdentifier:[SETrainingStartCell identifier]];
    [self.collectionView registerClass:[SETrainingTaskCell class]
            forCellWithReuseIdentifier:[SETrainingTaskCell identifier]];
    [self.collectionView registerClass:[SETrainingResultCell class]
            forCellWithReuseIdentifier:[SETrainingResultCell identifier]];
    self.collectionView.backgroundColor = [UIColor whiteColor];
    self.collectionView.pagingEnabled = YES;
    self.collectionView.showsHorizontalScrollIndicator = NO;
    self.collectionView.scrollEnabled = NO;
    [self.view addSubview:self.collectionView];
    
    self.progressBar = [SEProgressBarView newAutoLayoutView];
    self.progressBar.progress = 0.0;
    [self.view addSubview:self.progressBar];
    
    [self setupConstraints];
}

- (void)setupConstraints
{
    [self.collectionView autoPinEdgesToSuperviewEdges];
    
    [self.progressBar autoPinEdgeToSuperviewEdge:ALEdgeLeft withInset:48];
    [self.progressBar autoPinEdgeToSuperviewEdge:ALEdgeRight withInset:48];
    CGFloat topInset = 36;
    if (CGRectGetHeight(self.view.bounds) < 568)
    {
        topInset = 24;
    }
    [self.progressBar autoPinEdgeToSuperviewEdge:ALEdgeTop withInset:topInset];
    [self.progressBar autoSetDimension:ALDimensionHeight toSize:8];
}

#pragma mark - SETrainingViewInput

- (void)configWithTasksCount:(NSInteger)tasksCount
{
    self.tasksCount = tasksCount;
    [self.collectionView reloadData];
}

- (void)showStartAnimated:(BOOL)animated
{
    
}

- (void)showResultsWithCorrect:(NSInteger)correct total:(NSInteger)total animated:(BOOL)animated
{
    self.correct = correct;
    NSInteger row = [self.collectionView numberOfItemsInSection:0]-1;
    NSIndexPath *path = [NSIndexPath indexPathForRow:row inSection:0];
    [self.collectionView scrollToItemAtIndexPath:path
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:animated];
}

- (void)showTaskAtIndex:(NSInteger)index animated:(BOOL)animated
{
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:index+1 inSection:0]
                                atScrollPosition:UICollectionViewScrollPositionLeft
                                        animated:animated];
}

- (void)highlightItemAtIndex:(NSInteger)index asCorrect:(BOOL)correct forTaskAtIndex:(NSInteger)taskIndex
{
    SETrainingTaskCell *cell = (SETrainingTaskCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:taskIndex+1 inSection:0]];
    if ([cell isKindOfClass:[SETrainingTaskCell class]])
    {
        [cell highlightItemAtIndex:index asCorrect:correct];
    }
}

- (void)showTaskInfoAtIndex:(NSInteger)taskIndex;
{
    SETrainingTaskCell *cell = (SETrainingTaskCell *)[self.collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:taskIndex+1 inSection:0]];
    if ([cell isKindOfClass:[SETrainingTaskCell class]])
    {
        [cell showTaskInfo];
    }
}

- (void)hideProgressAnimated:(BOOL)animated
{
    if (animated)
    {
        __weak typeof(self) welf = self;
        [UIView animateWithDuration:0.5
                         animations:
         ^
        {
            welf.progressBar.alpha = 0;
        }];
    } else
    {
        self.progressBar.alpha = 0;
    }
}

- (void)showProgress:(double)progress animated:(BOOL)animated
{
    self.progressBar.alpha = 1;
    [self.progressBar setProgress:progress animated:animated];
}

- (void)showErrorWithMessage:(NSString *)message
{
    __weak typeof(self) welf = self;
    [UIAlertView showWithTitle:nil
                       message:message
             cancelButtonTitle:NSLS(@"Повторить")
             otherButtonTitles:nil
                      tapBlock:
    ^(UIAlertView * _Nonnull alertView, NSInteger buttonIndex)
    {
        [welf.output alertActionRepeat];
    }];
}

- (void)showLoader
{
    [SVProgressHUD show];
}

- (void)hideLoader
{
    [SVProgressHUD popActivity];
}

- (void)reset
{
    self.progressBar.progress = 0;
    self.tasksCount = 0;
    self.correct = 0;
    [self.collectionView reloadData];
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.tasksCount+2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = nil;
    
    if (indexPath.row == 0)
    {
        SETrainingStartCell *c = [collectionView dequeueReusableCellWithReuseIdentifier:[SETrainingStartCell identifier]
                                                                           forIndexPath:indexPath];
        c.delegate = self;
        cell = c;
    } else if (indexPath.row == [self.collectionView numberOfItemsInSection:0] - 1)
    {
        SETrainingResultCell *c = [collectionView dequeueReusableCellWithReuseIdentifier:[SETrainingResultCell identifier]
                                                                           forIndexPath:indexPath];
        c.delegate = self;
        cell = c;
    } else
    {
        SETrainingTaskCell *c = [collectionView dequeueReusableCellWithReuseIdentifier:[SETrainingTaskCell identifier]
                                                                            forIndexPath:indexPath];
        c.delegate = self;
        SEWordTaskPonso *task = [self.output taskAtIndex:indexPath.row-1];
        NSArray *alternatives = [self.output alternativesAtIndex:indexPath.row-1];
        [c configureWithWordTask:task alternatives:alternatives];
        cell = c;
    }
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView willDisplayCell:(UICollectionViewCell *)cell forItemAtIndexPath:(NSIndexPath *)indexPath
{
    if ([cell isKindOfClass:[SETrainingTaskCell class]])
    {
        SETrainingTaskCell *c = (SETrainingTaskCell *)cell;
        [c reset];
    } else if ([cell isKindOfClass:[SETrainingResultCell class]])
    {
        SETrainingResultCell *c = (SETrainingResultCell *)cell;
        [c configureWithCorrect:self.correct total:self.tasksCount];
    }
}

#pragma mark - UICollectionViewDelegate

#pragma mark – UICollectionViewDelegateFlowLayout

- (CGSize)collectionView:(UICollectionView *)collectionView
                  layout:(UICollectionViewLayout *)collectionViewLayout
  sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return self.collectionView.bounds.size;
}

#pragma mark - SETrainingStartCellDelegate

- (void)trainingStartCellActionStart:(SETrainingStartCell *)cell
{
    [self.output actionStart];
}

#pragma mark - SETrainingTaskCellDelegate

- (void)taskCellActionSkip:(SETrainingTaskCell *)cell
{
    [self.output didSkipTask];
}

- (void)taskCell:(SETrainingTaskCell *)cell actionSelectAlternativeAtIndex:(NSInteger)index
{
    [self.output didSelectAlternativeAtIndex:index];
}

- (void)taskCellActionNext:(SETrainingTaskCell *)cell
{
    [self.output actionNext];
}

#pragma mark - SETrainingResultCellDelegate

- (void)trainingResultCellRepeatAction:(SETrainingResultCell *)cell
{
    [self.output actionRestart];
}

@end
