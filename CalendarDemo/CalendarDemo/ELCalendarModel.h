//
//  ELCalendarModel.h
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/15.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef enum : NSUInteger {
    DayEventTypeNone,
    DayEventTypeUnblockDay,
    DayEventTypeRepaymentDay,
    DayEventTypeDateDueDay,
    DayEventTypeDouble,
    DayEventTypeTriple,
} DayEventType;

@interface ELCalendarModel : NSObject

@property (nonatomic, assign) DayEventType dayType;

@end
