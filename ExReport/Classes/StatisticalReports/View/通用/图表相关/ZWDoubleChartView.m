//
//  ZWDoubleChartView.m
//  Muck
//
//  Created by 张威 on 2018/9/6.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWDoubleChartView.h"

@interface ZWDoubleChartView ()

@property (strong, nonatomic) UILabel *legendLab1;
@property (nonatomic, strong) UILabel *legendLab2;
@property (nonatomic, strong) UIView *legendView1;
@property (nonatomic, strong) UIView *legendView2;
@property (nonatomic, strong) UIView *bar1;


@end

@implementation ZWDoubleChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI
{
    self.titleLabel = [[UILabel alloc] init];
    [self addSubview:self.titleLabel];
    
    self.legendLab1 = [[UILabel alloc] init];
    self.legendLab2 = [[UILabel alloc] init];
    self.legendView1 = [[UIView alloc] init];
    self.legendView2 = [[UIView alloc] init];
    
    [self addSubview:self.legendLab1];
    [self addSubview:self.legendLab2];
    [self addSubview:self.legendView1];
    [self addSubview:self.legendView2];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.top.equalTo(self).offset(kWidth(30));
    }];
    
}

@end










