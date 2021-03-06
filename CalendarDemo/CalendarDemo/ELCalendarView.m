//
//  ELCalendarView.m
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import "ELCalendarView.h"
#import "ELCalendarCollectionView.h"
#import "ELCalendarEngine.h"

@interface ELCalendarView()<ELCalendarCollectionViewDelegate>
@property (nonatomic, strong) NSDate *date;
@property (nonatomic, strong) NSDate *today;
@property (nonatomic, strong) NSArray *mWeekArray;
@property (nonatomic, weak) ELCalendarCollectionView *mCalendarCollectionView;
@property (nonatomic, weak) UILabel *mCurrentMonth;
@property (nonatomic, weak) UIButton *nextMonthBtn;
@property (nonatomic, weak) UIButton *lastMonthBtn;
@end

@implementation ELCalendarView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.mWeekArray = @[@"日",@"一",@"二",@"三",@"四",@"五",@"六"];
        self.today = [NSDate date];
        self.date = [NSDate date];
        [self createUI];
    }
    return self;
}

- (void)createUI
{
    [self topView];
    
    for (int i = 0; i<7; i++) {
        UILabel *weekLabel = [[UILabel alloc]initWithFrame:CGRectMake(self.bounds.size.width/7*i, 30, self.bounds.size.width/7, (self.bounds.size.height-30)/7)];
        weekLabel.text = self.mWeekArray[i];
        weekLabel.backgroundColor = [UIColor lightGrayColor];
        weekLabel.textAlignment = NSTextAlignmentCenter;
        [self addSubview:weekLabel];
    }
    
    ELCalendarCollectionView *calendar = [[ELCalendarCollectionView alloc]initWithFrame:CGRectMake(0, 30+((self.bounds.size.height-30)/7), self.bounds.size.width, ((self.bounds.size.height-30)/7)*6)];
    calendar.delegate = self;
    [self addSubview:calendar];
    self.mCalendarCollectionView = calendar;
    
}

- (void)topView
{
    
    UIView *topView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, self.bounds.size.width, 30)];
    topView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
    [self addSubview:topView];
    
    UIButton *lastMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    lastMonth.frame = CGRectMake(0, 0, 100, 30);
    lastMonth.layer.cornerRadius = 6;
    lastMonth.layer.masksToBounds = YES;
    [lastMonth setTitle:@"上一月" forState:UIControlStateNormal];
    lastMonth.backgroundColor = [UIColor colorWithRed:1.0 green:165/255.0 blue:2/255.0 alpha:1.0];
    [lastMonth addTarget:self action:@selector(lastMonth) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:lastMonth];
    self.lastMonthBtn = lastMonth;
    
    UIButton *nextMonth = [UIButton buttonWithType:UIButtonTypeCustom];
    nextMonth.frame = CGRectMake(self.bounds.size.width-100, 0, 100, 30);
    nextMonth.layer.cornerRadius = 6;
    nextMonth.layer.masksToBounds = YES;
    [nextMonth setTitle:@"下一月" forState:UIControlStateNormal];
    nextMonth.backgroundColor = [UIColor colorWithRed:1.0 green:165/255.0 blue:2/255.0 alpha:1.0];
    [nextMonth addTarget:self action:@selector(nextMonth) forControlEvents:UIControlEventTouchUpInside];
    [topView addSubview:nextMonth];
    self.nextMonthBtn = nextMonth;
    
    UILabel *currentMonth = [[UILabel alloc]initWithFrame:CGRectMake(100, 0, self.bounds.size.width-200, 30)];
    currentMonth.textAlignment = NSTextAlignmentCenter;
    [topView addSubview:currentMonth];
    self.mCurrentMonth = currentMonth;
}

- (void)refreshUI
{
    self.mCalendarCollectionView.date = self.date;
    self.mCalendarCollectionView.today = self.today;
    [self.mCalendarCollectionView reloadCollectionView];
    self.mCurrentMonth.text = [NSString stringWithFormat:@"%ld年%ld月",[ELCalendarEngine year:self.date],[ELCalendarEngine month:self.date]];
}

