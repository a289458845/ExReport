//
//  ZWCarStatisticalReportsTableViewCell.h
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWCarOnlineModel;
@interface ZWCarStatisticalReportsTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger rank;

@property (strong, nonatomic)ZWCarOnlineModel *model;

@end
