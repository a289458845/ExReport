//
//  ZWCarAlarmInfoTableViewCell.m
//  Muck
//
//  Created by 张威 on 2018/8/1.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarAlarmInfoTableViewCell.h"
#import "ZWAlermTypeListDataModel.h"

@interface ZWCarAlarmInfoTableViewCell ()
@property (strong, nonatomic)UIView *bgView;
@property (strong, nonatomic)UILabel *AlarmTypeLab;
@property (strong, nonatomic)UILabel *AlarmCountLab;
@property (strong, nonatomic)UILabel *AlarmTimeLab;
@end

@implementation ZWCarAlarmInfoTableViewCell

- (void)setModel:(ZWAlermTypeListDataModel *)model{
    _model = model;
    _AlarmTypeLab.text = model.title;

    NSString *alarmCountStr = [NSString stringWithFormat:@"%@次",model.value];
     NSRange alarmCountRange = [alarmCountStr rangeOfString:model.value];
    _AlarmCountLab.attributedText = [self getStateStringwith:alarmCountStr stateRang:alarmCountRange stateFont:kSystemDefauletFont(70) stateColor:COLORWITHHEX(kColor_FFFFFF)];
    _AlarmTimeLab.text = [NSString stringWithFormat:@"共持续%@",model.timer];
    
    if ([model.alarmtypeid integerValue] == 14) {
        self.bgView.backgroundColor = COLORWITHHEX(@"FA842D");
    }else if ([model.alarmtypeid integerValue] == 100){
        self.bgView.backgroundColor = COLORWITHHEX(kColor_45ACF5);
    }else if([model.alarmtypeid integerValue] == 101){
        self.bgView.backgroundColor = COLORWITHHEX(kColor_FFC23E);
    }
    
}

- (void)setType:(ZWCarAlarmType)type{
    _type = type;
    if (type== ZWCarAlarmTypeUnClosedness) {
        self.bgView.backgroundColor = COLORWITHHEX(kColor_45ACF5);
    }
    if (type== ZWCarAlarmTypeOverSpeed) {
        self.bgView.backgroundColor = COLORWITHHEX(@"FA842D");
    }
    if (type== ZWCarAlarmTypeOverload) {
        self.bgView.backgroundColor = COLORWITHHEX(kColor_FFC23E);
    }
}


- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self setupUI];
        [self setupConstaint];
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)setupUI
{
    self.bgView = [[UIView alloc]init];
    self.bgView.layer.cornerRadius = kWidth(6);
    self.bgView.alpha = 0.8;
    self.bgView.layer.masksToBounds = YES;
    self.bgView.layer.backgroundColor = COLORWITHHEX(kColor_45ACF5).CGColor;
    
    self.AlarmTypeLab = [UILabel LabelWithFont:kSystemDefauletFont(36) andColor:COLORWITHHEX(kColor_FFFFFF) andTextAlignment:left];
    self.AlarmCountLab = [UILabel LabelWithFont:kSystemFont(36) andColor:COLORWITHHEX(kColor_FFFFFF) andTextAlignment:right];
    self.AlarmTimeLab = [UILabel LabelWithFont:kSystemFont(36) andColor:COLORWITHHEX(kColor_FFFFFF) andTextAlignment:right];
    
    [self addSubview:self.bgView];
    [self.bgView addSubview:self.AlarmTypeLab];
    [self.bgView addSubview:self.AlarmCountLab];
    [self.bgView addSubview:self.AlarmTimeLab];
    

    
    
}

- (void)setupConstaint{
 
    [self.bgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(30));
        make.top.equalTo(self);
        make.height.mas_equalTo(kWidth(160));
        make.right.equalTo(self).offset(-kWidth(30));
    }];
    [self.AlarmTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.bgView ).offset(kWidth(30));
        make.centerY.equalTo(self.bgView);
    }];
    [self.AlarmCountLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-kWidth(30));
        make.centerY.equalTo(self.bgView.mas_centerY).offset(-kWidth(20));
    }];
    [self.AlarmTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.bgView).offset(-kWidth(30));
        make.centerY.equalTo(self.bgView.mas_centerY).offset(kWidth(30));
    }];
}

// 根据状态值合成富文本
- (NSMutableAttributedString *)getStateStringwith:(NSString*)fullStr stateRang:(NSRange)range stateFont:(UIFont*)font stateColor:(UIColor*)color{
    // 将合成后的字符串转换为富文本
    NSMutableAttributedString *attributedStr = [[NSMutableAttributedString alloc] initWithString:fullStr];
    // 给对应的range添加属性
    [attributedStr addAttributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font} range:range];
    return attributedStr;
}




@end
