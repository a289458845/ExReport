//
//  NSCalendar+Components.m
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/12/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import "NSCalendar+Components.h"

@implementation NSCalendar (Components)

- (NSInteger)weekOfMonthInDate:(NSDate*)date
{
    NSDateComponents *comps = [self components: NSCalendarUnitWeekOfMonth fromDate:date];
    return [comps weekOfMonth];
}


- (NSInteger)weekOfYearInDate:(NSDate*)date
{
    NSDateComponents *comps = [self components: NSCalendarUnitWeekOfYear fromDate:date];
    return [comps weekOfYear];
}

- (NSInteger)weekdayInDate:(NSDate*)date
{
    NSDateComponents *comps = [self components: NSCalendarUnitWeekday fromDate:date];
    return [comps weekday];
}


- (NSInteger)secondsInDate:(NSDate*)date
{
    NSDateComponents *comps = [self components: NSCalendarUnitSecond fromDate:date];
    return [comps second];
}

- (NSInteger)minutesInDate:(NSDate*)date
{
    NSDateComponents *comps = [self components:NSCalendarUnitMinute fromDate:date];
    return [comps minute];
}

- (NSInteger)hoursInDate:(NSDate*)date
{
    NSDateComponents *comps = [self components:NSCalendarUnitHour fromDate:date];
    return [comps hour];
}

- (NSInteger)daysInDate:(NSDate*)date
{
    NSDateComponents *comps = [self components:NSCalendarUnitDay fromDate:date];
    return [comps day];
}

- (NSInteger)monthsInDate:(NSDate*)date
{
    NSDateComponents *comps = [self components:NSCalendarUnitMonth fromDate:date];
    return [comps month];
}

- (NSInteger)yearsInDate:(NSDate*)date
{
    NSDateComponents *comps = [self components:NSCalendarUnitYear fromDate:date];
    return [comps year];
}

- (NSInteger)eraInDate:(NSDate*)date
{
    NSDateComponents *comps = [self components:NSCalendarUnitEra fromDate:date];
    return [comps era];
}

///

- (NSInteger)minutesOfQuarterInDate:(NSDate *)date
{
    NSDateFormatter *dateFormatterH = [[NSDateFormatter alloc] init];
    NSDateFormatter *dateFormatterM = [[NSDateFormatter alloc] init];

    [dateFormatterH setDateFormat: @"HH"];
    [dateFormatterM setDateFormat: @"mm"];
    
    NSString *hour = [dateFormatterH stringFromDate:date];
    NSString *minute = [dateFormatterM stringFromDate:date];
    
    if ([minute intValue]%15 != 0) {
        return false;
    }
    
    return [hour intValue]*4 + (int)[minute intValue]/15;
}

- (NSInteger)daysOfQuarterInDate:(NSDate *)date
{
    NSDateFormatter *dateFormatterD = [[NSDateFormatter alloc] init];
    [dateFormatterD setDateFormat:@"dd"];
    
    NSString *day = [dateFormatterD stringFromDate:date];
    return [day intValue]-1;
}

@end
