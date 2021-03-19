//
//  ZWBuildingUnearthedConditionFirstListController.h
//  Muck
//
//  Created by 张威 on 2018/8/13.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWDateTypeModel.h"
@interface ZWBuildingUnearthedConditionFirstListController : UIViewController

@property (nonatomic, assign) NSInteger index;
@property (copy, nonatomic)NSString *DepartmentId;
@property (copy, nonatomic)NSString *DepartmentName;


/*
 key:type   1=昨日 2=今日 3=本周 4=本月 5=时间段 6=上周
 key:beginDate
 key:endDate
 */
@property (nonatomic, strong)ZWDateTypeModel *dateType;
- (void)updateType;
- (void)selectTimeViewShow;
@end
