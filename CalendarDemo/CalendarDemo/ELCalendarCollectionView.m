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
#import "ELCalendarModel.h"

@interface ELCalendarCollectionView()<UICollectionViewDelegateFlowLayout,UICollectionViewDataSource>
@property (nonatomic, weak) UICollectionView *mCollectionView;
@property (nonatomic, strong) NSMutableArray *dateArray;

@end

@implementation ELCalendarCollectionView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        NSArray *array = @[@(DayEventTypeNone),
                           @(DayEventTypeUnblockDay),
                           @(DayEventTypeRepaymentDay),
                           @(DayEventTypeDateDueDay),
                           @(DayEventTypeDouble),
                           @(DayEventTypeTriple)];
        self.dateArray = [NSMutableArray array];
        for (int i = 0; i<50; i++) {
            ELCalendarModel *model = [[ELCalendarModel alloc]init];
            model.dayType = [array[arc4random()%6] integerValue];
            [self.dateArray addObject:model];
        }
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
    if (indexPath.row >= [ELCalendarEngine firstWeekdayInThisMonth:_date] && indexPath.row <= [ELCalendarEngine totaldaysInMonth:_date] + [ELCalendarEngine firstWeekdayInThisMonth:_date]) {
        [cell refreshCellWithModel:self.dateArray[indexPath.row - [ELCalendarEngine firstWeekdayInThisMonth:_date] + 1]];
    }
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
        
        if ([ELCalendarEngine year:_today] == [ELCalendarEngine year:_date] && [ELCalendarEngine month:_today] == [ELCalendarEngine month:_date]) {
            if (day == [ELCalendarEngine day:_today])
            {
                return @{@"string":[NSString stringWithFormat:@"%ld",day],
                         @"color":[UIColor redColor]};
            }else
            {
                return @{@"string":[NSString stringWithFormat:@"%ld",day],
                         @"color":[UIColor blackColor]};
            }
        }
        else
        {
            return @{@"string":[NSString stringWithFormat:@"%ld",day],
                     @"color":[UIColor blackColor]};
        }
    }
}

#pragma mark --
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    NSString *dateString = [ELCalendarEngine dateOfIndex:indexPath.row date:self.date];
    switch ([ELCalendarEngine compareDate:self.date withNewDateString:dateString])
    {
        case 0:
            break;
        case 1:
            if ([ELCalendarEngine needRefreshCollectionViewWithDate:[ELCalendarEngine nextMonth:self.date]])
            {
                self.date = [ELCalendarEngine nextMonth:self.date];
                [self reloadCollectionView];
            }
            else
            {
                return;
            }
            break;
        case -1:
            if ([ELCalendarEngine needRefreshCollectionViewWithDate:[ELCalendarEngine lastMonth:self.date]])
            {
                self.date = [ELCalendarEngine lastMonth:self.date];
                [self reloadCollectionView];
            }
            else
            {
                return;
            }
            break;
        default:
            break;
    };
    ELCalendarCell *cell = (ELCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor redColor];
    if (self.delegate && [self.delegate respondsToSelector:@selector(didSelectedCellToTransferTheDate:)])
    {
        [self.delegate didSelectedCellToTransferTheDate:dateString];
    }
}
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    ELCalendarCell *cell = (ELCalendarCell *)[collectionView cellForItemAtIndexPath:indexPath];
    [cell backToNormal];
}

@end
