//
//  ZWHorizontalBarChartView.m
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWHorizontalBarChartView.h"
#import "ZWAlarmChartLabel.h"
#import "ZWHorizontalBar.h"

typedef NS_ENUM(NSInteger, ZWBarChartType) {
    ZWBarChartTypeSingle,
    ZWBarChartTypeDouble,
};

@interface ZWHorizontalBarChartView ()
{
    ZWBarChartType type;
}
//@property (nonatomic, strong) UIView *legendIcon;
//@property (nonatomic, strong) UILabel *legendLab;

@end

@implementation ZWHorizontalBarChartView

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
   
    }
    return self;
}

- (void)setYValueArray:(NSArray *)yValueArray{
    _yValueArray = yValueArray;
    if (yValueArray.count) {
        id v = yValueArray[0];
        if ([v isKindOfClass:[NSArray class]]) {
            type = ZWBarChartTypeDouble;
        } else {
            type = ZWBarChartTypeSingle;
        }
    }
}

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetFillColorWithColor(ctx, [UIColor whiteColor].CGColor);
    CGContextFillRect(ctx, rect);
    
    CGFloat right = CGRectGetWidth(rect)-kWidth(40);
    
    UIBezierPath *axisPath = [UIBezierPath bezierPath];
    //上y轴
    [axisPath moveToPoint:CGPointMake(barX, topMargin)];
    [axisPath addLineToPoint:CGPointMake(right, topMargin)];
    //下y轴
    [axisPath moveToPoint:CGPointMake(barX, self.xArray.count*xLabelHeight+topMargin)];
    [axisPath addLineToPoint:CGPointMake(right, self.xArray.count*xLabelHeight+topMargin)];
    //x轴
    [axisPath moveToPoint:CGPointMake(barX, topMargin)];
    [axisPath addLineToPoint:CGPointMake(barX, self.xArray.count*xLabelHeight+topMargin)];
    
    if (type == ZWBarChartTypeSingle) {
        //y轴参考线
        CGFloat margin = (right-kWidth(40)-barX)/4;
        for (int i = 1; i <= 4; i++) {
            [axisPath moveToPoint:CGPointMake(i*margin+barX, topMargin)];
            [axisPath addLineToPoint:CGPointMake(i*margin+barX, self.xArray.count*xLabelHeight+topMargin)];
        }
    }
    if (type == ZWBarChartTypeDouble) {
        //x轴上每个数据的分割线
        for (int i = 1; i < _xArray.count; i++) {
            [axisPath moveToPoint:CGPointMake(barX, i*xLabelHeight+topMargin)];
            [axisPath addLineToPoint:CGPointMake(right, i*xLabelHeight+topMargin)];
        }
    }
    
    //图例
    if (type == ZWBarChartTypeSingle) {
        NSDictionary *attris = @{NSFontAttributeName:kSystemFont(20),NSForegroundColorAttributeName:COLORWITHHEX(kColor_3A3D44)};
        NSString *text = self.legendNameArray.firstObject;
        CGSize size = [text boundingRectWithSize:CGSizeMake(MAXFLOAT, MAXFLOAT) options:NSStringDrawingUsesLineFragmentOrigin attributes:attris context:nil].size;
        [text drawInRect:CGRectMake(rect.size.width-kWidth(80)-size.width, 0, size.width, size.height) withAttributes:attris];
        
        CGContextSaveGState(ctx);
        CGContextSetFillColorWithColor(ctx, COLORWITHHEX(kColor_3A62AC).CGColor);
        CGContextSetStrokeColorWithColor(ctx, COLORWITHHEX(kColor_3A62AC).CGColor);
        UIBezierPath *legendPath = [UIBezierPath bezierPathWithRect:CGRectMake(rect.size.width-kWidth(80)-size.width-6-8, (size.height-8)/2, 8, 8)];
        CGContextAddPath(ctx, legendPath.CGPath);
        CGContextDrawPath(ctx, kCGPathFillStroke);
        CGContextRestoreGState(ctx);
    }
    
    
    CGContextAddPath(ctx, axisPath.CGPath);
    CGContextSetStrokeColorWithColor(ctx, [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor]);
    CGContextSetFillColorWithColor(ctx, [[[UIColor blackColor] colorWithAlphaComponent:0.1] CGColor]);
    CGContextSetLineWidth(ctx, 1);
    CGContextDrawPath(ctx, kCGPathFillStroke);
    
    
}

- (void)setXArray:(NSArray *)xArray
{
    _xArray = xArray;
    
    for (int i = 0; i < xArray.count; i++) {
        
        ZWAlarmChartLabel *lab = [[ZWAlarmChartLabel alloc] initWithFrame:CGRectMake(0, i*xLabelHeight+topMargin, xLabelWidth, xLabelHeight)];
        lab.text = xArray[i];
        lab.textAlignment = NSTextAlignmentRight;
        lab.numberOfLines = 0;
        lab.textColor = COLORWITHHEX(kColor_3A3D44);
        lab.font = kSystemFont(20);
        [self addSubview:lab];
    }
    
}



