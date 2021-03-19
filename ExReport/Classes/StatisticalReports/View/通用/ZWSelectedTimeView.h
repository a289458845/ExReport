//
//  ZWSelectedTimeView.h
//  Muck
//
//  Created by 张威 on 2018/8/9.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWSelectedTimeView : UIView
@property (nonatomic,strong)NSDate *currentDate;
@property (copy, nonatomic)NSString *startTime;
@property (copy, nonatomic)NSString *endTime;

@property(nonatomic,strong)UITableView *tableView;
@property (nonatomic,copy)void(^confirmAction)(void);
@property (nonatomic,copy)void(^cancelAction)(void);
@property (nonatomic,copy)void(^didSelectAction)(NSInteger index);
@property (nonatomic,copy)NSString *tipString;
- (void)show;
- (void)dismiss;
@end
