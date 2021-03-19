//
//  ZWAlarmStatues.h
//  Muck
//
//  Created by 张威 on 2018/8/2.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWAlarmStatues : NSObject

@property (nonatomic, strong) NSArray *xArray;
@property (nonatomic, strong) NSArray *yValueArray;
@property (nonatomic, assign) CGPoint valueRange;
@property (nonatomic, strong) UIColor *color;
@property (nonatomic, strong) NSArray *legendNameArray;//水平柱状图图例用这个
@property (nonatomic, copy) NSString *legendName;//非水平柱状图图例用这个

@end
