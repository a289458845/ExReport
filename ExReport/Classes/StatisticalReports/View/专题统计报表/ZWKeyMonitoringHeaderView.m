//
//  ZWKeyMonitoringHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/22.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWKeyMonitoringHeaderView.h"
@interface  ZWKeyMonitoringHeaderView ()
@property (nonatomic, strong) UILabel *timeLabel;
@property (nonatomic, strong) UILabel *numcountLabel;
@property (nonatomic, strong) UILabel *numcountPlaceLabel;
@end
@implementation ZWKeyMonitoringHeaderView
- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self initUI];
    }
    return self;
    
}

- (void)initUI{
    self.backgroundColor = COLORWITHHEX(kColor_3A62AC);
    
    self.numcountLabel = [[UILabel alloc] init];
    self.numcountLabel.font = kSystemDefauletFont(60);
    self.numcountLabel.textColor = COLORWITHHEX(kColor_FFFFFF);
    
    self.numcountPlaceLabel = [UILabel LabelWithFont:kSystemFont(24) andColor:COLORWITHHEX(kColor_AFB4C0) andTextAlignment:center andString:@"车辆进入次数累计(次)"];
    
    self.timeLabel = [[UILabel alloc] init];
    self.timeLabel.font = kSystemFont(28);
    self.timeLabel.textColor = COLORWITHHEX(kColor_FFFFFF);
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"commonreport_optiondate_pulldown_icon"];
    
    [self addSubview:img];
    [self addSubview:self.timeLabel];
    [self addSubview:self.numcountLabel];
    [self addSubview:self.numcountPlaceLabel];
    
    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kWidth(30));
    }];
    
    [self.timeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self).offset(-kWidth(30));
        make.right.equalTo(img.mas_left).offset(-kWidth(6));
        make.centerY.equalTo(img);
    }];
    [self.numcountLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self).offset(kWidth(80));
    }];
    [self.numcountPlaceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.numcountLabel.mas_bottom).offset(kWidth(30));
    }];
}

- (void)setTimeString:(NSString *)timeString{
    _timeString = timeString;
    _timeLabel.text = timeString;
}

- (void)setInOutNum:(NSString *)inOutNum{
    _inOutNum = inOutNum;
    _numcountLabel.text = inOutNum;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [touches.anyObject locationInView:self];
    NSLog(@"%@",NSStringFromCGRect(self.timeLabel.frame));
    if (point.y >= kWidth(420)-18 && point.y <= kWidth(420)) {
        if (self.didSelectTimeBlock) {
            self.didSelectTimeBlock();
        }
    }
    
}






@end
