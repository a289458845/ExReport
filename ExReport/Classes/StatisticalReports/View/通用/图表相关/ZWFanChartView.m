//
//  ZWFanChartView.m
//  Muck
//
//  Created by 张威 on 2018/8/13.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWFanChartView.h"

@interface ZWFanChartView ()
{
    NSArray *pointArray;
    NSArray *layerArray;
    NSArray *pathArray;
    CGFloat radius;//半径
    CGFloat lineWith;
    float valueSum;
    CAShapeLayer *tapLayer;//上一次点击时的layer
}

@end

@implementation ZWFanChartView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapAction:)];
        [self addGestureRecognizer:tap];
        lineWith = 40;
        radius = MIN(self.frame.size.height/2, self.frame.size.width/2)-10-lineWith/2;
        
    }
    return self;
}

- (void)setValueArray:(NSArray *)valueArray
{
    _valueArray = valueArray;
    
    float total = 0;
    for (int i = 0; i < valueArray.count; i++) {
        float value = [valueArray[i] floatValue];
        total += value;
    }
    valueSum = total;
    
    float x = 0;
    NSMutableArray *temp = @[].mutableCopy;
    for (int i = 0; i < valueArray.count; i++) {
        float value = [valueArray[i] floatValue];
        CGPoint point = CGPointMake(x, value/total+x);
        [temp addObject:[NSValue valueWithCGPoint:point]];
        x = value/total;
    }
    pointArray = temp.copy;
}

- (void)updateChart
{
    NSMutableArray *temp = @[].mutableCopy;
    NSMutableArray *temp1 = @[].mutableCopy;

    for (int i = 0; i < pointArray.count; i++) {
        CGPoint point = [pointArray[i] CGPointValue];
        UIBezierPath *path = [UIBezierPath bezierPathWithArcCenter:self.center radius:radius startAngle:point.x*M_PI*2 endAngle:point.y*M_PI*2 clockwise:YES];
        CAShapeLayer *layer = [CAShapeLayer layer];
        layer.fillColor = [UIColor clearColor].CGColor;
        UIColor *color = self.colorArray[i];
        layer.strokeColor = color.CGColor;
        layer.lineWidth = lineWith;
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        
        [self addAnimationWithLayer:layer];
        
        [temp addObject:layer];
        [temp1 addObject:path];
    }
    layerArray = temp.copy;
    pathArray = temp1.copy;
    
    //画标注
    for (int i = 0; i < pointArray.count; i++) {
        CGPoint p = [pointArray[i] CGPointValue];
        //起始点
        CGPoint begin = CGPointMake((radius+lineWith/2)*cos(p.y*M_PI)+self.center.x, (radius+lineWith/2)*sin(p.y*M_PI)+self.center.y);
        //终点
        CGPoint end;
        if (i == 0) {
            end = CGPointMake(self.center.x+radius+lineWith, self.center.y);
        } else {
            end = CGPointMake(self.center.x-(radius+lineWith), self.center.y);
        }
        UIBezierPath *path = [UIBezierPath bezierPath];
        [path moveToPoint:begin];
        [path addLineToPoint:end];
        CAShapeLayer *layer = [CAShapeLayer layer];
        UIColor *color = self.colorArray[i];
        layer.fillColor = color.CGColor;
        layer.strokeColor = color.CGColor;
        layer.lineWidth = 1;
        layer.path = path.CGPath;
        [self.layer addSublayer:layer];
        
        
        UILabel *lab = [[UILabel alloc] init];
        lab.font = kSystemFont(22);
        lab.textColor = [UIColor blackColor];
        NSString *name = [NSString stringWithFormat:@"%@%@个",self.valueNameArray[i],self.valueArray[i]];
        NSDictionary *attri = @{NSFontAttributeName:kSystemFont(22),NSForegroundColorAttributeName:[UIColor blackColor]};
        CGSize size = [name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:1 attributes:attri context:nil].size;
        lab.text = name;
        lab.frame = CGRectMake(end.x-size.width/2, end.y-size.height, size.width, size.height);
        [self addSubview:lab];
//        [self.layer addSublayer:lab.layer];
//        //终点
//        CGPoint end = CGPointMake((radius-lineWith)*cos(p.y*M_PI)+self.center.x, (radius-lineWith)*sin(p.y*M_PI)+self.center.y);
//        UIBezierPath *path = [UIBezierPath bezierPath];
//        [path moveToPoint:begin];
//        [path addLineToPoint:end];
//        CAShapeLayer *layer = [CAShapeLayer layer];
//        UIColor *color = self.colorArray[i];
//        layer.fillColor = color.CGColor;
//        layer.strokeColor = color.CGColor;
//        layer.path = path.CGPath;
//        layer.lineWidth = 1;
//        [self.layer addSublayer:layer];
    }
}

