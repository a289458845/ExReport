//
//  ZWCarOverspeedViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBaseViewController.h"

typedef NS_ENUM(NSInteger, ZWCarOverspeedViewControllerType) {
    ZWCarOverspeedViewControllerMost,//超速时长最高
    ZWCarOverspeedViewControllerLess,//超速时长最低
};

@interface ZWCarOverspeedViewController : rBaseViewController

@property (nonatomic) ZWCarOverspeedViewControllerType controllerType;

@end
