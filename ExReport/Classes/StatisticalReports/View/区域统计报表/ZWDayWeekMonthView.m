//
//  ZWDayWeekMonthView.m
//  Muck
//
//  Created by 张威 on 2018/8/3.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWDayWeekMonthView.h"
#import "UIImage+Color.h"
#import "NSDate+String.h"

static NSString *hhmmss = @"7:00:00";
static NSString *dateFormater = @"yyyy/MM/dd";

@interface ZWDayWeekMonthView ()



@end

@implementation ZWDayWeekMonthView

- (instancetype)initWithFrame:(CGRect)frame type:(ZWDayWeekMonthType)type
{
    if (self = [super initWithFrame:frame]) {
        self.type = type;
    }
    return self;
}

- (void)setType:(ZWDayWeekMonthType)type
{
    _type = type;
    
    [self setupWithType:type];
}

- (void)setupWithType:(ZWDayWeekMonthType)type
{
    NSArray *items;
    if (type == ZWDayWeekMonth) {
        items = @[@"日",@"周",@"月"];
    }
    else if (type == ZWWeekMonth) {
        items = @[@"周",@"月"];
    }
    self.segmentedControl = [[UISegmentedControl alloc] initWithItems:items];
    [self addSubview:self.segmentedControl];
    self.segmentedControl.selectedSegmentIndex = 0;
    self.segmentedControl.tintColor = [UIColor whiteColor];
    
    self.segmentedControl.layer.borderColor = [UIColor whiteColor].CGColor;
    self.segmentedControl.layer.borderWidth = 1;
    self.segmentedControl.layer.cornerRadius = 3;
    self.segmentedControl.layer.masksToBounds = YES;
    
    [self.segmentedControl addTarget:self action:@selector(segmentAction:) forControlEvents:UIControlEventValueChanged];
    [self.segmentedControl setBackgroundImage:[UIImage imageWithColor:COLORWITHHEX(kColor_3A62AC)] forState:UIControlStateNormal barMetrics:UIBarMetricsDefault];
    [self.segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor whiteColor]] forState:UIControlStateSelected barMetrics:UIBarMetricsDefault];
    [self.segmentedControl setBackgroundImage:[UIImage imageWithColor:[UIColor clearColor]] forState:UIControlStateHighlighted barMetrics:UIBarMetricsDefault];
    
    NSDictionary *selectedAttr = @{NSForegroundColorAttributeName:COLORWITHHEX(kColor_3A62AC),NSFontAttributeName:kSystemFont(32)};
    [self.segmentedControl setTitleTextAttributes:selectedAttr forState:UIControlStateSelected];
    
    NSDictionary *normalAttr = @{NSForegroundColorAttributeName:[UIColor whiteColor],NSFontAttributeName:kSystemFont(32)};
    [self.segmentedControl setTitleTextAttributes:normalAttr forState:UIControlStateNormal];
    
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kWidth(20));
        make.left.equalTo(self).offset(kWidth(30));
        make.right.equalTo(self).offset(-kWidth(30));
        make.bottom.equalTo(self).offset(-kWidth(20));
    }];
}

- (void)segmentAction:(UISegmentedControl *)segment{
    
    NSInteger index = segment.selectedSegmentIndex;
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZWDayWeekMonthViewSegmentedControlClick:)]) {
        [self.delegate ZWDayWeekMonthViewSegmentedControlClick:index];
    }
    if ([self.delegate respondsToSelector:@selector(ZWDayWeekMonthViewSegmentedControlClick:datePeriod:beginDate:endDate:)]) {
        NSString *datePeriod;
        NSString *begin;
        NSString *end;
        if (self.type == ZWDayWeekMonth) {
            if (index == 0) {
                //日
                begin = [[NSDate date] stringWithFormatter:dateFormater];
                end = begin;
                datePeriod = [NSString stringWithFormat:@"%@ %@-%@ %@",begin,hhmmss,end,hhmmss];
            }
            if (index == 1) {
                //周
//                begin = [[[NSCalendar currentCalendar] firstDayOfTheWeek] stringWithFormatter:dateFormater];
//                end = [[NSDate date] stringWithFormatter:dateFormater];
//                datePeriod = [NSString stringWithFormat:@""];
            }
            if (index == 2) {
                //月
            }
        }
        if (self.type == ZWWeekMonth) {
            if (index == 0) {
                //周
            }
            if (index == 1) {
                //月
            }
        }
        [self.delegate ZWDayWeekMonthViewSegmentedControlClick:index datePeriod:datePeriod beginDate:begin endDate:end];
    }
}







@end
