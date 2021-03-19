//
//  ZWContentButton.m
//  Muck
//
//  Created by 张威 on 2018/8/1.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWContentButton.h"
@interface ZWContentButton ()

@end
@implementation ZWContentButton

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupConstaint];
    }
    return self;
}

- (void)setupUI{
    
    self.imgView = [[UIImageView alloc]init];
    self.imgView.contentMode = UIViewContentModeScaleAspectFill;
    
    self.titleLab = [[UILabel alloc]init];
    self.titleLab.textAlignment = NSTextAlignmentCenter;
    self.titleLab.font = kSystemFont(28);
    self.titleLab.textColor = COLORWITHHEX(kColor_6D737F);
    self.titleLab.numberOfLines = 0;

    
    [self addSubview:self.titleLab];
    [self addSubview:self.imgView];
}

- (void)setupConstaint{
    [self.imgView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.mas_top);
        make.centerX.equalTo(self);
        make.size.mas_equalTo(CGSizeMake(kWidth(72), kWidth(72)));
    }];
    
    [self.titleLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.top.equalTo(self.imgView.mas_bottom).offset(kWidth(10));
        make.height.mas_equalTo(kWidth(30));

    }];
    
    
}

@end