- (void)updateChart
{
    CGFloat barW = kScreenWidth-20-barX-kWidth(40)-kWidth(40);
    
    if (type == ZWBarChartTypeSingle) {
        
        for (int i = 0; i < _xArray.count; i++) {
            
            NSString *valueString = self.yValueArray[i];
            float value = [valueString floatValue];
            float grade = 0;
            if ((float)_yValueMax-_yValueMin) {
                grade = (value-_yValueMin) / ((float)_yValueMax-_yValueMin);
            }
            
            /*  0.1-0.8-0.1  */
            ZWHorizontalBar *bar = [[ZWHorizontalBar alloc] initWithFrame:CGRectMake(barX, i*xLabelHeight+0.1*xLabelHeight+topMargin, barW, xLabelHeight*0.8)];
            bar.grade = grade;
//            bar.valueStr = valueString;
            [self addSubview:bar];
            
            //添加柱状图上的数值标注
            CGRect rect = CGRectMake(barX+barW*grade, i*xLabelHeight+0.1*xLabelHeight+topMargin, xLabelHeight, xLabelHeight*0.8);
            ZWAlarmChartLabel *lab = [[ZWAlarmChartLabel alloc] initWithFrame:CGRectMake(barX, i*xLabelHeight+0.1*xLabelHeight+topMargin, xLabelHeight, xLabelHeight*0.8)];
            lab.textAlignment = NSTextAlignmentLeft;
            lab.text = valueString;
            [lab sizeToFit];
            CGSize size = lab.frame.size;
            lab.frame = CGRectMake(barX, i*xLabelHeight+0.1*xLabelHeight+topMargin, size.width, xLabelHeight*0.8);
            rect.size.width = size.width;
            [self addSubview:lab];
            
            [UIView animateWithDuration:1.5 animations:^{
                lab.frame = rect;
            }];
        }
        
        
    } else {
        
        for (int i = 0; i < _yValueArray.count; i++) {
            
            for (int j = 0; j < _xArray.count; j++) {
                
                NSArray *valueArray = _yValueArray[i];
                NSString *valueString = valueArray[j];
                float value = [valueString floatValue];
                float grade = (value-_yValueMin) / ((float)_yValueMax-_yValueMin);
                
                /*  0.05-0.4-0.1-0.4-0.05   */
                ZWHorizontalBar *bar = [[ZWHorizontalBar alloc] initWithFrame:CGRectMake(barX, 0.05*xLabelHeight+i*(0.4*xLabelHeight+0.1*xLabelHeight)+j*xLabelHeight+topMargin, barW, 0.4*xLabelHeight)];
                bar.font = kSystemFont(24);
                bar.grade = grade;
//                bar.valueStr = valueString;
                [self addSubview:bar];
                
                
                //添加柱状图上的数值标注
                CGRect rect = CGRectMake(barX+barW*grade, 0.05*xLabelHeight+i*(0.4*xLabelHeight+0.1*xLabelHeight)+j*xLabelHeight+topMargin, 0, 0.4*xLabelHeight);
                ZWAlarmChartLabel *lab = [[ZWAlarmChartLabel alloc] initWithFrame:CGRectMake(barX, 0.05*xLabelHeight+i*(0.4*xLabelHeight+0.1*xLabelHeight)+j*xLabelHeight+topMargin, 0, 0.4*xLabelHeight)];
                lab.textAlignment = NSTextAlignmentLeft;
                lab.text = valueString;
                [lab sizeToFit];
                CGSize size = lab.frame.size;
                lab.frame = CGRectMake(barX, 0.05*xLabelHeight+i*(0.4*xLabelHeight+0.1*xLabelHeight)+j*xLabelHeight+topMargin, size.width, 0.4*xLabelHeight);
                rect.size.width = size.width;
                [self addSubview:lab];
                
                [UIView animateWithDuration:1.5 animations:^{
                    lab.frame = rect;
                }];
            }
        }
        
        
        
    }
    //y轴
    CGFloat labW = barW/4;
    float level = (_yValueMax-_yValueMin)/4;
    
    
    for (int i = 0; i < 5; i++) {
        ZWAlarmChartLabel *lab = [[ZWAlarmChartLabel alloc] initWithFrame:CGRectMake(i*labW-labW/2+barX, topMargin-20, labW, 20)];
        lab.text = [NSString stringWithFormat:@"%.0f",_yValueMin+i*level];
        [self addSubview:lab];
    }
    
    for (int i = 0; i < 5; i++) {
        ZWAlarmChartLabel *lab = [[ZWAlarmChartLabel alloc] initWithFrame:CGRectMake(i*labW-labW/2+barX, self.xArray.count*xLabelHeight+topMargin, labW, 20)];
        lab.text = [NSString stringWithFormat:@"%.0f",_yValueMin+i*level];
        [self addSubview:lab];
    }
    
}



@end
