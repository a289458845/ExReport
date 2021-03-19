//
//  ZWBarChartView.m
//  Muck
//
//  Created by 张威 on 2018/8/8.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWBarChartView.h"
#import "ZWAlarmChartLabel.h"
#import "ZWAlarmBar.h"

#define yLabelWidth 40//y轴坐标的宽度
#define margin 20//上部间距
#define legendHeight 20//标注数据的高度

@interface ZWBarChartView ()
{
    UIScrollView *scrollView;
    CGFloat xLabelWidth;
}

@property (nonatomic, strong) UIView *legendIcon;
@property (nonatomic, strong) UILabel *legendLab;

@end

@implementation ZWBarChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //画刻度
        for (int i = 0; i < 6; i++) {
            //刻度的y值
            CGFloat y = ((frame.size.height-margin)-xLabelHeight)-i*((frame.size.height-margin)-xLabelHeight-legendHeight)/5+margin;
            CAShapeLayer *shapeLayer = [CAShapeLayer layer];
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:CGPointMake(yLabelWidth, y)];
            [path addLineToPoint:CGPointMake(frame.size.width-yLabelWidth, y)];
            shapeLayer.path = path.CGPath;
            shapeLayer.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];


            shapeLayer.fillColor = [[UIColor whiteColor] CGColor];
            shapeLayer.lineWidth = 1;
            [self.layer addSublayer:shapeLayer];
        }
        //画y轴
        CAShapeLayer *shapeLayer1 = [CAShapeLayer layer];
        UIBezierPath *path1 = [UIBezierPath bezierPath];
        [path1 moveToPoint:CGPointMake(yLabelWidth, margin)];
        [path1 addLineToPoint:CGPointMake(yLabelWidth, frame.size.height-xLabelHeight)];
        shapeLayer1.path = path1.CGPath;
        shapeLayer1.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
        shapeLayer1.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer1.lineWidth = 1;
        [self.layer addSublayer:shapeLayer1];
        //画y轴
        CAShapeLayer *shapeLayer2 = [CAShapeLayer layer];
        UIBezierPath *path2 = [UIBezierPath bezierPath];
        [path2 moveToPoint:CGPointMake(frame.size.width-yLabelWidth, margin)];
        [path2 addLineToPoint:CGPointMake(frame.size.width-yLabelWidth, frame.size.height-xLabelHeight)];
        shapeLayer2.path = path2.CGPath;
        shapeLayer2.strokeColor = [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor];
        shapeLayer2.fillColor = [[UIColor whiteColor] CGColor];
        shapeLayer2.lineWidth = 1;
        [self.layer addSublayer:shapeLayer2];
        
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(yLabelWidth, margin, frame.size.width-yLabelWidth*2, frame.size.height-margin)];
        scrollView.bounces = NO;
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.backgroundColor = [UIColor clearColor];
        [self addSubview:scrollView];
        
        
        
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    scrollView.frame = CGRectMake(yLabelWidth, margin, self.frame.size.width-yLabelWidth*2, self.frame.size.height-margin);
}


- (void)setXArray:(NSArray *)xArray
{
    _xArray = xArray;
    
    NSInteger num;
    if (xArray.count >= numOfBarForVisible) {
        num = numOfBarForVisible;
    } else {
        num = xArray.count;
    }
    
    xLabelWidth = scrollView.frame.size.width/num;
    
    for (int i =0; i < xArray.count; i++) {
        
        ZWAlarmChartLabel *lab = [[ZWAlarmChartLabel alloc] initWithFrame:CGRectMake(i*xLabelWidth, CGRectGetHeight(scrollView.frame)-xLabelHeight, xLabelWidth, xLabelHeight)];
        lab.text = xArray[i];
        [scrollView addSubview:lab];
    }
    
    scrollView.contentSize = CGSizeMake(xArray.count*xLabelWidth, scrollView.frame.size.height);
}

