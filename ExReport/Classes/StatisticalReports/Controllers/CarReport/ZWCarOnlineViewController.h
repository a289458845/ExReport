//
//  ZWCarOnlineViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBaseViewController.h"

typedef NS_ENUM(NSInteger, ZWCarOnlineViewControllerType) {
    ZWCarOnlineViewControllerHightest,//上线时长最高
    ZWCarOnlineViewControllerLowest,//上线时长最低
};

@interface ZWCarOnlineViewController : rBaseViewController

@property (nonatomic) ZWCarOnlineViewControllerType controllerType;

@end
