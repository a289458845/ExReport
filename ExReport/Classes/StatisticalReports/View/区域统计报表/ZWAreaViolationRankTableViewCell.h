//
//  ZWAreaViolationRankTableViewCell.h
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWAreaViolationRankModel;

@interface ZWAreaViolationRankTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger rank;

@property (nonatomic, strong) ZWAreaViolationRankModel *model;

@end
