//
//  ZWSegmentedControl.m
//  Muck
//
//  Created by 张威 on 2018/8/2.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWSegmentedControl.h"
@interface ZWSegmentedControl ()
@property(nonatomic,strong)UIView *blueView;//蓝色背景
@property(nonatomic,strong)UIView *whiteView;//白色背景
@property(nonatomic,strong)UILabel *leftTitle;//左边标题
@property(nonatomic,strong)UILabel *rightTitle;//右边标题

@end
@implementation ZWSegmentedControl

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
        [self setUpUI];
        [self setupConstraint];
    }
    return self;
}

- (void)setUpUI{
    //蓝色背景
    self.blueView = [[UIView alloc]init];
    self.blueView.backgroundColor = COLORWITHHEX(kColor_5490EB);
    self.blueView.layer.cornerRadius = kWidth(50);
    self.blueView.layer.masksToBounds = YES;
    
    //白色背景
    self.whiteView = [[UIView alloc]init];
    self.whiteView.backgroundColor = COLORWITHHEX(kColor_FFFFFF);
    self.whiteView.layer.cornerRadius = kWidth(50);
    self.whiteView.layer.masksToBounds = YES;
    
    //左边标题
    self.leftTitle = [[UILabel alloc]init];
    self.leftTitle.tag = 1001;
    self.leftTitle.font = kSystemFont(28);
    self.leftTitle.textColor = COLORWITHHEX(kColor_3A62AC);
    self.leftTitle.text = @"每日";
    self.leftTitle.textAlignment = NSTextAlignmentCenter;
    self.leftTitle.userInteractionEnabled = YES;
    UITapGestureRecognizer* leftTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTitle:)];
    [self.leftTitle addGestureRecognizer:leftTap];
    
    //右边标题
    self.rightTitle = [[UILabel alloc]init];
    self.rightTitle.tag = 1002;
    self.rightTitle.font = kSystemFont(28);
    self.rightTitle.textColor = COLORWITHHEX(kColor_FFFFFF);
    self.rightTitle.text = @"自定义";
    self.rightTitle.textAlignment = NSTextAlignmentCenter;
    self.rightTitle.userInteractionEnabled = YES;
    UITapGestureRecognizer* rightTap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(tapTitle:)];
    [self.rightTitle addGestureRecognizer:rightTap];
    
    
    [self addSubview:self.blueView];
    [self addSubview:self.whiteView];
    [self addSubview:self.leftTitle];
    [self addSubview:self.rightTitle];
}

- (void)setupConstraint{

    [self.blueView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.centerY.equalTo(self);
        make.width.mas_equalTo(kWidth(600));
        make.height.mas_equalTo(kWidth(100));
    }];
    

    [self.whiteView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.width.mas_equalTo(kWidth(300));
        make.height.mas_equalTo(kWidth(100));
        make.left.equalTo(self.mas_centerX).offset(-kWidth(300));
    }];
    
    //左边标题
    [self.leftTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX).offset(-kWidth(150));
        make.width.mas_equalTo(kWidth(300));
        make.height.mas_equalTo(kWidth(100));
    }];
    
    //右边标题
    [self.rightTitle mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.mas_centerY);
        make.centerX.equalTo(self.mas_centerX).offset(kWidth(150));
        make.width.mas_equalTo(kWidth(300));
        make.height.mas_equalTo(kWidth(100));
    }];
}

- (void)tapTitle:(UITapGestureRecognizer *)tap{
    
    UILabel* titleLab = (UILabel*)tap.view;
    if (titleLab.tag == 1001) {
        [self.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX).offset(-kWidth(300));
        }];
        self.leftTitle.textColor = COLORWITHHEX(kColor_3A62AC);
        self.rightTitle.textColor = COLORWITHHEX(kColor_FFFFFF);

    }else{
        self.leftTitle.textColor = COLORWITHHEX(kColor_FFFFFF);
        self.rightTitle.textColor = COLORWITHHEX(kColor_3A62AC);
        [self.whiteView mas_updateConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.mas_centerX);
        }];
    }
    // 动画更新约束
    [self setNeedsUpdateConstraints];
    [self updateConstraintsIfNeeded];
    [UIView animateWithDuration:0.2 animations:^{
        [self layoutIfNeeded];
    }];
    
    if (self.didTitleLabBlock) {
        self.didTitleLabBlock(titleLab.tag);
    }
}


@end
