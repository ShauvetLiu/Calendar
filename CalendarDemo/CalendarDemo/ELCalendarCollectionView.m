//
//  ELCalendarView.m
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import "ELCalendarCollectionView.h"
#import "ELCalendarCell.h"
#import "ELCalendarEngine.h"

@interface ELCalendarCollectionView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *mCollectionView;
@end

@implementation ELCalendarCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        [self mainUI];
    }
    return self;
}

- (void)mainUI
{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc]init];
    CGFloat itemWidth = self.bounds.size.width/ 7;
    CGFloat itemHeight = self.bounds.size.height / 6;
    flowLayout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
    flowLayout.itemSize = CGSizeMake(itemWidth, itemHeight);
    flowLayout.minimumLineSpacing = 0;
    flowLayout.minimumInteritemSpacing = 0;
    
    UICollectionView *tCollectionView = [[UICollectionView alloc]initWithFrame:self.bounds collectionViewLayout:flowLayout];
    tCollectionView.pagingEnabled = YES;
    tCollectionView.backgroundColor = [UIColor whiteColor];
    tCollectionView.delegate = self;
    tCollectionView.dataSource = self;
    [tCollectionView registerClass:[ELCalendarCell class] forCellWithReuseIdentifier:@"ELCalendarCell"];
    [self addSubview:tCollectionView];
    self.mCollectionView = tCollectionView;
}

- (void)reloadCollectionView
{
    [self.mCollectionView reloadData];
}

#pragma mark --- CollectionDelegate
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 42;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    ELCalendarCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ELCalendarCell" forIndexPath:indexPath];
    [cell refreshCell:[self riqi:indexPath]];
    return cell;
}

- (NSDictionary *)riqi:(NSIndexPath *)indexPath
{
    NSInteger daysInThisMonth = [ELCalendarEngine totaldaysInMonth:_date];
    NSInteger firstWeekday = [ELCalendarEngine firstWeekdayInThisMonth:_date];
    
    NSInteger daysInLastMouth = [ELCalendarEngine totaldaysInMonth:[ELCalendarEngine lastMonth:_date]];
    
    NSInteger day = 0;
    NSInteger i = indexPath.row;
    
    if (i < firstWeekday) // 前月日期
    {
        return @{@"string":[NSString stringWithFormat:@"%ld",(daysInLastMouth-firstWeekday+i+1)],
                 @"color":[UIColor grayColor]};
    }
    else if (i > firstWeekday + daysInThisMonth - 1)
    {
        if ((firstWeekday + daysInThisMonth - 1)/7 < i/7)
        {
            return @{@"string":@"",
                     @"color":[UIColor clearColor]};
        }
        else
        {
            return @{@"string":[NSString stringWithFormat:@"%ld",(i-(firstWeekday + daysInThisMonth - 1))],
                     @"color":[UIColor grayColor]};
        }
    }
    else
    {
        day = i - firstWeekday + 1;
        
        if ([ELCalendarEngine year:_today] == [ELCalendarEngine year:_date] && [ELCalendarEngine month:_today] == [ELCalendarEngine month:_date] && [ELCalendarEngine day:_today] == [ELCalendarEngine day:_date]) {
            if (day == [ELCalendarEngine day:_date])
            {
                return @{@"string":[NSString stringWithFormat:@"%ld",day],
                         @"color":[UIColor redColor]};
            }
        }
        return @{@"string":[NSString stringWithFormat:@"%ld",day],
                        @"color":[UIColor blackColor]};
    }
}

#pragma mark --

@end
