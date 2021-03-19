//
//  ZWDateTypeModel.m
//  Muck
//
//  Created by 张威 on 2018/9/5.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWDateTypeModel.h"
#import "NSDate+String.h"

@implementation ZWDateTypeModel
//时间类型 1=昨日 2=今日 3=本周 4=本月 5=时间段 6=上周
- (instancetype)init{
    if (self = [super init]) {
    }
    return self;
}



- (void)setDateType:(ZWDateType)dateType{
    _dateType = dateType;
    if (self.dateType == ZWDateTypeWeek) {
        self.type = @3;
    }else{
        self.type = @2;
    }
    
}

- (instancetype)initWithBeginDate:(NSString *)beginDate endDate:(NSString *)endDate{
    self = [super init];
    if (self) {
        self.beginDate = beginDate;
        self.endDate = endDate;
    }
    return self;
}





@end
