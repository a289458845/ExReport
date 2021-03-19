//
//  UILabel+BasicAttributes.m
//  MonitoringNetwork
//
//  Created by admin on 2017/12/4.
//  Copyright © 2017年 wtmcxlm. All rights reserved.
//

#import "UILabel+BasicAttributes.h"




@implementation UILabel (BasicAttributes)


+ (UILabel *)LabelWithFont:(UIFont *)font
                  andColor:(UIColor *)color
          andTextAlignment:(TextAlignment)textAlignment
{
    UILabel *label = [UILabel new];
    label.font = font;
    switch (textAlignment) {
        case 0:
            label.textAlignment = NSTextAlignmentCenter;
            break;
        case 1:
            label.textAlignment = NSTextAlignmentLeft;
            break;
        case 2:
            label.textAlignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }
    label.textColor = color;
    
    return label;
}
+ (UILabel *)LabelWithFont:(UIFont *)font
                  andColor:(UIColor *)color
          andTextAlignment:(TextAlignment)textAlignment
                 andString:(NSString *)title
{
    UILabel *label = [UILabel new];
    label.text = title;
    label.font = font;
    switch (textAlignment) {
        case 0:
            label.textAlignment = NSTextAlignmentCenter;
            break;
        case 1:
            label.textAlignment = NSTextAlignmentLeft;
            break;
        case 2:
            label.textAlignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }
    label.textColor = color;
    
    return label;
}
+ (UILabel *)addLineLabelWithFont:(UIFont *)font
                  andColor:(UIColor *)color
          andTextAlignment:(TextAlignment)textAlignment
                 andString:(NSString *)title
{
    UILabel *label = [UILabel new];
    NSDictionary *attribtDic = @{NSUnderlineStyleAttributeName: [NSNumber numberWithInteger:NSUnderlineStyleSingle]};
    NSMutableAttributedString *attribtStr = [[NSMutableAttributedString alloc]initWithString:title attributes:attribtDic];
    label.attributedText = attribtStr;
    label.font = font;
    switch (textAlignment) {
        case 0:
            label.textAlignment = NSTextAlignmentCenter;
            break;
        case 1:
            label.textAlignment = NSTextAlignmentLeft;
            break;
        case 2:
            label.textAlignment = NSTextAlignmentRight;
            break;
        default:
            break;
    }
    label.textColor = color;
    
    return label;
}







@end
