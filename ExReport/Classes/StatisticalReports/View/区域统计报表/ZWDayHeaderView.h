//
//  ZWDayHeaderView.h
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWDayWeekMonthView.h"

@protocol ZWDayHeaderViewDelegate<NSObject>

- (void)dayHeaderViewSelectedIndex:(NSInteger )index;
@end

@interface ZWDayHeaderView : UIView

@property (nonatomic) ZWDayWeekMonthType type;

@property (weak, nonatomic) id <ZWDayHeaderViewDelegate>delegate;


@property (copy, nonatomic)void(^didSelectTimeBlock)(void);

@property (copy, nonatomic)NSString *timeString;
@end
