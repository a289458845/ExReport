//
//  ZWCompanyViolationOverspeedViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBaseViewController.h"

typedef NS_ENUM(NSInteger, ZWCompanyViolationOverspeedViewControllerType) {
    ZWCompanyViolationOverspeedViewControllerMost,
    ZWCompanyViolationOverspeedViewControllerless,
};

@interface ZWCompanyViolationOverspeedViewController : rBaseViewController


@property (nonatomic) ZWCompanyViolationOverspeedViewControllerType controllerType;

@end
