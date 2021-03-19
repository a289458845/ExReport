//
//  ZWCompanyBasicInfoHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/21.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCompanyBasicInfoHeaderView.h"
#import "ZWCompanyBasicInfoModel.h"
@interface ZWCompanyBasicInfoHeaderView ()

@property(nonatomic,strong)UILabel *onLinePlaceLab;
@property(nonatomic,strong)UILabel *onLineLab;
@property(nonatomic,strong)UILabel *nameLab;
@property(nonatomic,strong)UILabel *addressLab;
@property(nonatomic,strong)UILabel *unqualifiedLab;
@property(nonatomic,strong)UIImageView *addressImg;
@property(nonatomic,strong)UIImageView *unqualifiedImg;

@end

@implementation ZWCompanyBasicInfoHeaderView

- (void)setModel:(ZWCompanyBasicInfoModel *)model{
    _model = model;
    self.onLineLab.text = model.OnLineCube;
    self.addressLab.text = model.EnterpriseAddress;
}

- (void)setEnterpriseName:(NSString *)EnterpriseName{
    _EnterpriseName = EnterpriseName;
    self.nameLab.text = EnterpriseName;
}
- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    self.backgroundColor = COLORWITHHEX(kColor_3A62AC);
    
    self.onLinePlaceLab = [UILabel LabelWithFont:kSystemFont(24) andColor:COLORWITHHEX(kColor_AFB4C0) andTextAlignment:center andString:@"当日上线率"];
    self.onLineLab = [UILabel LabelWithFont:kSystemDefauletFont(48) andColor:COLORWITHHEX(kColor_FFFFFF) andTextAlignment:center andString:@" "];
    self.nameLab = [UILabel LabelWithFont:kSystemFont(32) andColor:COLORWITHHEX(kColor_FFFFFF) andTextAlignment:center andString:@" "];
    self.addressLab = [UILabel LabelWithFont:kSystemFont(32) andColor:COLORWITHHEX(kColor_FFFFFF) andTextAlignment:center andString:@" "];
    self.unqualifiedLab = [UILabel LabelWithFont:kSystemFont(32) andColor:COLORWITHHEX(kColor_FFFFFF) andTextAlignment:center andString:@"不合格"];
    
    self.unqualifiedImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"qiyexinxi_qipao"]];
    self.addressImg = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"commonreport_areaselection_icon"]];
    
    [self addSubview:self.onLinePlaceLab];
    [self addSubview:self.onLineLab];
    [self addSubview:self.nameLab];
    [self addSubview:self.addressLab];
    [self addSubview:self.unqualifiedImg];
    [self addSubview:self.addressImg];
    [self.unqualifiedImg addSubview:self.unqualifiedLab];
    
    [self.onLinePlaceLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).offset(kWidth(60));
        make.centerX.equalTo(self);
    }];
    [self.onLineLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.onLinePlaceLab.mas_bottom).offset(kWidth(20));
        make.centerX.equalTo(self);
    }];
    [self.unqualifiedImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.onLineLab.mas_right).offset(kWidth(20));
        make.centerY.equalTo(self.onLineLab);
    }];
    [self.unqualifiedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.unqualifiedImg);
    }];
    
    [self.addressImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(30));
    }];
    
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-kWidth(30));
        make.left.equalTo(self.addressImg.mas_right).offset(kWidth(6));
        make.centerY.equalTo(self.addressImg);
    }];
    
    [self.nameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(30));
        make.bottom.equalTo(self.addressLab.mas_top).offset(-kWidth(30));
    }];
 
}

@end
