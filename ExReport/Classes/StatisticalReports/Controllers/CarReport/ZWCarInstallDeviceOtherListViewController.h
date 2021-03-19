//
//  ZWCarInstallDeviceOtherListViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/31.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBaseViewController.h"
#import "ZWDateTypeModel.h"
@interface ZWCarInstallDeviceOtherListViewController : rBaseViewController
@property (nonatomic, assign) NSInteger index;
@property (copy, nonatomic)NSString *DepartmentId;
@property (copy, nonatomic)NSString *DepartmentName;
@property(strong, nonatomic)ZWDateTypeModel *dateType;

- (void)updateType;
- (void)selectTimeViewShow;
@end
