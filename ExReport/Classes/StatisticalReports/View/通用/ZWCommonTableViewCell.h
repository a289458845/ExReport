//
//  ZWCommonTableViewCell.h
//  Muck
//
//  Created by 张威 on 2018/7/29.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWCommonTableViewCell,ZWUnearthedDetailRankModel,ZWCompanyOnlineRateModel;

@protocol ZWCommonTableViewCellDelegate <NSObject>
@required
- (void)ZWCommonTableViewCellSelectedCompany:(ZWCommonTableViewCell *)cell;

@end

@interface ZWCommonTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger rank;

@property (weak, nonatomic) id<ZWCommonTableViewCellDelegate> delegate;


@property (strong, nonatomic)ZWUnearthedDetailRankModel *model;

@property (strong, nonatomic)ZWCompanyOnlineRateModel *rateModel;

@end
