//
//  ZWCompanyBasicInfoModel.h
//  Muck
//
//  Created by 张威 on 2018/8/23.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWCompanyBasicInfoModel : NSObject

@property (copy, nonatomic)NSString *EnterpriseAddress;
@property (copy, nonatomic)NSString *EnterpriseId;
@property (copy, nonatomic)NSString *EnterpriseName;
@property (copy, nonatomic)NSString *NoOnLineRank;
@property (copy, nonatomic)NSString *OVeralRank;
@property (copy, nonatomic)NSString *OnLineCube;
@property (copy, nonatomic)NSString *OverallRatings;
@property (copy, nonatomic)NSString *SpeedRank;
@property (copy, nonatomic)NSString *UnsealedRank;
@property (strong, nonatomic)NSArray *EnterpriseDayOnLine;
@property (strong, nonatomic)NSArray *EnterpriseDayRatings;

@end
