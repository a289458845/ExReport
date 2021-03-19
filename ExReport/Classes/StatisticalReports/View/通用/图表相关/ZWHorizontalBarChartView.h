//
//  ZWHorizontalBarChartView.h
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

#define xLabelWidth 50
#define xLabelHeight 30
#define topMargin 40
#define yLabelHeight 20
#define barX (xLabelWidth+kWidth(10))


@interface ZWHorizontalBarChartView : UIView

@property (nonatomic, strong) NSArray *xArray;
@property (nonatomic, strong) NSArray *yValueArray;

@property (nonatomic) float yValueMax;
@property (nonatomic) float yValueMin;

@property (nonatomic, strong) NSArray *legendNameArray;

- (void)updateChart;

@end
