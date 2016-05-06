//
//  ELCalendarCell.h
//  CalendarDemo
//
//  Created by EL-Dev-02 on 16/4/14.
//  Copyright © 2016年 科技有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ELCalendarModel;
@interface ELCalendarCell : UICollectionViewCell

- (void)refreshCell:(NSDictionary *)dic;

- (void)refreshCellWithModel:(ELCalendarModel *)model;

- (void)backToNormal;

@end
