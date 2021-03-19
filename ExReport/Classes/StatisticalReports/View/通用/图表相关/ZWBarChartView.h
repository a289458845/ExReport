//
//  ZWBarChartView.h
//  Muck
//
//  Created by 张威 on 2018/8/8.
//  Copyright © 2018年 张威. All rights reserved.
//

/**
 * 条形图
 **/
#import <UIKit/UIKit.h>

#define numOfBarForVisible 9
#define xLabelHeight 30

@interface ZWBarChartView : UIView

@property (nonatomic, strong) NSArray *xArray;
@property (nonatomic, strong) NSArray *yValueArray;

@property (nonatomic) float yValueMax;
@property (nonatomic) float yValueMin;

@property (nonatomic, copy) NSString *legendName;

- (void)updateChart;

@end
