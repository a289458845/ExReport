//
//  ZWLineChartLabel.m
//  Muck
//
//  Created by 张威 on 2018/8/3.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWLineChartLabel.h"

@implementation ZWLineChartLabel

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.textColor = [UIColor whiteColor];
        self.font = kSystemFont(24);
        self.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

@end