//- (void)drawRect:(CGRect)rect
//{
//    CGContextRef ctx = UIGraphicsGetCurrentContext();
//    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
//    CGContextFillRect(ctx, rect);
//    //画标注
//    for (int i = 0; i < pointArray.count; i++) {
//        CGPoint p = [pointArray[i] CGPointValue];
//        //起始点
//        CGPoint center = CGPointMake(radius*cos(p.y*M_PI)+self.center.x, radius*sin(p.y*M_PI)+self.center.y);
//        NSString *name = [NSString stringWithFormat:@"%@%@个",self.valueNameArray[i],self.valueArray[i]];
//        NSDictionary *attri = @{NSFontAttributeName:kSystemFont(22),NSForegroundColorAttributeName:[UIColor blackColor]};
//        CGSize size = [name boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:1 attributes:attri context:nil].size;
//        [name drawInRect:CGRectMake(center.x-size.width/2, center.y-size.height/2, size.width, size.height) withAttributes:attri];
//
//    }
//}

- (void)addAnimationWithLayer:(CAShapeLayer *)layer
{
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [layer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

- (void)tapAction:(UITapGestureRecognizer *)tap
{
    CGPoint tapPoint = [tap locationInView:self];
    double Y = hypot(fabs(tapPoint.x-self.center.x), fabs(tapPoint.y-self.center.y));
    double R = radius+lineWith/2;
    if (Y <= R) {

        double v = 0;
        
        if (tapPoint.x > self.center.x && tapPoint.y >= self.center.y) {
            //触点在四象限
            v = acos((tapPoint.x-self.center.x)/Y)/(M_PI*2)*valueSum;
            
        }
        if (tapPoint.x <= self.center.x && tapPoint.y > self.center.y) {
            //触点在三象限
            v = acos((tapPoint.x-self.center.x)/Y)/(M_PI*2)*valueSum;
        }
        if (tapPoint.x < self.center.x && tapPoint.y <= self.center.y) {
            //触点在二象限
            v = acos((tapPoint.x-self.center.x)/-Y)/(M_PI*2)*valueSum+valueSum/2;
        }
        if (tapPoint.x >= self.center.x && tapPoint.y < self.center.y) {
            //触点在一象限
            v = acos((tapPoint.x-self.center.x)/-Y)/(M_PI*2)*valueSum+valueSum/2;
        }
        printf("%f\n",v);
        int index;
        float minValue = 0;
        for (int i = 0; ; i++) {
            float value = [self.valueArray[i] floatValue] + minValue;
            if (v <= value) {
                index = i;
                break;
            }
            minValue = value;
        }
        CAShapeLayer *layer = layerArray[index];
        if (tapLayer == layer) {
            layer.lineWidth = lineWith;
            tapLayer = nil;
        } else {
            if (tapLayer) {
                tapLayer.lineWidth = lineWith;
            }
            layer.lineWidth = 50;
            tapLayer = layer;
        }
        
        
        
        
    }
    
}

@end




