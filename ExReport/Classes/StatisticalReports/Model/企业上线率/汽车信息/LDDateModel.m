//
//  LDDateModel.m
//  LogisticsDriver
//
//  Created by WTM on 2018/1/17.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "LDDateModel.h"

@implementation LDDateModel

+ (NSArray *)getYearArrayWithCurrentDate:(NSDate *)currentDate
{
    NSMutableArray *yearArrM = [NSMutableArray array];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy"];
    //当前年份往前118年
    NSInteger year = [[formatter stringFromDate:currentDate] integerValue];
    for (NSInteger i = year - 118; i <= year; i++) {
       NSString *yearString = [NSString stringWithFormat:@"%zd",i];
        [yearArrM addObject:yearString];
    }
    
    return yearArrM.copy;
}

+ (NSArray *)getMonthArrayWithCurrentDate:(NSDate *)currentDate
{
    NSMutableArray *monthArrM = [NSMutableArray array];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM"];
    NSInteger month = [[formatter stringFromDate:currentDate] integerValue];
    for (NSInteger i = 1; i <= month; i++) {
        NSString *monthString = [NSString stringWithFormat:@"%zd",i];
        [monthArrM addObject:monthString];
    }
    return monthArrM.copy;
}

+ (NSArray *)getDayArrayWithCurrentDate:(NSDate *)currentDate
{
    NSMutableArray *dayArrM = [NSMutableArray array];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"dd"];
    NSInteger day = [[formatter stringFromDate:currentDate] integerValue];
    for (NSInteger i = 1; i <= day; i++) {
        NSString *dayString = [NSString stringWithFormat:@"%zd",i];
        [dayArrM addObject:dayString];
    }
    return dayArrM.copy;
}


+ (NSArray *)getCurrentMonthWithCurrentYear:(NSString *)currentYear CurrentDate:(NSDate *)currentDate
{
    NSMutableArray *monthArrM = [NSMutableArray array];
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"MM"];
    NSInteger year = [[yearFormatter stringFromDate:currentDate] integerValue];
    NSInteger month = [[monthFormatter stringFromDate:currentDate] integerValue];
    if ([currentYear integerValue] == year) {
        for (NSInteger i = 1; i <= month; i++) {
          NSString *monthStr = [NSString stringWithFormat:@"%zd",i];
            [monthArrM addObject:monthStr];
        }
    }else{
        for (NSInteger i = 1; i <=12; i++) {
            NSString *monthStr = [NSString stringWithFormat:@"%zd",i];
            [monthArrM addObject:monthStr];
        }
    }
    return monthArrM.copy;
}

+ (NSArray *)getCurrentDayWithCurrentYear:(NSString *)currentYear CurrentMonth:(NSString *)currentMonth CurrentDate:(NSDate *)currentDate
{
    NSMutableArray *dayArrM = [NSMutableArray array];
    NSDateFormatter *yearFormatter = [[NSDateFormatter alloc] init];
    [yearFormatter setDateFormat:@"yyyy"];
    NSDateFormatter *monthFormatter = [[NSDateFormatter alloc] init];
    [monthFormatter setDateFormat:@"MM"];
    NSDateFormatter *dayFormatter = [[NSDateFormatter alloc] init];
    [dayFormatter setDateFormat:@"dd"];
    NSInteger year = [[yearFormatter stringFromDate:currentDate] integerValue];
    NSInteger month = [[monthFormatter stringFromDate:currentDate] integerValue];
    NSInteger day = [[dayFormatter stringFromDate:currentDate] integerValue];
    
    NSInteger  yearNow = [currentYear integerValue];
    NSInteger  monthNow = [currentMonth integerValue];
    //当前年,月
    if (year == yearNow && month == monthNow) {
        for (NSInteger i = 1; i <= day; i++) {
            NSString *dayStr = [NSString stringWithFormat:@"%zd",i];
            [dayArrM addObject:dayStr];
        }
    }else{
        //31天
        if (monthNow == 1 || monthNow == 3 || monthNow == 5 || monthNow == 7 || monthNow == 8 || monthNow == 10 || monthNow == 12) {//31天
            for (NSInteger i = 1; i<= 31; i++) {
                NSString *dayStr = [NSString stringWithFormat:@"%zd",i];
                [dayArrM addObject:dayStr];
            }
        }else if (monthNow == 4 || monthNow == 6 || monthNow == 8 || monthNow == 11){//30天
            for (NSInteger i = 1; i<= 30; i++) {
                NSString *dayStr = [NSString stringWithFormat:@"%zd",i];
                [dayArrM addObject:dayStr];
            }
        }else{
            if ((yearNow % 4 == 0 && yearNow / 100!= 0) || yearNow % 400 == 0 ) {//闰年
                //29天
                for (NSInteger i = 1; i<= 29; i++) {
                    NSString *dayStr = [NSString stringWithFormat:@"%zd",i];
                    [dayArrM addObject:dayStr];
                }
            }else{//平年
                //28天
                for (NSInteger i = 1; i<= 28; i++) {
                    NSString *dayStr = [NSString stringWithFormat:@"%zd",i];
                    [dayArrM addObject:dayStr];
                }
            }
        }
    }
    return dayArrM.copy;
}
@end
