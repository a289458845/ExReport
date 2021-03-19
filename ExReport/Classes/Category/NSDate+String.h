//
//  NSDate+String.h
//  Muck
//
//  Created by 张威 on 2018/8/20.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (String)

- (NSString *)stringWithFormatter:(NSString *)dateFormatter;

//获取本周开始时间
+ (NSString *)thisWeekBeginDate;
//获取本周结束时间
+ (NSString *)thisWeekEndDate;


//获取上周开始时间
+ (NSString *)lastWeekBeginDate;
//获取上周结束时间
+ (NSString *)lastWeekEndDate;

@end