- (void)updateChart{
    for (int i = 0; i < 6; i++) {
        //刻度的y值
        CGFloat y = (CGRectGetHeight(scrollView.frame)-xLabelHeight)-i*(CGRectGetHeight(scrollView.frame)-xLabelHeight-legendHeight)/5+margin;
        ZWAlarmChartLabel *lab = [[ZWAlarmChartLabel alloc] initWithFrame:CGRectMake(0, 0, yLabelWidth, 0)];
        float text = (_yValueMax - _yValueMin)/5*i + _yValueMin;
        lab.text = [NSString stringWithFormat:@"%.1f",text];
        [lab sizeToFit];
        CGRect rect = lab.frame;
        rect.origin.y = y-rect.size.height/2;
        rect.size.width = yLabelWidth;
        lab.frame = rect;
        [self addSubview:lab];
    }
    
    for (int i = 0; i < 6; i++) {
        //刻度的y值
        CGFloat y = (CGRectGetHeight(scrollView.frame)-xLabelHeight)-i*(CGRectGetHeight(scrollView.frame)-xLabelHeight-legendHeight)/5+margin;
        ZWAlarmChartLabel *lab = [[ZWAlarmChartLabel alloc] initWithFrame:CGRectMake(CGRectGetMaxX(scrollView.frame), 0, yLabelWidth, 0)];
        float text = (_yValueMax - _yValueMin)/5*i + _yValueMin;
        lab.text = [NSString stringWithFormat:@"%.1f",text];
        [lab sizeToFit];
        CGRect rect = lab.frame;
        rect.origin.y = y-rect.size.height/2;
        rect.size.width = yLabelWidth;
        lab.frame = rect;
        [self addSubview:lab];
    }
    
    
    for (int i = 0; i < _xArray.count; i++) {
        NSString *valueString = self.yValueArray[i];
        float value = [valueString floatValue];
        float grade = 0;
        if (((float)_yValueMax-_yValueMin)) {
            grade = (value-_yValueMin) / ((float)_yValueMax-_yValueMin);
        }
        
        ZWAlarmBar *bar = [[ZWAlarmBar alloc] initWithFrame:CGRectMake(i*xLabelWidth+0.1*xLabelWidth, legendHeight, xLabelWidth*0.8, scrollView.frame.size.height-xLabelHeight-legendHeight)];
//        bar.valueStr = valueString;
        bar.grade = grade;
        [scrollView addSubview:bar];
        
        //添加柱状图上的数值标注
        CGRect rect = CGRectMake(i*xLabelWidth, CGRectGetMinY(bar.frame)-legendHeight+CGRectGetHeight(bar.frame)*(1-grade), xLabelWidth, legendHeight);
        ZWAlarmChartLabel *lab = [[ZWAlarmChartLabel alloc] initWithFrame:CGRectMake(i*xLabelWidth, CGRectGetHeight(bar.frame), xLabelWidth, legendHeight)];
        lab.text = valueString;
        [scrollView addSubview:lab];
        
        [UIView animateWithDuration:1.5 animations:^{
            lab.frame = rect;
        }];
    }
    
    //图例
    self.legendLab = [[UILabel alloc] init];
    self.legendLab.font = kSystemFont(20);
    self.legendLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.legendLab.text = self.legendName;
    [self.legendLab sizeToFit];
    CGRect rect = self.legendLab.frame;
    rect.origin.x = self.frame.size.width-40-rect.size.width;
    rect.origin.y = 0;
    self.legendLab.frame = rect;
    [self addSubview:self.legendLab];
    self.legendIcon = [[UIView alloc] initWithFrame:CGRectMake(CGRectGetMinX(self.legendLab.frame)-6-8, CGRectGetMinY(self.legendLab.frame)+(CGRectGetHeight(self.legendLab.frame)-8)/2, 8, 8)];
    self.legendIcon.backgroundColor = COLORWITHHEX(kColor_3A62AC);
    [self addSubview:self.legendIcon];
}

@end

















