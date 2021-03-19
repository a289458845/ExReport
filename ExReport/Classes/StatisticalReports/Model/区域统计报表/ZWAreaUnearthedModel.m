//
//  ZWAreaUnearthedModel.m
//  Muck
//
//  Created by 张威 on 2018/8/14.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWAreaUnearthedModel.h"
#import "ZWUnearthedDetailRankModel.h"
#import "ZWUnearthedDetailModel.h"
@implementation ZWAreaUnearthedModel

- (NSDictionary *)objectClassInArray{
    return @{ @"UnearthedDetailModel":[ZWUnearthedDetailModel class],@"UnearthedDetailRankModel":[ZWUnearthedDetailRankModel class]};
}
@end
