//
//  ZWSuspiciousListController.h
//  Muck
//
//  Created by 张威 on 2018/8/8.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWStatisticalTableHeaderView.h"
#import "ZWDateTypeModel.h"

@interface ZWSuspiciousListController : UIViewController

/*
 key:type   1=昨日 2=今日 3=本周 4=本月 5=时间段 6=上周
 key:beginDate
 key:endDate
 */
@property (nonatomic, strong) ZWDateTypeModel *dateType;

@property (nonatomic, assign) NSInteger index;
@property (copy, nonatomic)NSString *DepartmentId;
@property (copy, nonatomic)NSString *DepartmentName;
@property (copy, nonatomic)NSString *Code;

@property (nonatomic) rSuspiciousViewControllerType controllerType;

- (void)updateType;
- (void)selectTimeViewShow;


@end
