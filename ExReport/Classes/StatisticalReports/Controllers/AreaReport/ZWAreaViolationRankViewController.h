//
//  ZWAreaViolationRankViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//  区域未密闭率、区域超速率

#import "rBaseViewController.h"

typedef NS_ENUM(NSInteger, ZWTimeType) {
    ZWTimeDay,
    ZWTimeWeek,
    ZWTimeMonth,
};

typedef NS_ENUM(NSInteger, ZWAreaViolationRankViewControllerType) {
    ZWAreaViolationRankViewControllerUnClosenessRate,//区域未密闭率
    ZWAreaViolationRankViewControllerOverspeedRate,//区域超速率
};

@interface ZWAreaViolationRankViewController : rBaseViewController

@property (nonatomic) ZWAreaViolationRankViewControllerType controllerType;

@end
