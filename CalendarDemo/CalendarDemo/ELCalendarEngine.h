//
//  ELCalendarEngine.h
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ELCalendarEngine : NSObject

/**
 *  当前日期（天）
 */
+ (NSInteger)day:(NSDate *)date;

/**
 *  当前日期所在月份
 */
+ (NSInteger)month:(NSDate *)date;

/**
 *  当前日期所在年
 */
+ (NSInteger)year:(NSDate *)date;

/**
 *  当前日期所在月份的第一天是周几
 */
+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date;

/**
 *  当前日期所在月份一共有多少天
 */
+ (NSInteger)totaldaysInThisMonth:(NSDate *)date;

/**
 *  当前日期所在月份一共有多少天
 */
+ (NSInteger)totaldaysInMonth:(NSDate *)date;

/**
 *  根据传入月份返回上一月
 */
+ (NSDate *)lastMonth:(NSDate *)date;

/**
 *  根据传入月份返回下一月
 */
+ (NSDate*)nextMonth:(NSDate *)date;

/**
 *  所选日期通过字符串返回 "yyyy-MM-dd" "2016-4-15"
 */
+ (NSString *)dateOfIndex:(NSInteger)index date:(NSDate *)date;

/**
 *  点击日期判断是当前月、下一月还是上一月
 */
+ (NSInteger)compareDate:(NSDate *)date withNewDateString:(NSString *)string;

/**
 *  判断是否要刷新  需求只显示前后一个月，公三个月份
 */
+ (BOOL)needRefreshCollectionViewWithDate:(NSDate *)date;

@end
