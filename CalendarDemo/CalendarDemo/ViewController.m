//
//  ViewController.m
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import "ViewController.h"
#import "ELCalendarView.h"

#define DEVICE_SIZE [UIScreen mainScreen].bounds.size

@interface ViewController ()<ELCalendarViewDelegate>
@property (nonatomic, weak) UILabel *display;
@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    ELCalendarView *calendar = [[ELCalendarView alloc]initWithFrame:CGRectMake(0, 100, DEVICE_SIZE.width, DEVICE_SIZE.width+30)];
    calendar.today = [NSDate date];
    calendar.date = [NSDate date];
    calendar.delegate = self;
    [calendar refreshUI];
    [self.view addSubview:calendar];
    
    UILabel *display = [[UILabel alloc]initWithFrame:CGRectMake(0, 25, DEVICE_SIZE.width, 50)];
    [self.view addSubview:display];
    self.display = display;
    
}

#pragma mark --- ELCalendarViewDelegate
- (void)selectedDate:(NSString *)date
{
    self.display.text = date;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
