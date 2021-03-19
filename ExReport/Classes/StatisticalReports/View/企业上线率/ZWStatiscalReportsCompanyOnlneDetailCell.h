//
//  ZWStatiscalReportsCompanyOnlneDetailCell.h
//  Muck
//
//  Created by 张威 on 2018/7/29.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWAreaViolationRankModel,ZWCompanyOnlineRateModel;

typedef NS_ENUM(NSInteger, ZWStatiscalReportsDetailCellType) {
    ZWStatiscalReportsDetailCellCompanyOnline,//企业上线率
    ZWStatiscalReportsDetailCellAreaViolationRate,//区域违规率排名
};

@interface ZWStatiscalReportsCompanyOnlneDetailCell : UITableViewCell

@property (nonatomic) ZWStatiscalReportsDetailCellType type;

@property (nonatomic, strong) ZWAreaViolationRankModel *model;
@property (nonatomic, strong) ZWCompanyOnlineRateModel *rateModel;

@end
