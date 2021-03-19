//
//  ZWAreaUnearchedHeaderView.h
//  Muck
//
//  Created by 张威 on 2018/8/2.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWAlarmStatues.h"

typedef enum : NSUInteger {
    ZWAreaUnearthedController,    ///区域出土量
    ZWAreaAbsorptiveController,   ///区域消纳量
} ZWAreaControllerType;


@interface ZWAreaUnearchedHeaderView : UIView
@property (copy, nonatomic)NSString *timeString;

@property (copy, nonatomic)NSString *beginTime;
@property (copy, nonatomic)NSString *endTime;

@property (nonatomic, strong) ZWAlarmStatues *statues;
@property (copy, nonatomic)void(^didSelectTimeBlock)(void);

/** 类型 */
@property(assign, nonatomic)ZWAreaControllerType controllerType;
/** 时间类型 */
@property(assign, nonatomic)NSInteger timeType;



@end
