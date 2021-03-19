//
//  ZWHorizontalStrokeLabel.m
//  Muck
//
//  Created by 张威 on 2018/8/13.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWHorizontalStrokeLabel.h"

@implementation ZWHorizontalStrokeLabel

- (void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextSetLineWidth(ctx, 0.5);
    
    CGContextSetLineJoin(ctx, kCGLineJoinRound);
    
    CGContextSetTextDrawingMode(ctx, kCGTextStroke);
    
    
    [super drawTextInRect:rect];
    
    CGContextSetTextDrawingMode(ctx, kCGTextFill);
    
    self.textColor = [UIColor whiteColor];
    
    [super drawTextInRect:rect];
    
    
}

@end
