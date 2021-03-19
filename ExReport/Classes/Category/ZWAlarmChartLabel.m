//
//  ZWAlarmChartLabel.m
//  Muck
//
//  Created by 张威 on 2018/8/2.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWAlarmChartLabel.h"
@implementation ZWAlarmChartLabel

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        self.textColor = COLORWITHHEX(kColor_AFB4C0);
        self.font = kSystemFont(24);
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
