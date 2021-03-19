//
//  ZWAlarmBar.m
//  Muck
//
//  Created by 张威 on 2018/8/1.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWAlarmBar.h"
#import "ZWVerticalStrokeLabel.h"

@interface ZWAlarmBar ()
{
    CAShapeLayer *barLayer;
    ZWVerticalStrokeLabel *label;
}


@end

@implementation ZWAlarmBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1.0;

 
        
        barLayer = [CAShapeLayer layer];
        barLayer.fillColor = [UIColor clearColor].CGColor;
        barLayer.lineWidth = self.frame.size.width;
        barLayer.strokeEnd = 0;
        [self.layer addSublayer:barLayer];
        
        label = [[ZWVerticalStrokeLabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        [self addSubview:label];
        
    }
    return self;
}

- (void)setValueStr:(NSString *)valueStr{
    _valueStr = valueStr;
    label.text = valueStr;
    if (_barColor) {
        label.textColor = _barColor;
    }else{
        label.textColor = COLORWITHHEX(kColor_3A62AC);
    }
}

-(void)setGrade:(float)grade
{
    if (grade==0)
        return;
    
    _grade = grade;
    
    [self addPathWithLineWidth:self.bounds.size.width];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [barLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
}

- (void)addPathWithLineWidth:(CGFloat)lineWidth{
    UIBezierPath *progressline = [UIBezierPath bezierPath];
    [progressline moveToPoint:CGPointMake(self.frame.size.width/2.0, self.frame.size.height)];
    [progressline addLineToPoint:CGPointMake(self.frame.size.width/2.0, (1 - _grade) * self.frame.size.height)];
    
    barLayer.path = progressline.CGPath;
    barLayer.strokeEnd = 1.0;
    barLayer.lineWidth = lineWidth;
    
    if (_barColor) {
        barLayer.strokeColor = [_barColor CGColor];
    }else{
        barLayer.strokeColor = COLORWITHHEX(kColor_45ACF5).CGColor;
    }
}

@end
