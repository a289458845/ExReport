//
//  ZWCompanyBaseDataRankViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBaseViewController.h"

typedef NS_ENUM(NSInteger, ZWCompanyBaseDataRankViewControllerType) {
    ZWCompanyBaseDataRankViewControllerUnearthedMost,//出土量最多企业
    ZWCompanyBaseDataRankViewControllerUnearthedLess,//出土量最少企业
};

@interface ZWCompanyBaseDataRankViewController : rBaseViewController

@property (nonatomic) ZWCompanyBaseDataRankViewControllerType controllerType;

@end
