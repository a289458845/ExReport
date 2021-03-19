//
//  ZWCarAlarmInfoHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/27.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarAlarmInfoHeaderView.h"
#import "ZWAlarmBarChartView.h"
#import "ZWSegmentedControl.h"
@interface ZWCarAlarmInfoHeaderView ()
@property(nonatomic,strong)UIView *grayView;
@property(nonatomic,strong)UIView *grayTwoView;
@property(nonatomic,strong)UILabel *nameLabel;
@property (strong, nonatomic)ZWSegmentedControl *segmentedControl;
@property (nonatomic, strong)ZWAlarmBarChartView *chartView;
@end

@implementation ZWCarAlarmInfoHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (ZWSegmentedControl *)segmentedControl{
    MJWeakSelf
    if (!_segmentedControl) {
        _segmentedControl = [[ZWSegmentedControl alloc]init];
        _segmentedControl.didTitleLabBlock = ^(NSInteger titleTag) {
            if (weakSelf.delegate && [weakSelf.delegate respondsToSelector:@selector(ZWCarAlarmInfoHeaderViewDelegateSelectedClick:)]) {
                [weakSelf.delegate ZWCarAlarmInfoHeaderViewDelegateSelectedClick:titleTag];
            }
        };
        [self addSubview:_segmentedControl];
    }
    return _segmentedControl;
}

- (void)initUI{
    self.nameLabel = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left andString:@"报警总次数图表"];
    [self addSubview:self.nameLabel];
    
    self.grayView = [[UIView alloc]init];
    self.grayView.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    [self addSubview:self.grayView];
    self.grayTwoView = [[UIView alloc]init];
    self.grayTwoView.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    [self addSubview:self.grayTwoView];
    
    [self.grayView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(kWidth(20));
    }];
    [self.grayTwoView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.equalTo(self);
        make.height.mas_equalTo(kWidth(20));
    }];
    
    [self.segmentedControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(90));
        make.right.equalTo(self).offset(-kWidth(90));
        make.top.equalTo(self.grayView.mas_bottom).offset(kWidth(30));
        make.height.mas_equalTo(kWidth(80));
    }];

    [self.nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.segmentedControl.mas_bottom).offset(kWidth(60));
        make.left.equalTo(self).offset(kWidth(30));
    }];
    
}

- (void)setStatues:(ZWAlarmStatues *)statues{
    _statues = statues;
    if (self.chartView) {
        [self.chartView removeFromSuperview];
        self.chartView = nil;
    }
    self.chartView = [[ZWAlarmBarChartView alloc] initWithFrame:CGRectMake(0, kWidth(230), kScreenWidth, kWidth(500))];
    [self addSubview:self.chartView];
    
    self.chartView.xArray = statues.xArray;
    self.chartView.yValueArray = statues.yValueArray;
    self.chartView.yValueMin = statues.valueRange.x;
    self.chartView.yValueMax = statues.valueRange.y;
    
    [self.chartView updateChart];
}

@end
