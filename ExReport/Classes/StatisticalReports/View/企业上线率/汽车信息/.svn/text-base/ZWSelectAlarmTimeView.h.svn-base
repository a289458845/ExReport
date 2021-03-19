//
//  ZWSelectAlarmTimeView.h
//  Muck
//
//  Created by 张威 on 2018/8/27.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWSelectAlarmTimeView : UIView
@property (copy, nonatomic)NSString *beginTime;
@property (copy, nonatomic)NSString *endTime;
@property (strong, nonatomic)UITableView *tableView;
@property (copy, nonatomic)void(^selectedTimeBlock)(NSInteger index);
@property (copy, nonatomic)void(^comfirmBlock)(void);
- (void)dismiss;
- (void)show;
@end
