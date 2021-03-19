//
//  ZWCarBaseInfoThreeCell.m
//  Muck
//
//  Created by 张威 on 2018/10/30.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarBaseInfoThreeCell.h"
#import "ZWVehicleLastUnerModel.h"
@interface ZWCarBaseInfoThreeCell ()

@property(nonatomic,strong)UILabel *titleTypeLab;
@property (strong, nonatomic)UIImageView *rightImgView;//折叠图片
@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,strong)UILabel *companyNamePlaceHoldLab;
@property(nonatomic,strong)UILabel *companyNameLab;

@property(nonatomic,strong)UILabel *legalPlaceHoldLab;
@property(nonatomic,strong)UILabel *legalLab;

@property(nonatomic,strong)UILabel *phonePlaceHoldLab;
@property(nonatomic,strong)UILabel *phoneLab;

@property(nonatomic,strong)UILabel *addressPlaceHoldLab;
@property(nonatomic,strong)UILabel *addressLab;

@property (strong, nonatomic)UIButton *extendBtn;
@end
@implementation ZWCarBaseInfoThreeCell

- (void)setModel:(ZWVehicleLastUnerModel *)model{
    _model = model;
    _companyNameLab.text = model.EnterpriseName;
    _legalLab.text = model.LegalName;
    _phoneLab.text = model.LegalPhone;
    _addressLab.text = model.EnterpriseAdd;
}


-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.clipsToBounds = YES;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = COLORWITHHEX(kColor_FFFFFF);
        [self setupUI];
        [self setupConstraint];
    }
    return self;
}


- (void)setupUI{
    
    self.titleTypeLab = [UILabel LabelWithFont:kSystemFont(32) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"企业信息"];
    
    self.rightImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"caselist_detail_pulldown_icon"]];
    
    self.companyNamePlaceHoldLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"所属公司:"];
    self.companyNameLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left];
    self.companyNameLab.numberOfLines = 0;
    
    
    self.legalPlaceHoldLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"法人代表:"];
    self.legalLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left];
    
    self.phonePlaceHoldLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"联系电话:"];
    self.phoneLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left];
    
    self.addressPlaceHoldLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"公司地址:"];
    self.addressLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left];
     self.addressLab.numberOfLines = 0;
    
    
    self.extendBtn = [UIButton new];
    [self.extendBtn addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    
    [self addSubview:self.titleTypeLab];
    [self addSubview:self.lineView];
    [self addSubview:self.rightImgView];
    
    [self addSubview:self.companyNamePlaceHoldLab];
    [self addSubview:self.companyNameLab];
    
    [self addSubview:self.legalPlaceHoldLab];
    [self addSubview:self.legalLab];
    
    [self addSubview:self.phonePlaceHoldLab];
    [self addSubview:self.phoneLab];
    
    [self addSubview:self.addressPlaceHoldLab];
    [self addSubview:self.addressLab];
    
    [self addSubview:self.extendBtn];
    
}

- (void)setupConstraint{
    [self.titleTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(30));
        make.centerY.equalTo(self.mas_top).offset(kWidth(48));
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(kWidth(96));
        make.height.mas_equalTo(kWidth(1));
    }];
    [self.rightImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kWidth(30));
        make.centerY.equalTo(self.titleTypeLab);
    }];
    
    [self.companyNamePlaceHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(56));
   
        make.top.equalTo(self.lineView.mas_bottom).offset(kWidth(30));
    }];
    [self.companyNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.companyNamePlaceHoldLab.mas_right).offset(kWidth(20));
        make.right.equalTo(self).offset(kWidth(-30));
        make.centerY.equalTo(self.companyNamePlaceHoldLab);
    }];
    
    [self.legalPlaceHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(56));
        make.top.equalTo(self.companyNamePlaceHoldLab.mas_bottom).offset(kWidth(24));
    }];
    [self.legalLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.legalPlaceHoldLab.mas_right).offset(kWidth(20));
        make.centerY.equalTo(self.legalPlaceHoldLab);
    }];
    
    [self.phonePlaceHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(56));
        make.top.equalTo(self.legalPlaceHoldLab.mas_bottom).offset(kWidth(30));
    }];
    [self.phoneLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.phonePlaceHoldLab.mas_right).offset(kWidth(20));
        make.centerY.equalTo(self.phonePlaceHoldLab);
    }];
    
    [self.addressPlaceHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(56));
        make.top.equalTo(self.phonePlaceHoldLab.mas_bottom).offset(kWidth(30));
    }];
    [self.addressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.addressPlaceHoldLab.mas_right).offset(kWidth(20));
        make.centerY.equalTo(self.addressPlaceHoldLab);
    }];
    
    [self.extendBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.mas_equalTo(self);
        
    }];
    
    
}

- (void)setIndexPath:(NSIndexPath *)indexPath
{
    _indexPath = indexPath;
}
- (void)setIsExtend:(BOOL)isExtend
{
    _isExtend = isExtend;
    if (_isExtend) {
        _rightImgView.image = [UIImage imageNamed:@"caselist_detail_pulldown_icon"];
    }else{
        _rightImgView.image = [UIImage imageNamed:@"caselist_detail_pullup_icon"];
    }
}

- (void)buttonDidClick:(UIButton *)sender{
    if (_clickExtend) {
        _clickExtend(_indexPath,_isExtend);
    }
}

@end
