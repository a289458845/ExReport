//
//  ZWAreaViolationRankModel.h
//  Muck
//
//  Created by 张威 on 2018/8/15.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ZWAreaViolationRankModel : NSObject
/** 企业名称*/
@property (copy, nonatomic)NSString *EnterpriseName;
/** 企业Id*/
@property (copy, nonatomic)NSString *Id;
/** 未密闭率*/
@property (copy, nonatomic)NSString *Rate;
/** 区域名称*/
@property (copy, nonatomic)NSString *RegionName;
/**工地名称*/
@property (copy, nonatomic)NSString *SiteName;
/** 总里程*/
@property (copy, nonatomic)NSString *TotalMileage;
/** 总时长*/
@property (copy, nonatomic)NSString *TotalMins;
/**总车辆数*/
@property (copy, nonatomic)NSString *TotalVeh;

@end
