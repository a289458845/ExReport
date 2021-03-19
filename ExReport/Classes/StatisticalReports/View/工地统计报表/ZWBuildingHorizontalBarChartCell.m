//
//  ZWBuildingHorizontalBarChartCell.m
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWBuildingHorizontalBarChartCell.h"
#import "ZWHorizontalBarChartView.h"

@interface ZWBuildingHorizontalBarChartCell ()

@property (strong, nonatomic) ZWHorizontalBarChartView *barChart;
@end

@implementation ZWBuildingHorizontalBarChartCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {

        [self initUI];
    }
    return self;
}

- (void)initUI{

    
}

- (void)setStatues:(ZWAlarmStatues *)statues{
    _statues = statues;
    if (self.barChart) {
        [self.barChart removeFromSuperview];
        self.barChart = nil;
    }
    
    self.barChart = [[ZWHorizontalBarChartView alloc] init];
    [self.contentView addSubview:self.barChart];

    self.barChart.xArray = statues.xArray;
    self.barChart.yValueArray = statues.yValueArray;
    self.barChart.yValueMax = statues.valueRange.y;
    self.barChart.yValueMin = statues.valueRange.x;
    self.barChart.legendNameArray = statues.legendNameArray;
    
    [self.barChart mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.contentView).valueOffset([NSValue valueWithUIEdgeInsets:UIEdgeInsetsMake(10, 10, 10, 10)]);
        make.height.mas_offset(topMargin+statues.xArray.count*xLabelHeight+yLabelHeight);
    }];
    
    [self.barChart updateChart];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
