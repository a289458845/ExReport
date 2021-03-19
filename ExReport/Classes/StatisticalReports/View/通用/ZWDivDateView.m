//
//  ZWDivDateView.m
//  Muck
//
//  Created by 张威 on 2018/8/5.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWDivDateView.h"

@interface ZWDivDateView ()

@property(nonatomic,strong)UIButton *leftBtn;//自定义
@property(nonatomic,strong)UIButton *middleBtn;//昨天 or 上周
@property(nonatomic,strong)UIButton *rightBtn;//今天 or 本周

@property(nonatomic,strong)UIView *lineView;

@end

@implementation ZWDivDateView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = COLORWITHHEX(kColor_FFFFFF);
        
        [self setUpUI];
        [self setupConstraint];
    }
    return self;
}

- (void)setUpUI{
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    _baseView = [[UIView alloc] initWithFrame:CGRectMake(3*kWidth(52.5)+2*kWidth(180), kWidth(16), kWidth(180), kWidth(56))];
    _baseView.clipsToBounds = YES;
    _baseView.layer.cornerRadius = kWidth(56*0.5);
    _baseView.backgroundColor = COLORWITHHEX(kColor_3A62AC);
    [self addSubview:_baseView];
    
    self.leftBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.leftBtn.tag = 1000;
    [self.leftBtn setTitle:@"自定义" forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:COLORWITHHEX(kColor_6D737F) forState:UIControlStateNormal];
    [self.leftBtn setTitleColor:COLORWITHHEX(kColor_FFFFFF) forState:UIControlStateSelected];
    [self.leftBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    
    self.middleBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.middleBtn.tag = 1001;
    [self.middleBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.middleBtn setTitleColor:COLORWITHHEX(kColor_6D737F) forState:UIControlStateNormal];
    [self.middleBtn setTitleColor:COLORWITHHEX(kColor_FFFFFF) forState:UIControlStateSelected];
    
    self.rightBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    self.rightBtn.tag = 1002;
    self.rightBtn.selected = YES;
    [self.rightBtn addTarget:self action:@selector(clickBtn:) forControlEvents:UIControlEventTouchUpInside];
    [self.rightBtn setTitleColor:COLORWITHHEX(kColor_6D737F) forState:UIControlStateNormal];
    [self.rightBtn setTitleColor:COLORWITHHEX(kColor_FFFFFF) forState:UIControlStateSelected];
    
    
    [self addSubview:self.lineView];
    [self addSubview:self.leftBtn];
    [self addSubview:self.middleBtn];
    [self addSubview:self.rightBtn];
}


- (void)setupConstraint{
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(kWidth(2));
    }];
    [self.leftBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kWidth(180), kWidth(56)));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kWidth(52.5));
    }];
    [self.middleBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kWidth(180), kWidth(56)));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kWidth(52.5)*2+kWidth(180));
    }];
    [self.rightBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.mas_equalTo(CGSizeMake(kWidth(180), kWidth(56)));
        make.centerY.equalTo(self);
        make.left.equalTo(self).offset(kWidth(52.5)*3+2*kWidth(180));
    }];
}


- (void)setType:(ZWDivDateType)type{
    if (type == ZWDivDateTypeWeek) {
        [_middleBtn setTitle:@"上周" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"本周" forState:UIControlStateNormal];
    }else{
        [_middleBtn setTitle:@"昨天" forState:UIControlStateNormal];
        [_rightBtn setTitle:@"今天" forState:UIControlStateNormal];
    }
}

- (void)clickBtn:(UIButton *)sender{
    NSInteger index = sender.tag - 1000;
    if (self.delegate && [self.delegate respondsToSelector:@selector(ZWDivDateViewDelegateClickType:)]) {
        [self.delegate ZWDivDateViewDelegateClickType:index];
    }
    self.baseView.frame = CGRectMake(kWidth(52.5)*(index+1)+kWidth(180)*index, kWidth(16), kWidth(180), kWidth(56));
    switch (sender.tag-1000) {
        case 0:{
            self.leftBtn.selected = YES;
            self.middleBtn.selected = NO;
            self.rightBtn.selected = NO;
            break;
        }
        case 1:{
            self.leftBtn.selected = NO;
            self.middleBtn.selected = YES;
            self.rightBtn.selected = NO;
            break;
        }
        case 2:{
            self.leftBtn.selected = NO;
            self.middleBtn.selected = NO;
            self.rightBtn.selected = YES;
            break;
        }
        default:
            break;
    }
    
    

}

@end








