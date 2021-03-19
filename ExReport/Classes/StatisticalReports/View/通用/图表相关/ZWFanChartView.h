//
//  ZWFanChartView.h
//  Muck
//
//  Created by 张威 on 2018/8/13.
//  Copyright © 2018年 张威. All rights reserved.
//

/**
 * 饼状图
 **/
#import <UIKit/UIKit.h>

@interface ZWFanChartView : UIView

@property (nonatomic, strong) NSArray *valueArray;
@property (nonatomic, strong) NSArray *colorArray;
@property (nonatomic, strong) NSArray *valueNameArray;

- (void)updateChart;

@end
