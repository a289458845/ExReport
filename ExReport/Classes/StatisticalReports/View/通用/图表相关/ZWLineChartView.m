//
//  ZWLineChartView.m
//  Muck
//
//  Created by 张威 on 2018/8/2.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWLineChartView.h"
#import "ZWLineChartLabel.h"

@interface ZWLineChartView ()
{
    UIScrollView *scrollView;
    CGFloat xLabelWidth;
}

@end

@implementation ZWLineChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        scrollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        scrollView.showsHorizontalScrollIndicator = NO;
        scrollView.bounces = NO;
        [self addSubview:scrollView];
    }
    return self;
}


- (void)setXArray:(NSArray *)xArray
{
    _xArray = xArray;
    
    NSInteger num;
    if (xArray.count-1 >= numOfLineForVisible) {
        num = numOfLineForVisible;
    } else {
        num = xArray.count;
    }
    if (num == 0) {
        num = 2;
    }
    
    xLabelWidth = scrollView.frame.size.width/num;
    
    for (int i = 0; i < xArray.count; i++) {
        
        ZWLineChartLabel *lab = [[ZWLineChartLabel alloc] initWithFrame:CGRectMake(i*xLabelWidth, CGRectGetHeight(scrollView.frame)-xLabelHeight, xLabelWidth, xLabelHeight)];
        lab.text = xArray[i];
        lab.textColor = self.xColor;
        [scrollView addSubview:lab];
    }
    scrollView.contentSize = CGSizeMake(xArray.count*xLabelWidth, scrollView.frame.size.height);
}



- (void)updateChart
{
    NSMutableArray *points = @[].mutableCopy;
    //划线初始化
    CAShapeLayer *_chartLine = [CAShapeLayer layer];
    _chartLine.lineCap = kCALineCapRound;
    _chartLine.lineJoin = kCALineJoinBevel;
    _chartLine.fillColor   = [[UIColor clearColor] CGColor];
    _chartLine.lineWidth   = 1.0;
    _chartLine.strokeEnd   = 0.0;
    _chartLine.lineDashPattern = @[@4,@2];
    [scrollView.layer addSublayer:_chartLine];
    
    
    UIBezierPath *progressline = [UIBezierPath bezierPath];

    float firstValue = [self.yValueArray[0] floatValue];
    float grade = (firstValue-_yValueMin)/(_yValueMax-_yValueMin);
    CGFloat xPosition = xLabelWidth/2;
    float height = scrollView.frame.size.height-xLabelHeight*2;
    

    
    CGPoint point = CGPointMake(xPosition, height-grade*height+xLabelHeight);
    [points addObject:[NSValue valueWithCGPoint:point]];
    [self addPoint:point];
    [progressline moveToPoint:point];
    
    for (int i = 1; i < self.yValueArray.count; i++) {
        float value = [self.yValueArray[i] floatValue];
        grade = (value-_yValueMin)/(_yValueMax-_yValueMin);
        point = CGPointMake(xPosition+xLabelWidth*i, height-grade*height+xLabelHeight);
        [self addPoint:point];
        [progressline addLineToPoint:point];
        [points addObject:[NSValue valueWithCGPoint:point]];
    }
    _chartLine.path = progressline.CGPath;
    _chartLine.strokeColor = self.yPointColor.CGColor;
 

    
    [self addAnimationWithLayer:_chartLine];
    
    _chartLine.strokeEnd = 1;
    
//    NSValue *v1 = points[0];
//    NSValue *v2 = points[1];
    
//    [self drawMaskWithStartPoint:[v1 CGPointValue] endPoint:[v2 CGPointValue]];
    [self drawMaskWithPoints:points];
    [self addValueLabelWithPoints:points];
}

- (void)addPoint:(CGPoint)point
{
    UIView *pointView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 6, 6)];
    pointView.center = point;
    pointView.backgroundColor = self.yPointColor;
    pointView.layer.cornerRadius = CGRectGetWidth(pointView.frame)/2;
    pointView.layer.masksToBounds = YES;
    [scrollView addSubview:pointView];
}

- (void)addValueLabelWithPoints:(NSArray *)points
{
    for (int i = 0; i < points.count; i++) {
        CGPoint point = [points[i] CGPointValue];
        UILabel *lab = [[UILabel alloc] init];
        lab.textColor = self.yColor;
        lab.font = kSystemFont(24);
        lab.text = [NSString stringWithFormat:@"%@",self.yValueArray[i]];
        [lab sizeToFit];
        
        lab.center = point;
        CGRect rect = lab.frame;
        rect.origin.y -= rect.size.height;
        lab.frame = rect;
        
        [scrollView addSubview:lab];
    }
}

//画蒙层
- (void)drawMaskWithStartPoint:(CGPoint)start endPoint:(CGPoint)end
{
    CAShapeLayer *layer = [CAShapeLayer layer];
//    layer.fillColor = [UIColor colorWithWhite:1 alpha:0.3].CGColor;
    layer.fillColor = self.maskColor.CGColor;
    [scrollView.layer addSublayer:layer];
    
    float height = scrollView.frame.size.height-xLabelHeight;
    UIBezierPath *path = [UIBezierPath bezierPath];
    [path moveToPoint:start];
    [path addLineToPoint:end];
    [path addLineToPoint:CGPointMake(end.x, height)];
    [path addLineToPoint:CGPointMake(start.x, height)];
    
    layer.path = path.CGPath;
}

- (void)drawMaskWithPoints:(NSArray *)points
{
    if (points.count < 2) {
        return;
    }
    CAShapeLayer *layer = [CAShapeLayer layer];
    layer.fillColor = [UIColor colorWithWhite:1 alpha:0.3].CGColor;
    [scrollView.layer addSublayer:layer];
    float height = scrollView.frame.size.height-xLabelHeight;
    UIBezierPath *path = [UIBezierPath bezierPath];
    CGPoint firstPoint = [points[0] CGPointValue];
    [path moveToPoint:firstPoint];
    for (int i = 1; i < points.count; i++) {
        [path addLineToPoint:[points[i] CGPointValue]];
    }
    CGPoint lastPoint = [points.lastObject CGPointValue];
    [path addLineToPoint:CGPointMake(lastPoint.x, height)];
    [path addLineToPoint:CGPointMake(firstPoint.x, height)];
    
    layer.path = path.CGPath;
}

- (void)addAnimationWithLayer:(CAShapeLayer *)layer
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 2;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

@end
