//
//  ZWHorizontalBar.h
//  Muck
//
//  Created by 张威 on 2018/8/13.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWHorizontalBar : UIView

@property (nonatomic) float grade;

@property (nonatomic, strong) UIColor * barColor;

@property (nonatomic, copy) NSString *valueStr;

@property (nonatomic, strong) UIFont *font;

@end
