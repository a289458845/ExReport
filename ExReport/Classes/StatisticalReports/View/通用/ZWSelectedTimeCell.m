//
//  ZWSelectedTimeCell.m
//  Muck
//
//  Created by 张威 on 2018/8/9.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWSelectedTimeCell.h"


@interface ZWSelectedTimeCell ()<UITextFieldDelegate>
@property (nonatomic,strong)UILabel *titleLabel;
@property (nonatomic,strong)UITextField *textFiled;
@end
@implementation ZWSelectedTimeCell
-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = COLORWITHHEX(kColor_FFFFFF);
        [self setupUI];
        [self setupConstraint];
    }
    return self;
}

- (void)setupUI{
    _titleLabel = [UILabel LabelWithFont:kSystemFont(32) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left andString:@" "];

    self.textFiled = [[UITextField alloc]init];
    self.textFiled.delegate = self;
    self.textFiled.enabled = NO;
    self.textFiled.textAlignment = NSTextAlignmentRight;
    self.textFiled.font = kSystemFont(32);
    self.textFiled.textColor = COLORWITHHEX(kColor_6D737F);
    [self.textFiled addTarget:self action:@selector(valueChanged:)  forControlEvents:UIControlEventEditingChanged];
    
    [self addSubview:self.titleLabel];
    [self addSubview:_textFiled];
}

- (void)setupConstraint{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kWidth(30));
        make.centerY.mas_equalTo(self);
    }];
    
    [_textFiled mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(kWidth(-30));
        make.left.mas_equalTo(self.mas_left).offset(kWidth(100));
    }];
}

- (void)setTimeString:(NSString *)timeString{
    _timeString = timeString;
    _textFiled.placeholder = timeString;
}

- (void)setTitleString:(NSString *)titleString{
    _titleString = titleString;
    _titleLabel.text = titleString;
}

- (void)valueChanged:(UITextField *)textField{
    
}

- (void)setDetail:(NSString *)detail{
    _detail = detail;
    if (!(_detail.length == 0)) {
        _textFiled.text = detail;
    }
}
@end