- (void)lastMonth
{
    if ([ELCalendarEngine needRefreshCollectionViewWithDate:[ELCalendarEngine lastMonth:self.date]])
    {
        self.date = [ELCalendarEngine lastMonth:self.date];
        self.mCurrentMonth.text = [NSString stringWithFormat:@"%ld年%ld月",[ELCalendarEngine year:self.date],[ELCalendarEngine month:self.date]];
        self.mCalendarCollectionView.date = self.date;
        [self.mCalendarCollectionView reloadCollectionView];
        if (![ELCalendarEngine needRefreshCollectionViewWithDate:[ELCalendarEngine lastMonth:self.date]]) {
            self.lastMonthBtn.userInteractionEnabled = NO;
            self.lastMonthBtn.backgroundColor = [UIColor grayColor];
            self.nextMonthBtn.userInteractionEnabled = YES;
            self.nextMonthBtn.backgroundColor = [UIColor colorWithRed:1.0 green:165/255.0 blue:2/255.0 alpha:1.0];
        }
        if ([ELCalendarEngine needRefreshCollectionViewWithDate:[ELCalendarEngine nextMonth:self.date]]) {
            self.nextMonthBtn.userInteractionEnabled = YES;
            self.nextMonthBtn.backgroundColor = [UIColor colorWithRed:1.0 green:165/255.0 blue:2/255.0 alpha:1.0];
        }
    }
    else
    {
        return;
    }
}

- (void)nextMonth
{
    if ([ELCalendarEngine needRefreshCollectionViewWithDate:[ELCalendarEngine nextMonth:self.date]])
    {
        self.date = [ELCalendarEngine nextMonth:self.date];
        self.mCurrentMonth.text = [NSString stringWithFormat:@"%ld年%ld月",[ELCalendarEngine year:self.date],[ELCalendarEngine month:self.date]];
        self.mCalendarCollectionView.date = self.date;
        [self.mCalendarCollectionView reloadCollectionView];
        if (![ELCalendarEngine needRefreshCollectionViewWithDate:[ELCalendarEngine nextMonth:self.date]]) {
            self.nextMonthBtn.userInteractionEnabled = NO;
            self.nextMonthBtn.backgroundColor = [UIColor grayColor];
            self.lastMonthBtn.userInteractionEnabled = YES;
            self.lastMonthBtn.backgroundColor = [UIColor colorWithRed:1.0 green:165/255.0 blue:2/255.0 alpha:1.0];
        }
        if ([ELCalendarEngine needRefreshCollectionViewWithDate:[ELCalendarEngine lastMonth:self.date]]) {
            self.lastMonthBtn.userInteractionEnabled = YES;
            self.lastMonthBtn.backgroundColor = [UIColor colorWithRed:1.0 green:165/255.0 blue:2/255.0 alpha:1.0];
        }
    }
    else
    {
        return;
    }
    
}

#pragma mark --- ELCalendarCollectionViewDelegate
- (void)didSelectedCellToTransferTheDate:(NSString *)date
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    self.date = [dateFormatter dateFromString:date];
    self.mCurrentMonth.text = [NSString stringWithFormat:@"%ld年%ld月",[ELCalendarEngine year:self.date],[ELCalendarEngine month:self.date]];
    
    if ([ELCalendarEngine needRefreshCollectionViewWithDate:[ELCalendarEngine nextMonth:self.date]]) {
        self.nextMonthBtn.userInteractionEnabled = YES;
        self.nextMonthBtn.backgroundColor = [UIColor colorWithRed:1.0 green:165/255.0 blue:2/255.0 alpha:1.0];
        if ([ELCalendarEngine needRefreshCollectionViewWithDate:[ELCalendarEngine lastMonth:self.date]]) {
            self.lastMonthBtn.userInteractionEnabled = YES;
            self.lastMonthBtn.backgroundColor = [UIColor colorWithRed:1.0 green:165/255.0 blue:2/255.0 alpha:1.0];
        }else
        {
            self.lastMonthBtn.userInteractionEnabled = NO;
            self.lastMonthBtn.backgroundColor = [UIColor grayColor];

        }
    }else
    {
        self.nextMonthBtn.userInteractionEnabled = NO;
        self.nextMonthBtn.backgroundColor = [UIColor grayColor];
        if ([ELCalendarEngine needRefreshCollectionViewWithDate:[ELCalendarEngine lastMonth:self.date]]) {
            self.lastMonthBtn.userInteractionEnabled = YES;
            self.lastMonthBtn.backgroundColor = [UIColor colorWithRed:1.0 green:165/255.0 blue:2/255.0 alpha:1.0];
        }else
        {
            self.lastMonthBtn.userInteractionEnabled = NO;
            self.lastMonthBtn.backgroundColor = [UIColor grayColor];
            
        }
    }
    
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectedDate:)]) {
        [self.delegate selectedDate:date];
    }
}

@end
