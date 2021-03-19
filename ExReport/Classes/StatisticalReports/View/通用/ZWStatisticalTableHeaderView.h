//
//  ZWStatisticalTableHeaderView.h
//  Muck
//
//  Created by 张威 on 2018/8/7.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

//typedef NS_ENUM(NSInteger, rSuspiciousViewControllerType) {
//    rSuspiciousViewControllerWorkSite,//可疑工地
//    rSuspiciousViewControllerTypeAbsorptive,//消纳点
//    rSuspiciousViewControllerTypeAheadUnearth, //提前出土工地
//    rSuspiciousViewControllerTypeBlackSite, //提前出土工地
//};


@interface ZWStatisticalTableHeaderView : UIView

@property (copy, nonatomic)NSString *numCount;
@property (copy, nonatomic)NSString *timeInterval;

@property (nonatomic) rSuspiciousViewControllerType controllerType;
@end
