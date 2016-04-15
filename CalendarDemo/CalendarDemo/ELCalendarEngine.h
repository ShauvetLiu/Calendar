//
//  ELCalendarEngine.h
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELCalendarEngine : NSObject

+ (NSInteger)day:(NSDate *)date;

+ (NSInteger)month:(NSDate *)date;

+ (NSInteger)year:(NSDate *)date;

+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

+ (NSInteger)totaldaysInThisMonth:(NSDate *)date;

+ (NSInteger)totaldaysInMonth:(NSDate *)date;

+ (NSDate *)lastMonth:(NSDate *)date;

+ (NSDate*)nextMonth:(NSDate *)date;

+ (NSString *)dateOfIndex:(NSInteger)index date:(NSDate *)date;

+ (NSInteger)compareDate:(NSDate *)date withNewDateString:(NSString *)string;

@end
