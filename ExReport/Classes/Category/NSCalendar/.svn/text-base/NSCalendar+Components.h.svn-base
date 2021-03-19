//
//  NSCalendar+Components.h
//   MBCalendarKit
//
//  Created by Moshe Berman on 4/12/13.
//  Copyright (c) 2013 Moshe Berman. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSCalendar (Components)

- (NSInteger)weekdayInDate:(NSDate*)date;
- (NSInteger)secondsInDate:(NSDate*)date;
- (NSInteger)minutesInDate:(NSDate*)date;
- (NSInteger)hoursInDate:(NSDate*)date;
- (NSInteger)daysInDate:(NSDate*)date;
- (NSInteger)monthsInDate:(NSDate*)date;
- (NSInteger)yearsInDate:(NSDate*)date;
- (NSInteger)eraInDate:(NSDate*)date;

- (NSInteger)weekOfMonthInDate:(NSDate*)date;
- (NSInteger)weekOfYearInDate:(NSDate*)date;


/// 自定义 24小时内（0，15，30，45）间隔15分钟的位置，最大值4*24 - 1
- (NSInteger)minutesOfQuarterInDate:(NSDate *)date;
///一个月内，每天在这个月内的位置
- (NSInteger)daysOfQuarterInDate:(NSDate *)date;
@end
