//
//  UILabel+BasicAttributes.h
//  MonitoringNetwork
//
//  Created by admin on 2017/12/4.
//  Copyright © 2017年 wtmcxlm. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef enum{
    center=0,
    left=1,
    right=2,
    
}TextAlignment;
@interface UILabel (BasicAttributes)


+ (UILabel *)LabelWithFont:(UIFont *)font
                  andColor:(UIColor *)color
          andTextAlignment:(TextAlignment)textAlignment;
+ (UILabel *)LabelWithFont:(UIFont *)font
                  andColor:(UIColor *)color
          andTextAlignment:(TextAlignment)textAlignment
                 andString:(NSString *)title;
+ (UILabel *)addLineLabelWithFont:(UIFont *)font
                         andColor:(UIColor *)color
                 andTextAlignment:(TextAlignment)textAlignment
                        andString:(NSString *)title;
@end
