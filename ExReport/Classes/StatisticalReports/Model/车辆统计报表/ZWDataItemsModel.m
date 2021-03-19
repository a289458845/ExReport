//
//  ZWDataItemsModel.m
//  Muck
//
//  Created by 张威 on 2018/8/31.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWDataItemsModel.h"


@implementation ZWDataItemsModel

MJCodingImplementation
+ (NSDictionary *)mj_objectClassInArray
{
    return @{
             @"VehicleImgs" : @"ZWVehicleImgsModel"
             };
}

@end
