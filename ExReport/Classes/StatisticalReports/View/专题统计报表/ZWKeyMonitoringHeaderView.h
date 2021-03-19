//
//  ZWKeyMonitoringHeaderView.h
//  Muck
//
//  Created by 张威 on 2018/8/22.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWKeyMonitoringHeaderView : UIView
@property (copy, nonatomic)NSString *timeString;
@property (copy, nonatomic)NSString *inOutNum;
@property (copy, nonatomic)void(^didSelectTimeBlock)(void);
@end
