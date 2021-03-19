//
//  ZWCarBaseInfoTwoCell.m
//  Muck
//
//  Created by 张威 on 2018/10/30.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarBaseInfoTwoCell.h"
#import "ZWVehicleLastUnerModel.h"
@interface ZWCarBaseInfoTwoCell()
@property(nonatomic,strong)UILabel *titleTypeLab;
@property (strong, nonatomic)UIImageView *rightImgView;//折叠图片
@property(nonatomic,strong)UIView *lineView;

@property(nonatomic,strong)UILabel *siteNamePlaceHoldLab;
//@property(nonatomic,strong)UILabel *siteNameLab;

@property(nonatomic,strong)UILabel *siteTimePlaceHoldLab;
@property(nonatomic,strong)UILabel *siteTimeLab;

@property(nonatomic,strong)UILabel *siteLocationPlaceHoldLab;
@property(nonatomic,strong)UILabel *siteLocationLab;

@property (strong, nonatomic)UIButton *extendBtn;


@end


@implementation ZWCarBaseInfoTwoCell
- (void)setModel:(ZWVehicleLastUnerModel *)model{
    _model = model;
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:[NSString stringWithFormat:@"工程名称:   %@",model.SiteName] attributes:attribtDic];
    
    //赋值
    _siteNamePlaceHoldLab.attributedText = attribtStr;
//    _siteNamePlaceHoldLab.text = [NSString stringWithFormat:@"工程名称:   %@",model.SiteName];
    _siteTimeLab.text = [model.SiteTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    _siteLocationLab.text = model.SiteAddress;

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

    self.titleTypeLab = [UILabel LabelWithFont:kSystemFont(32) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"最新出土工地"];
    
     self.rightImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"caselist_detail_pulldown_icon"]];
    
    self.siteNamePlaceHoldLab = [UILabel addLineLabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_5490EB) andTextAlignment:left andString:@"工地名称:"];
//    self.siteNameLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_5490EB) andTextAlignment:left andString:@""];
    
    
    self.siteTimePlaceHoldLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"出土时间:"];
    self.siteTimeLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left];
    self.siteTimeLab.numberOfLines = 0;
    
    self.siteLocationPlaceHoldLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"工地位置:"];
    self.siteLocationLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left];
    self.siteLocationLab.numberOfLines = 0;
    
 

    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    
    self.extendBtn = [UIButton new];
    [self.extendBtn addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];

    [self addSubview:self.titleTypeLab];
    [self addSubview:self.lineView];
    [self addSubview:self.rightImgView];
    
    [self addSubview:self.siteNamePlaceHoldLab];
//    [self addSubview:self.siteNameLab];
    
    [self addSubview:self.siteTimePlaceHoldLab];
    [self addSubview:self.siteTimeLab];
    
    [self addSubview:self.siteLocationPlaceHoldLab];
    [self addSubview:self.siteLocationLab];
    
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
    
    [self.siteNamePlaceHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(56));
        make.top.equalTo(self.lineView.mas_bottom).offset(kWidth(30));
    }];
//    [self.siteNameLab mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.equalTo(self.siteNamePlaceHoldLab.mas_right).offset(kWidth(20));
//        make.centerY.equalTo(self.siteNamePlaceHoldLab);
//    }];
    
    [self.siteTimePlaceHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(56));
        make.top.equalTo(self.siteNamePlaceHoldLab.mas_bottom).offset(kWidth(24));
    }];
    [self.siteTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.siteTimePlaceHoldLab.mas_right).offset(kWidth(20));
        make.right.equalTo(self.mas_right).offset(-kWidth(30));
        make.centerY.equalTo(self.siteTimePlaceHoldLab);
    }];
    
    [self.siteLocationPlaceHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(56));
        make.top.equalTo(self.siteTimeLab.mas_bottom).offset(kWidth(24));
        make.width.equalTo(self.siteTimePlaceHoldLab);
    }];
    [self.siteLocationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.siteLocationPlaceHoldLab.mas_right).offset(kWidth(20));
        make.top.equalTo(self.siteLocationPlaceHoldLab.mas_top);
        make.right.equalTo(self.mas_right).offset(-kWidth(30));
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
