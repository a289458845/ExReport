//
//  ZWCompanyViolationUnClosenessViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBaseViewController.h"



typedef enum : NSUInteger {
    ZWCompanyViolationUnClosenessViewControllerUnClosenessRateMost,//未密闭率最高企业
    ZWCompanyBaseDataRankViewControllerUnClosenessRateLess,//未密闭率最低企业
} ZWCompanyViolationUnClosenessViewControllerType;

@interface ZWCompanyViolationUnClosenessViewController : rBaseViewController

@property (nonatomic) ZWCompanyViolationUnClosenessViewControllerType controllerType;
@end


