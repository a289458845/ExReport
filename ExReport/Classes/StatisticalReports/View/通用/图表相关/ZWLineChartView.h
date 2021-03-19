//
//  ZWLineChartView.h
//  Muck
//
//  Created by 张威 on 2018/8/2.
//  Copyright © 2018年 张威. All rights reserved.
//

/**
 * 折线图
 **/

#import <UIKit/UIKit.h>

#define numOfLineForVisible 10
#define xLabelHeight 20

@interface ZWLineChartView : UIView

@property (nonatomic, strong) NSArray *xArray;
@property (nonatomic, strong) NSArray *yValueArray;
@property (nonatomic) float yValueMax;
@property (nonatomic) float yValueMin;

@property (strong, nonatomic)UIColor *xColor;
@property (strong, nonatomic)UIColor *yColor;
@property (strong, nonatomic)UIColor *lineColor;
@property (strong, nonatomic)UIColor *yPointColor;
@property (strong, nonatomic)UIColor *maskColor;//蒙层

- (void)updateChart;

@end
