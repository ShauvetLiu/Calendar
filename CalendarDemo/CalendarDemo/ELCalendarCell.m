//
//  ELCalendarCell.m
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import "ELCalendarCell.h"
#import "ELCalendarModel.h"

@interface ELCalendarCell()
@property (nonatomic , weak) UILabel *dateLabel;
@property (nonatomic, strong) UIColor *backColor;
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

- (void)backToNormal
{
    self.backgroundColor = self.backColor;
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

- (void)refreshCellWithModel:(ELCalendarModel *)model
{
    switch (model.dayType) {
        case 0:
            self.backgroundColor = [UIColor cyanColor];
            self.backColor = [UIColor cyanColor];
            break;
        case 1:
            self.backgroundColor = [UIColor whiteColor];
            self.backColor = [UIColor whiteColor];
            break;
        case 2:
            self.backgroundColor = [UIColor greenColor];
            self.backColor = [UIColor greenColor];
            break;
        case 3:
            self.backgroundColor = [UIColor blueColor];
            self.backColor = [UIColor blueColor];
            break;
        case 4:
            self.backgroundColor = [UIColor yellowColor];
            self.backColor = [UIColor yellowColor];
            break;
        case 5:
            self.backgroundColor = [UIColor lightGrayColor];
            self.backColor = [UIColor lightGrayColor];
            break;
        default:
            break;
    }
}

@end
