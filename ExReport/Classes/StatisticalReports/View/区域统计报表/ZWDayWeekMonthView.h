//
//  ZWDayWeekMonthView.h
//  Muck
//
//  Created by 张威 on 2018/8/3.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZWDayWeekMonthViewDelegate<NSObject>
@optional
- (void)ZWDayWeekMonthViewSegmentedControlClick:(NSInteger )index;
- (void)ZWDayWeekMonthViewSegmentedControlClick:(NSInteger )index datePeriod:(NSString *)timePeriod beginDate:(NSString *)begin endDate:(NSString *)end;
@end


typedef NS_ENUM(NSInteger, ZWDayWeekMonthType) {
    ZWDayWeekMonth,
    ZWWeekMonth,
};

@interface ZWDayWeekMonthView : UIView

- (instancetype)initWithFrame:(CGRect)frame type:(ZWDayWeekMonthType)type;

@property (strong, nonatomic) UISegmentedControl *segmentedControl;

@property (nonatomic) ZWDayWeekMonthType type;


@property (weak, nonatomic) id<ZWDayWeekMonthViewDelegate >delegate;

@end
