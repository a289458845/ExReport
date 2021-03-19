//
//  ZWStatuesTool.m
//  Muck
//
//  Created by 张威 on 2018/8/2.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWStatuesTool.h"

@implementation ZWStatuesTool

+ (CGPoint)configureValueRangeWithData:(NSArray *)data
{
    long maxValue = 0.0;
    long minValue = 100000000.0;
    for (NSString *valueString in data) {
        double value = [valueString doubleValue];
        // 找出最大值，最小值
        if (value > maxValue) {
            maxValue = value;
        }
        if (value < minValue) {
            minValue = value;
        }
    }
    NSInteger max = (int)maxValue;
    NSString *maxValueStr = [NSString stringWithFormat:@"%d", (int)max];
    NSInteger k = pow(10, maxValueStr.length - 1);
    max = (max/k + 1)*k;
    NSInteger min = (int)minValue;
    return CGPointMake(min, max);
}

@end
