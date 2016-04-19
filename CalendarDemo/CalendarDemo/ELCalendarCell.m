//
//  ELCalendarCell.m
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import "ELCalendarCell.h"

@interface ELCalendarCell()
@property (nonatomic , weak) UILabel *dateLabel;
@end

@implementation ELCalendarCell

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame])
    {
        self.selectedBackgroundView.backgroundColor = [UIColor redColor];
        [self setUpUI];
    }
    return self;
}

- (void)setUpUI
{
    self.backgroundColor = [UIColor orangeColor];
    self.layer.borderColor = [UIColor grayColor].CGColor;
    self.layer.borderWidth = 1;
    UILabel *dateLabel = [[UILabel alloc] initWithFrame:self.bounds];
    [dateLabel setTextAlignment:NSTextAlignmentCenter];
    [dateLabel setFont:[UIFont systemFontOfSize:17]];
    [self addSubview:dateLabel];
    self.dateLabel = dateLabel;
}

- (void)refreshCell:(NSDictionary *)dic
{
    self.backgroundColor = [UIColor orangeColor];
    [self.dateLabel setText:dic[@"string"]];
    [self.dateLabel setTextColor:dic[@"color"]];
}

@end
