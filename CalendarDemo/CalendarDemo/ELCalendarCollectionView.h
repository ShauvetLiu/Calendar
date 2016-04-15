//
//  ELCalendarView.h
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ELCalendarCollectionViewDelegate <NSObject>

- (void)didSelectedCellToTransferTheDate:(NSString *)date;

@end

@interface ELCalendarCollectionView : UIView
@property (nonatomic, assign) id<ELCalendarCollectionViewDelegate> delegate;
@property (nonatomic , strong) NSDate *date;
@property (nonatomic , strong) NSDate *today;
- (void)reloadCollectionView;
@end
