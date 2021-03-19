//
//  ZWBuildingUnearthedViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBaseViewController.h"
#import "ZWCompanyStatisticalReportsTableViewCell.h"

typedef NS_ENUM(NSInteger, ZWBuildingUnearthedViewControllerType) {
    ZWBuildingUnearthedViewControllerMost,//工地出土量最多
    ZWBuildingUnearthedViewControllerLess,//工地出土量最少
};

@interface ZWBuildingUnearthedViewController : rBaseViewController

@property (nonatomic, assign) ZWBuildingUnearthedViewControllerType controllerType;

@end
