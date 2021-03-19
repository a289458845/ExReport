//
//  ZWSelectAlarmTimeViewCell.m
//  Muck
//
//  Created by 张威 on 2018/8/27.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWSelectAlarmTimeViewCell.h"
@interface ZWSelectAlarmTimeViewCell ()
@property(nonatomic,strong)UILabel *titleLab;
@property(nonatomic,strong)UIView *bgView;
@property(nonatomic,strong)UILabel *timeLab;
@property(nonatomic,strong)UIImageView *imgView;
@end
@implementation ZWSelectAlarmTimeViewCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        [self setupUI];
        [self setupConstraint];
    }
    return self;
}

- (void)setupUI{
    self.titleLab = [UILabel LabelWithFont:kSystemFont(32) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@" "];
    self.bgView = [[UIView alloc]init];
    self.bgView.backgroundColor = COLORWITHHEX(kColor_5490EB);
    
    self.timeLab = [UILabel LabelWithFont:kSystemFont(36) andColor:COLORWITHHEX(kColor_FFFFFF) andTextAlignment:left andString:@" "];
    self.imgView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"choice_date_icon"]];
    
    [self addSubview:self.titleLab];
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.timeLab];
    [self.bgView addSubview:self.imgView];
}

- (void)setupConstraint{
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(60));
        make.centerY.equalTo(self);
    }];
    
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.titleLab.mas_right).offset(kWidth(30));
        make.right.equalTo(self.mas_right).offset(-kWidth(30));
        make.centerY.equalTo(self);
        make.height.mas_equalTo(kWidth(56));
    }];
    
    [self.timeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView.mas_left).offset(kWidth(20));
        make.centerY.equalTo(self.bgView);
    }];
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView.mas_right).offset(-kWidth(20));
        make.centerY.equalTo(self.bgView);
    }];
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _titleLab.text = titleStr;
}

- (void)setTimeStr:(NSString *)timeStr{
    _timeStr = timeStr;
    _timeLab.text =timeStr;
}

- (void)setDetail:(NSString *)detail{
    _detail = detail;
    if (!(_detail.length == 0)) {
        _timeLab.text = detail;
    }
}
@end
