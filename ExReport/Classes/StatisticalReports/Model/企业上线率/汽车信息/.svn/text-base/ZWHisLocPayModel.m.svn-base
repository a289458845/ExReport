//
//  ZWHisLocPayModel.m
//  Muck
//
//  Created by 张威 on 2018/8/28.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWHisLocPayModel.h"

@implementation ZWHisLocPayModel

- (void)setGpsDateTime:(NSString *)GpsDateTime
{
    _GpsDateTime = GpsDateTime;
    if (_GpsDateTime.length>19) {
        _GpsDateTime = [_GpsDateTime substringToIndex:19];
        _GpsDateHourTime =  [_GpsDateTime substringWithRange:NSMakeRange(11,8)];
    }
    _GpsDateTime =  [_GpsDateTime stringByReplacingOccurrencesOfString:@"T" withString:@" "];
}
    
@end
