//
//  ELCalendarView.h
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ELCalendarViewDelegate <NSObject>

- (void)selectedDate:(NSString *)date;

@end

@interface ELCalendarView : UIView

@property (nonatomic, assign) id<ELCalendarViewDelegate> delegate;

- (void)refreshUI;

@end
