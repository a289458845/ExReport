//
//  ZWAlarmBarChartView.h
//  Muck
//
//  Created by 张威 on 2018/8/1.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

#define numOfBarForVisible 9
#define xLabelHeight 30


@interface ZWAlarmBarChartView : UIView

@property (nonatomic, strong) NSArray *xArray;
@property (nonatomic, strong) NSArray *yValueArray;

@property (nonatomic) float yValueMax;
@property (nonatomic) float yValueMin;

- (void)updateChart;

@end
