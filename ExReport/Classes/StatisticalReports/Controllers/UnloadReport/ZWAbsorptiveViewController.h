//
//  ZWAbsorptiveViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBaseViewController.h"

typedef NS_ENUM(NSInteger, ZWAbsorptiveViewControllerType) {
    ZWAbsorptiveViewControllerMost,//消纳量最多消纳点
    ZWAbsorptiveViewControllerless,//消纳量最少消纳点
};

@interface ZWAbsorptiveViewController : rBaseViewController

@property (nonatomic) ZWAbsorptiveViewControllerType controllerType;

@end
