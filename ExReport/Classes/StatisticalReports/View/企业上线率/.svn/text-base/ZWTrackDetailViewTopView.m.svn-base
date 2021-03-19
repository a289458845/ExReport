//
//  ZWTrackDetailViewTopView.m
//  Muck
//
//  Created by 邵明明 on 2018/8/30.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWTrackDetailViewTopView.h"
#import "NSString+StringSize.h"
#import "ZWHisLocPayModel.h"
@interface ZWTrackDetailViewTopView()
@property (nonatomic,strong)UILabel *plateTitleLabel;
@property (nonatomic,strong)UILabel *plateLabel;

@property (nonatomic,strong)UILabel *speedTitleLabel;
@property (nonatomic,strong)UILabel *speedLabel;

@property (nonatomic,strong)UILabel *timeTitleLabel;
@property (nonatomic,strong)UILabel *timeLabel;

@property (nonatomic,strong)UILabel *addressTitleLabel;
@property (nonatomic,strong)UILabel *addressLabel;

@end

@implementation ZWTrackDetailViewTopView

- (void)setModel:(ZWHisLocPayModel *)model{
    _model = model;
    _plateLabel.text = _model.VehicleNo;
    _speedLabel.text = [NSString stringWithFormat:@"%@km/h",_model.Speed];
    _timeLabel.text = _model.GpsDateTime;
    CGFloat H = [_model.Address heightWithLabelWidth:kScreenWidth-kWidth(100) font:kSystemFont(28)] - kWidth(28);
    self.frame = CGRectMake(kWidth(30), kWidth(20), kScreenWidth-kWidth(60), kWidth(252-28)+H);
    _addressLabel.text = _model.Address;
}

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(kWidth(30), kWidth(20), kScreenWidth-kWidth(60), kWidth(252-28));
        self.backgroundColor = COLORWITHHEX(kColor_FFFFFF);
        [self setupUI];
        [self setupConstraint];
    }
    return self;
}
- (void)setupUI
{
    _plateTitleLabel = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(@"#3A3D44") andTextAlignment:left andString:@"车 牌 号:"];
    [self addSubview:_plateTitleLabel];
    
    _plateLabel = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(@"#6D737F") andTextAlignment:left andString:@" "];
    [self addSubview:_plateLabel];
    
    
    _speedTitleLabel = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(@"#3A3D44") andTextAlignment:left andString:@"速    度:"];
    [self addSubview:_speedTitleLabel];
    
    _speedLabel = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(@"#6D737F") andTextAlignment:left andString:@" "];
    [self addSubview:_speedLabel];
    
    
    _timeTitleLabel = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(@"#3A3D44") andTextAlignment:left andString:@"当前时间:"];
    [self addSubview:_timeTitleLabel];
    
    _timeLabel = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(@"#6D737F") andTextAlignment:left andString:@" "];
    [self addSubview:_timeLabel];
    
    _addressTitleLabel = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(@"#3A3D44") andTextAlignment:left andString:@"当前位置:"];
    [self addSubview:_addressTitleLabel];
    
    _addressLabel = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(@"#6D737F") andTextAlignment:left andString:@" "];
    _addressLabel.numberOfLines = 0;
    [self addSubview:_addressLabel];
    
    
}
- (void)setupConstraint{
    [_plateTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kWidth(20));
        make.centerY.mas_equalTo(self.mas_top).offset(kWidth(20)+kWidth(14));
    }];
    
    [_plateLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kWidth(175));
        make.centerY.mas_equalTo(self.plateTitleLabel);
        make.right.mas_equalTo(self).offset(kWidth(-20));
    }];
    
    [_speedTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kWidth(20));
        make.centerY.mas_equalTo(self.mas_top).offset(kWidth(20)+kWidth(14)+kWidth(20)+kWidth(28));
    }];
    
    [_speedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kWidth(175));
        make.centerY.mas_equalTo(self.speedTitleLabel);
        make.right.mas_equalTo(self).offset(kWidth(-20));
    }];
    
    [_timeTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kWidth(20));
        make.centerY.mas_equalTo(self.mas_top).offset(kWidth(20)+kWidth(14)+kWidth(20)+kWidth(28)+kWidth(20)+kWidth(28));
    }];
    
    [_timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kWidth(175));
        make.centerY.mas_equalTo(self.timeTitleLabel);
        make.right.mas_equalTo(self).offset(kWidth(-20));
    }];
    
    [_addressTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kWidth(20));
    make.centerY.mas_equalTo(self.mas_top).offset(kWidth(20)+kWidth(14)+(kWidth(20)+kWidth(28))*3);
    }];
    
    [_addressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kWidth(175));
        make.centerY.mas_equalTo(self.addressTitleLabel);
        make.right.mas_equalTo(self).offset(kWidth(-20));
    }];
        
}


- (void)show
{
    self.hidden = NO;
}
- (void)disMiss
{
    self.hidden = YES;
}

@end
