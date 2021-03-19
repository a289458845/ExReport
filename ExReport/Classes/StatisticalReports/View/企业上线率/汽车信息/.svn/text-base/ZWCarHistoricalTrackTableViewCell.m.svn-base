//
//  ZWCarHistoricalTrackTableViewCell.m
//  Muck
//
//  Created by 张威 on 2018/8/27.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarHistoricalTrackTableViewCell.h"
#import "ZWHisLocStatModel.h"
@interface ZWCarHistoricalTrackTableViewCell ()
@property(nonatomic,strong)UIView *sectionView;
@property(nonatomic,strong)UIView *baseView;
@property(nonatomic,strong)UIView *lineTopView;
@property(nonatomic,strong)UIView *lineBottomView;
@property(nonatomic,strong)UIImageView *iconView;

@property(nonatomic,strong)UILabel *TotalMileageLab;//总里程
@property(nonatomic,strong)UILabel *checkMoreLab;
@property(nonatomic,strong)UIImageView *checkMoreImgView;
@property(nonatomic,strong)UILabel *trackTimeLab;
@property(nonatomic,strong)UILabel *startAddressLab;
@property(nonatomic,strong)UILabel *endAddressLab;
@property(nonatomic,strong)UIImageView *trackTimeImgView;
@property(nonatomic,strong)UIImageView *startAddressImgView;
@property(nonatomic,strong)UIImageView *endAddressImgView;

@end
@implementation ZWCarHistoricalTrackTableViewCell

- (void)setModel:(ZWHisLocStatModel *)model{
    _TotalMileageLab.text = [NSString stringWithFormat:@"总里程:%@km",model.Mileage];
    NSString *endTime;
    if (model.EndDateTime.length > 19) {
        endTime = [model.EndDateTime substringToIndex:19];
        endTime =  [endTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }else{
        endTime =  [model.EndDateTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
    }
    _trackTimeLab.text = [NSString stringWithFormat:@"%@至%@",model.StartDateTime,endTime];
    _startAddressLab.text = model.StartAddress;
    _endAddressLab.text = model.EndAddress;

}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupConstaint];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    }
    return self;
}
- (void)setupUI{
    self.sectionView = [[UIView alloc]init];
    self.sectionView.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    
    self.baseView = [[UIView alloc]init];
    self.baseView.backgroundColor = COLORWITHHEX(kColor_FFFFFF);
    
    self.lineTopView = [[UIView alloc]init];
    self.lineTopView.backgroundColor = COLORWITHHEX(kColor_D9DCE3);
    
    self.lineBottomView = [[UIView alloc]init];
    self.lineBottomView.backgroundColor = COLORWITHHEX(kColor_D9DCE3);
    
    self.iconView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"historicalroute_list_icon"]];
    
    self.TotalMileageLab = [UILabel LabelWithFont:kSystemDefauletFont(32) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@" "];
    self.checkMoreLab = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(kColor_AFB4C0) andTextAlignment:left andString:@"查看"];
    self.checkMoreImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"cheliangxinxi_chakangengduo"]];
    
    self.trackTimeImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"historicalroute_time_icon"]];
    
    self.startAddressImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lishiguiji_qidian"]];
    self.endAddressImgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"lishiguiji_zhongdian"]];
    
    self.trackTimeLab = [UILabel LabelWithFont:kSystemFont(24) andColor:COLORWITHHEX(kColor_AFB4C0) andTextAlignment:left andString:@" "];
    self.startAddressLab = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left andString:@" "];
    self.endAddressLab = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left andString:@""];
   self.trackTimeLab.numberOfLines = 0;
    self.startAddressLab.numberOfLines = 0;
    self.endAddressLab.numberOfLines = 0;
    
    [self addSubview:self.sectionView];
    [self addSubview:self.baseView];
    [self addSubview:self.lineTopView];
    [self addSubview:self.lineBottomView];
    [self addSubview:self.iconView];
    
    [self.baseView addSubview:self.TotalMileageLab];
    [self.baseView addSubview:self.checkMoreLab];
    [self.baseView addSubview:self.checkMoreImgView];
    [self.baseView addSubview:self.trackTimeLab];
    [self.baseView addSubview:self.trackTimeImgView];
    [self.baseView addSubview:self.startAddressLab];
    [self.baseView addSubview:self.startAddressImgView];
    [self.baseView addSubview:self.endAddressLab];
    [self.baseView addSubview:self.endAddressImgView];
}


- (void)setupConstaint{
    
    [self.iconView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(30));
        make.centerY.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kWidth(70), kWidth(70)));
    }];
    [self.lineTopView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(65));
        make.top.equalTo(self);
        make.bottom.equalTo(self.iconView.mas_top).offset(-kWidth(10));
        make.width.mas_equalTo(kWidth(2));
    }];
    [self.lineBottomView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(65));
        make.top.equalTo(self.iconView.mas_bottom).offset(kWidth(10));;
        make.bottom.equalTo(self);
        make.width.mas_equalTo(kWidth(2));
    }];
    
    [self.sectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.equalTo(self);
        make.height.mas_equalTo(kWidth(20));
    }];
    
    [self.baseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.iconView.mas_right).offset(kWidth(30));
        make.right.equalTo(self).offset(-kWidth(30));
        make.top.equalTo(self.sectionView.mas_bottom);
        make.bottom.equalTo(self);
    }];
    
    [self.TotalMileageLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.baseView.mas_left).offset(kWidth(18));
        make.top.equalTo(self.baseView.mas_top).offset(kWidth(30));
    }];
    
    [self.checkMoreImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseView.mas_right).offset(-kWidth(20));
        make.centerY.equalTo(self.TotalMileageLab);
    }];
    [self.checkMoreLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.checkMoreImgView.mas_left).offset(-kWidth(10));
        make.centerY.equalTo(self.TotalMileageLab);
    }];

    [self.trackTimeImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TotalMileageLab.mas_left);
        make.centerY.equalTo(self.trackTimeLab);
    }];
    
    [self.trackTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.TotalMileageLab.mas_left).offset(kWidth(30));
//        make.left.equalTo(self.trackTimeImgView.mas_right).offset(kWidth(18));
        make.top.equalTo(self.TotalMileageLab.mas_bottom).offset(kWidth(20));
         make.right.equalTo(self.baseView.mas_right).offset(-kWidth(20));
    }];

    [self.startAddressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.trackTimeImgView);
        make.centerY.equalTo(self.startAddressLab);
    }];
    [self.startAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.trackTimeLab.mas_left);
        make.top.equalTo(self.trackTimeLab.mas_bottom).offset(kWidth(20));
        make.right.equalTo(self.baseView.mas_right).offset(-kWidth(20));
    }];
    
    [self.endAddressImgView mas_makeConstraints:^(MASConstraintMaker *make) {
      make.centerX.equalTo(self.trackTimeImgView);
        make.centerY.equalTo(self.endAddressLab);
    }];
    [self.endAddressLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.trackTimeLab.mas_left);
        make.top.equalTo(self.startAddressLab.mas_bottom).offset(kWidth(20));
        make.right.equalTo(self.baseView.mas_right).offset(-kWidth(20));
    }];

 

}


@end
