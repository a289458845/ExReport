//
//  ZWCarAlarmInfoTableSectionHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/27.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarAlarmInfoTableSectionHeaderView.h"
@interface ZWCarAlarmInfoTableSectionHeaderView()

@end
@implementation ZWCarAlarmInfoTableSectionHeaderView

- (instancetype)init
{
    if (self = [super init]) {
        self.tipLab = [UILabel LabelWithFont:kSystemDefauletFont(30) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left];
        [self addSubview:self.tipLab];
        [self.tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self).offset(kWidth(30));
            make.top.equalTo(self).offset(kWidth(20));

        }];
    }
    return self;
}

@end
