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

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    ELCalendarView *calendar = [[ELCalendarView alloc]initWithFrame:CGRectMake(0, 100, DEVICE_SIZE.width, DEVICE_SIZE.width+30)];
    calendar.today = [NSDate date];
    calendar.date = [NSDate date];
    [calendar refreshUI];
    [self.view addSubview:calendar];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end
