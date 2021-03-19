//
//  ZWHorizontalBar.m
//  Muck
//
//  Created by 张威 on 2018/8/13.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWHorizontalBar.h"
#import "ZWHorizontalStrokeLabel.h"

@interface ZWHorizontalBar ()
{
    CAShapeLayer *barLayer;
    UIBezierPath *progressline;
    ZWHorizontalStrokeLabel *lab;
}


@end

@implementation ZWHorizontalBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor clearColor];
        self.alpha = 1.0;
        
        barLayer = [CAShapeLayer layer];
        barLayer.fillColor = [UIColor clearColor].CGColor;
        barLayer.lineWidth = self.bounds.size.height;
        barLayer.strokeEnd = 0;
        [self.layer addSublayer:barLayer];
        
        lab = [[ZWHorizontalStrokeLabel alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height)];
        lab.textAlignment = NSTextAlignmentLeft;
        [self addSubview:lab];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    
}

- (void)setFont:(UIFont *)font
{
    _font = font;
    lab.font = font;
}

-(void)setGrade:(float)grade
{
    if (grade==0)
        return;
    
    _grade = grade;
    
    [self addPath];
    
    CABasicAnimation *pathAnimation = [CABasicAnimation animationWithKeyPath:@"strokeEnd"];
    pathAnimation.duration = 1.5;
    pathAnimation.timingFunction = [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    pathAnimation.fromValue = [NSNumber numberWithFloat:0.0f];
    pathAnimation.toValue = [NSNumber numberWithFloat:1.0f];
    pathAnimation.autoreverses = NO;
    [barLayer addAnimation:pathAnimation forKey:@"strokeEndAnimation"];
    
}

- (void)setValueStr:(NSString *)valueStr
{
    _valueStr = valueStr;
    lab.text = valueStr;
    if (_barColor) {
        lab.textColor = _barColor;
    } else {
        lab.textColor = COLORWITHHEX(kColor_3A62AC);
    }
}

- (void)addPath
{
    progressline = [UIBezierPath bezierPath];
    [progressline moveToPoint:CGPointMake(0, self.frame.size.height/2)];
    [progressline addLineToPoint:CGPointMake(_grade*self.frame.size.width, self.frame.size.height/2)];
    
    barLayer.path = progressline.CGPath;
    barLayer.strokeEnd = 1.0;

    
    if (_barColor) {
        barLayer.strokeColor = [_barColor CGColor];
    }else{
        barLayer.strokeColor = COLORWITHHEX(kColor_3A62AC).CGColor;
    }
}

@end










