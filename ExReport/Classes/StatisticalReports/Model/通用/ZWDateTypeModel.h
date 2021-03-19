//
//  ZWDateTypeModel.h
//  Muck
//
//  Created by 张威 on 2018/9/5.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef NS_ENUM(NSInteger, ZWDateType) {
    ZWDateTypeWeek,
    ZWDateTypeDay,
};

@interface ZWDateTypeModel : NSObject

@property (nonatomic, strong) NSNumber *type;
@property (nonatomic, copy) NSString *beginDate;
@property (nonatomic, copy) NSString *endDate;


@property(assign, nonatomic)ZWDateType dateType;
- (instancetype)initWithBeginDate:(NSString *)beginDate endDate:(NSString *)endDate;

@end
