//
//  NSDate+String.m
//  Muck
//
//  Created by 张威 on 2018/8/20.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "NSDate+String.h"
#import "NSCalendar+Juncture.h"
#import "NSCalendar+DateManipulation.h"


@implementation NSDate (String)

- (NSString *)stringWithFormatter:(NSString *)dateFormatter
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:dateFormatter];
    return [formatter stringFromDate:self];
}


//获取本周开始时间
+ (NSString *)thisWeekBeginDate
{
    NSDate *date = [[NSCalendar currentCalendar] firstDayOfTheWeek];
    return [date stringWithFormatter:@"yyyy-MM-dd"];
}
//获取本周结束时间
+ (NSString *)thisWeekEndDate
{
   return [[[NSCalendar currentCalendar] dateByAddingDays:0 toDate:[NSDate date]] stringWithFormatter:@"yyyy-MM-dd"];
}


//获取上周开始时间
+ (NSString *)lastWeekBeginDate
{
    NSDate *date = [[NSCalendar currentCalendar] firstDayOfTheWeekUsingReferenceDate:[[NSCalendar currentCalendar] dateBySubtractingWeeks:-1 fromDate:[NSDate date]]];
    return [date stringWithFormatter:@"yyyy-MM-dd"];
}
//获取上周结束时间
+ (NSString *)lastWeekEndDate
{
   return [[[NSCalendar currentCalendar] lastDayOfTheWeekUsingReferenceDate:[[NSCalendar currentCalendar] dateBySubtractingWeeks:-1 fromDate:[NSDate date]]] stringWithFormatter:@"yyyy-MM-dd"];
}

@end
