//
//  ZWAlarmBarChartView.m
//  Muck
//
//  Created by 张威 on 2018/8/1.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWAlarmBarChartView.h"
#import "ZWAlarmBar.h"
#import "ZWAlarmChartLabel.h"

@interface ZWAlarmBarChartView ()
{
    UIScrollView *scrollView;
    CGFloat xLabelWidth;
}


@end

@implementation ZWAlarmBarChartView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        [self addSubview:scrollView];
    }
    return self;
}

- (void)setXArray:(NSArray *)xArray{
    _xArray = xArray;
    
    NSInteger num;
    if (xArray.count >= numOfBarForVisible) {
        num = numOfBarForVisible;
    } else {
        num = xArray.count;
    }
    
    xLabelWidth = scrollView.frame.size.width/num;
    
    for (int i = 0; i < xArray.count; i++) {
       
        ZWAlarmChartLabel *lab = [[ZWAlarmChartLabel alloc] initWithFrame:CGRectMake(i*xLabelWidth, CGRectGetHeight(scrollView.frame)-xLabelHeight, xLabelWidth, xLabelHeight)];
        lab.text = xArray[i];
        [scrollView addSubview:lab];
    }
    
    scrollView.contentSize = CGSizeMake(xArray.count*xLabelWidth, scrollView.frame.size.height);
}

- (void)setYValueArray:(NSArray *)yValueArray
{
    _yValueArray = yValueArray;
}

- (void)updateChart{
    for (int i = 0; i < _xArray.count; i++) {
        NSString *valueString = self.yValueArray[i];
        float value = [valueString floatValue];
        float grade = (value-_yValueMin) / ((float)_yValueMax-_yValueMin);
        
        ZWAlarmBar *bar = [[ZWAlarmBar alloc] initWithFrame:CGRectMake(i*xLabelWidth+0.15*xLabelWidth, 0, xLabelWidth*0.7, scrollView.frame.size.height-xLabelHeight)];
        bar.valueStr = valueString;
        bar.grade = grade;
        [scrollView addSubview:bar];
        
    }
}


@end





