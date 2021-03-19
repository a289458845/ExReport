//
//  ZWStatisticalBarChartTableViewCell.m
//  Muck
//
//  Created by 张威 on 2018/8/8.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWStatisticalBarChartTableViewCell.h"
#import "ZWBarChartView.h"

@interface ZWStatisticalBarChartTableViewCell ()

@property (nonatomic, strong) ZWBarChartView *barChartView;

@end

@implementation ZWStatisticalBarChartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
//    self.i.frame = self.bounds;
}

- (void)setStatues:(ZWAlarmStatues *)statues
{
    _statues = statues;
    
    if (self.barChartView) {
        [self.barChartView removeFromSuperview];
        self.barChartView = nil;
    }
    
    self.barChartView = [[ZWBarChartView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    [self.contentView addSubview:self.barChartView];
    
    self.barChartView.xArray = statues.xArray;
    self.barChartView.yValueArray = statues.yValueArray;
    self.barChartView.yValueMax = statues.valueRange.y;
    self.barChartView.yValueMin = statues.valueRange.x;
    self.barChartView.legendName = statues.legendName;
    
    [self.barChartView updateChart];
    
}

@end



