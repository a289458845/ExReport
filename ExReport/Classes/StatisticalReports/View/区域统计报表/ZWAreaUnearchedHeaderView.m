//
//  ZWAreaUnearchedHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/2.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWAreaUnearchedHeaderView.h"
#import "ZWLineChartView.h"

@interface ZWAreaUnearchedHeaderView ()

@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *nameLabel;
@property (nonatomic, strong) ZWLineChartView *lineChart;


@end

@implementation ZWAreaUnearchedHeaderView

// Type  1=昨日 2=今日 3=本周 4=本月 5=时间段 6=上周

- (void)setTimeType:(NSInteger)timeType{
    _timeType = timeType;
    switch (timeType) {
        case 2:{
            if (self.controllerType == ZWAreaUnearthedController) {
                _nameLabel.text = @"最近7天出土量(立方)";
            }else{
                _nameLabel.text = @"最近7天消纳量(立方)";
            }
            break;
        }
        case 3:{
            if (self.controllerType == ZWAreaUnearthedController) {
                _nameLabel.text = @"本周出土量(立方)";
            }else{
                _nameLabel.text = @"本周消纳量(立方)";
            }
            break;
        }
        case 4:{
            if (self.controllerType == ZWAreaUnearthedController) {
                _nameLabel.text = @"本月出土量(立方)";
            }else{
                _nameLabel.text = @"本月消纳量(立方)";
            }
            break;
        }
        case 5:{
            if (self.controllerType == ZWAreaUnearthedController) {
                _nameLabel.text = [NSString stringWithFormat:@"%@到%@出土量(立方)",self.beginTime,self.endTime];
            }else{
                _nameLabel.text =  [NSString stringWithFormat:@"%@到%@消纳量(立方)",self.beginTime,self.endTime];
            }
            break;
        }
        default:
            break;
    }
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;

}


- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [touches.anyObject locationInView:self];
    if (point.y >= kWidth(30) && point.y <= kWidth(30)+18) {
        if (self.didSelectTimeBlock) {
            self.didSelectTimeBlock();
        }
    }
  
}
- (void)initUI
{
    self.backgroundColor = COLORWITHHEX(kColor_3A62AC);
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = kSystemFont(28);
    self.timeLabel.textColor = [UIColor whiteColor];

    [self addSubview:self.timeLabel];
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"commonreport_optiondate_pulldown_icon"];
    [self addSubview:img];
    
    self.nameLabel = [[UILabel alloc] init];
    self.nameLabel.font = kSystemFont(28);
    self.nameLabel.textColor = COLORWITHHEX(kColor_D9DCE3);
    [self addSubview:self.nameLabel];
    
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kWidth(30));
//        make.top.equalTo(self).offset(kWidth(30));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kWidth(30));
        make.right.equalTo(img.mas_left).offset(-kWidth(6));
        make.centerY.equalTo(img);
    }];
    
    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(30));
        make.top.equalTo(self.timeLabel.mas_bottom).offset(kWidth(40));
    }];
}


- (void)setStatues:(ZWAlarmStatues *)statues
{
    _statues = statues;
    
    if (self.lineChart) {
        [self.lineChart removeFromSuperview];
        self.lineChart = nil;
    }
    
    self.lineChart = [[ZWLineChartView alloc] initWithFrame:CGRectMake(0, kWidth(150), kScreenWidth, kWidth(240))];
    [self addSubview:self.lineChart];
    
    self.lineChart.xColor = [UIColor whiteColor];
    self.lineChart.yColor = [UIColor whiteColor];
    self.lineChart.lineColor = [UIColor whiteColor];
    self.lineChart.yPointColor = [UIColor whiteColor];
    self.lineChart.maskColor = [UIColor whiteColor];
    
    self.lineChart.xArray = statues.xArray;
    self.lineChart.yValueArray = statues.yValueArray;
    self.lineChart.yValueMax = statues.valueRange.y;
    self.lineChart.yValueMin = statues.valueRange.x;

    [self.lineChart updateChart];
}


- (void)setTimeString:(NSString *)timeString{
    _timeString = timeString;
    _timeLabel.text = timeString;
}
@end






