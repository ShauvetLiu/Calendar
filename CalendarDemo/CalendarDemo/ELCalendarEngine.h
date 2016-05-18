//
//  ELCalendarEngine.h
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

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

/**
 *  根据结束日期和开始日期 判断是否需要刷新
 */
+ (BOOL)needRefreshCollectionViewWithDate:(NSDate *)date withStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate;

/**
 *  根据选择日期，当前日历日期和cell的indexPath来判断是否是选中的状态
 */
+ (BOOL)isSelectedDate:(NSDate *)selectedDate date:(NSDate *)date indexPath:(NSIndexPath *)indexPath;

/**
 *  选中cell，通过当前日历日期和选中的indexPath，计算出选择的日期
 */
+ (NSDate *)dateByIndexPath:(NSIndexPath *)indexPath inDate:(NSDate *)date;

/**
 *  根据记录的选择的日期和当前日历的日期，返回选中的日期在当前日历中的indexPath
 */
+ (NSIndexPath *)indexPathBySelectedDate:(NSDate *)selectedDate inDate:(NSDate *)date;

@end
