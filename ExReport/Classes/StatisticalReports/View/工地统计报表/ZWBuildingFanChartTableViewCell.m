//
//  ZWBuildingFanChartTableViewCell.m
//  Muck
//
//  Created by 张威 on 2018/8/13.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWBuildingFanChartTableViewCell.h"
#import "ZWFanChartView.h"

@interface ZWBuildingFanChartTableViewCell ()

@property (strong, nonatomic) ZWFanChartView *fanChartView;

@end

@implementation ZWBuildingFanChartTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
    }
    return self;
}

- (void)setData:(NSDictionary *)data
{
    _data = data;
    
    if (self.fanChartView) {
        [self.fanChartView removeFromSuperview];
        self.fanChartView = nil;
    }
    
    self.fanChartView = [[ZWFanChartView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, 250)];
    
    self.fanChartView.valueArray = data.allValues;
    self.fanChartView.colorArray = @[COLORWITHHEX(kColor_5490EB),COLORWITHHEX(kColor_1FCE9B)];
    self.fanChartView.valueNameArray = data.allKeys;
    
    [self.fanChartView updateChart];
    [self.contentView addSubview:self.fanChartView];
    
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
