//
//  ZWCarOverloadViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBaseViewController.h"

typedef NS_ENUM(NSInteger, ZWCarOverloadViewControllerType) {
    ZWCarOverloadViewControllerMost,//超载时长最高
    ZWCarOverloadViewControllerLess,//超载时长最低
};

@interface ZWCarOverloadViewController : rBaseViewController

@property (nonatomic) ZWCarOverloadViewControllerType controllerType;

@end
