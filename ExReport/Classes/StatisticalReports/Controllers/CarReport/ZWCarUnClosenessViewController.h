//
//  ZWCarUnClosenessViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBaseViewController.h"

typedef NS_ENUM(NSInteger, ZWCarUnClosenessViewControllerType) {
    ZWCarUnClosenessViewControllerMost,//未密闭时长最高车辆
    ZWCarUnClosenessViewControllerLess,//未密闭时长最低车辆
};

@interface ZWCarUnClosenessViewController : rBaseViewController

@property (nonatomic) ZWCarUnClosenessViewControllerType controllerType;

@end
