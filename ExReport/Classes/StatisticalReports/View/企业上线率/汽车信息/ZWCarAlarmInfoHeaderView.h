//
//  ZWCarAlarmInfoHeaderView.h
//  Muck
//
//  Created by 张威 on 2018/8/27.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ZWAlarmStatues.h"
@protocol ZWCarAlarmInfoHeaderViewDelegate<NSObject>

- (void)ZWCarAlarmInfoHeaderViewDelegateSelectedClick:(NSInteger)tag;
@end

@interface ZWCarAlarmInfoHeaderView : UIView

@property (nonatomic, strong) ZWAlarmStatues *statues;

@property (weak, nonatomic)id<ZWCarAlarmInfoHeaderViewDelegate>delegate;
@end
