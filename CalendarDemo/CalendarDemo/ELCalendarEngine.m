//
//  ELCalendarEngine.m
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import "ELCalendarEngine.h"

@implementation ELCalendarEngine

+ (NSInteger)day:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear |
                                                                             NSCalendarUnitMonth |
                                                                             NSCalendarUnitDay)
                                                                   fromDate:date];
    return [components day];
}

+ (NSInteger)month:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear |
                                                                             NSCalendarUnitMonth |
                                                                             NSCalendarUnitDay)
                                                                   fromDate:date];
    return [components month];
}

+ (NSInteger)year:(NSDate *)date
{
    NSDateComponents *components = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear |
                                                                             NSCalendarUnitMonth |
                                                                             NSCalendarUnitDay)
                                                                   fromDate:date];
    return [components year];
}


+ (NSInteger)firstWeekdayInThisMonth:(NSDate *)date
{
    NSCalendar *calendar = [NSCalendar currentCalendar];
    
    [calendar setFirstWeekday:1];//1.Sun. 2.Mon. 3.Thes. 4.Wed. 5.Thur. 6.Fri. 7.Sat.
    NSDateComponents *comp = [calendar components:(NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay) fromDate:date];
    [comp setDay:1];
    NSDate *firstDayOfMonthDate = [calendar dateFromComponents:comp];
    
    NSUInteger firstWeekday = [calendar ordinalityOfUnit:NSCalendarUnitWeekday inUnit:NSCalendarUnitWeekOfMonth forDate:firstDayOfMonthDate];
    return firstWeekday - 1;
}

+ (NSInteger)totaldaysInThisMonth:(NSDate *)date
{
    NSRange totaldaysInMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return totaldaysInMonth.length;
}

+ (NSInteger)totaldaysInMonth:(NSDate *)date
{
    NSRange daysInLastMonth = [[NSCalendar currentCalendar] rangeOfUnit:NSCalendarUnitDay inUnit:NSCalendarUnitMonth forDate:date];
    return daysInLastMonth.length;
}

+ (NSDate *)lastMonth:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = -1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

+ (NSDate*)nextMonth:(NSDate *)date
{
    NSDateComponents *dateComponents = [[NSDateComponents alloc] init];
    dateComponents.month = +1;
    NSDate *newDate = [[NSCalendar currentCalendar] dateByAddingComponents:dateComponents toDate:date options:0];
    return newDate;
}

+ (NSString *)dateOfIndex:(NSInteger)index date:(NSDate *)date
{
    NSInteger firstWeekDay = [self firstWeekdayInThisMonth:date];
    NSInteger day = index - firstWeekDay + 1;
    NSCalendar *calendar = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [calendar components:(NSCalendarUnitYear |
                                                             NSCalendarUnitMonth |
                                                             NSCalendarUnitDay)
                                                   fromDate:date];
    dateComponents.year = [self year:date];
    if (day < 1)
    {
        dateComponents.month = [self month:date]-1;
        dateComponents.day = [ELCalendarEngine totaldaysInMonth:[ELCalendarEngine lastMonth:date]] + day;
    }
    else if(day > [ELCalendarEngine totaldaysInMonth:date])
    {
        dateComponents.month = [self month:date]+1;
        dateComponents.day = day - [ELCalendarEngine totaldaysInMonth:date];
    }
    else
    {
        dateComponents.month = [self month:date];
        dateComponents.day = day;
    }
    NSDate *newDate = [calendar dateFromComponents:dateComponents];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    return [dateFormatter stringFromDate:newDate];
}

+ (NSInteger)compareDate:(NSDate *)date withNewDateString:(NSString *)string
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *newDate = [dateFormatter dateFromString:string];
    if ([self month:date] == 12) {
        if ([self month:newDate] == 1) {
            return 1;
        }
        if ([self month:newDate] == 11) {
            return -1;
        }
        if ([self month:newDate] == 12) {
            return 0;
        }
    }
    if ([self month:date] == 1) {
        if ([self month:newDate] == 2) {
            return 1;
        }
        if ([self month:newDate] == 12) {
            return -1;
        }
        if ([self month:newDate] == 1) {
            return 0;
        }
    }
    if ([self month:newDate] < [self month:date])
    {
        return -1;
    }
    else if ([self month:newDate] > [self month:date])
    {
        return 1;
    }
    else
    {
        return 0;
    }

}

+ (BOOL)needRefreshCollectionViewWithDate:(NSDate *)date
{
    NSDateComponents *componentNow = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear |
                                                                               NSCalendarUnitMonth |
                                                                               NSCalendarUnitDay)
                                                                     fromDate:[NSDate date]];
    NSDateComponents *component = [[NSCalendar currentCalendar] components:(NSCalendarUnitYear |
                                                                            NSCalendarUnitMonth |
                                                                            NSCalendarUnitDay)
                                                                  fromDate:date];
    
    if (componentNow.month == 12)
    {
        if (component.month == 1 || component.month == 11)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else if (componentNow.month == 1)
    {
        if (component.month == 12 || component.month == 3)
        {
            return YES;
        }
        else
        {
            return NO;
        }
    }
    else if ((componentNow.month - component.month) == 1 ||
             (componentNow.month - component.month) == -1 ||
             (componentNow.month - component.month) == 0)
    {
        return YES;
    }
    else
    {
        return NO;
    }
}

+ (BOOL)needRefreshCollectionViewWithDate:(NSDate *)date withStartDate:(NSDate *)startDate andEndDate:(NSDate *)endDate
{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM";
    NSDate *currentDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:date]];
    NSDate *beginDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:startDate]];
    NSDate *overDate = [dateFormatter dateFromString:[dateFormatter stringFromDate:endDate]];
    
    if ([currentDate compare:beginDate] == NSOrderedAscending) {
        return NO;
    }
    if ([currentDate compare:overDate] == NSOrderedDescending) {
        return NO;
    }
    return YES;
}

+ (BOOL)isSelectedDate:(NSDate *)selectedDate date:(NSDate *)date indexPath:(NSIndexPath *)indexPath
{
    
    if ([self year:selectedDate] == [self year:date] && [self month:date] == [self month:selectedDate]) {
        NSInteger firstWeekDay = [self firstWeekdayInThisMonth:date];
        NSInteger selectedDay = [self day:selectedDate];
        if ( indexPath.row - firstWeekDay + 1 == selectedDay ) {
            return YES;
        }else
        {
            return NO;
        }
    }else
    {
        return NO;
    }
}

+ (NSDate *)dateByIndexPath:(NSIndexPath *)indexPath inDate:(NSDate *)date
{
    NSInteger firstWeekDay = [self firstWeekdayInThisMonth:date];
    NSInteger day = indexPath.row - firstWeekDay + 1;
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    dateFormatter.dateFormat = @"yyyy-MM-dd";
    NSDate *newDate = [dateFormatter dateFromString:[NSString stringWithFormat:@"%ld-%ld-%ld",[self year:date],[self month:date],day]];
    return newDate;
}

+ (NSIndexPath *)indexPathBySelectedDate:(NSDate *)selectedDate inDate:(NSDate *)date
{
    NSInteger firstWeekDay = [self firstWeekdayInThisMonth:date];
    NSInteger index = [self day:selectedDate] + firstWeekDay - 1;
    NSIndexPath *indexPath = [NSIndexPath indexPathForRow:index inSection:0];
    return indexPath;
}


@end
