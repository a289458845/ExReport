//
//  ZWVerticalStrokeLabel.m
//  Muck
//
//  Created by 张威 on 2018/8/2.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWVerticalStrokeLabel.h"

@implementation ZWVerticalStrokeLabel

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextRotateCTM(ctx, -M_PI_2);
    CGContextTranslateCTM(ctx, -(rect.size.height), -(rect.size.height/2-rect.size.width/2));
    
    CGContextSetLineWidth(ctx, 0.5);
    
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(ctx, kCGTextStroke);
    
    
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    
    self.textColor = [UIColor whiteColor];
    
    [super drawTextInRect:rect];
    
    
}

@end
