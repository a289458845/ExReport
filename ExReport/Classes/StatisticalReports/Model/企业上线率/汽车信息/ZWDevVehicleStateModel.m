//
//  ZWDevVehicleStateModel.m
//  Muck
//
//  Created by 张威 on 2018/8/26.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWDevVehicleStateModel.h"
#import "ZWVehicleIconStatusModel.h"
@implementation ZWDevVehicleStateModel

- (NSDictionary *)objectClassInArray{
    return @{ @"ssStatus":[ZWVehicleIconStatusModel class]};
}

@end
