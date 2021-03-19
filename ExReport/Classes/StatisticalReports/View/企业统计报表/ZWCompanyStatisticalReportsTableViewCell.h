//
//  ZWCompanyStatisticalReportsTableViewCell.h
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWCompanyStatisticalReportsTableViewCell,
ZWCompanyBaseDataRankModel,
ZWAreaViolationRankModel,
ZWCarUnClosenessModel,
ZWSingleMonitoringModel;

typedef NS_ENUM(NSInteger, ZWCompanyStatisticalReportsTableViewCellType) {
    ZWCompanyStatisticalReportsTableViewCellUnearthed,//出土量
    ZWCompanyStatisticalReportsTableViewCellUnCloseness,//未密闭率
    ZWCompanyStatisticalReportsTableViewCellOverspeed,//超速
};







@protocol ZWCompanyStatisticalReportsTableViewCellDelegate <NSObject>

- (void)companyStatisticalReportsTableViewCellDidSelectCompany:(ZWCompanyStatisticalReportsTableViewCell *)cell;

@end

@interface ZWCompanyStatisticalReportsTableViewCell : UITableViewCell

@property (nonatomic, assign) NSInteger rank;

- (instancetype)initWithType:(ZWCompanyStatisticalReportsTableViewCellType)type reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic) ZWCompanyStatisticalReportsTableViewCellType type;





@property (weak, nonatomic) id<ZWCompanyStatisticalReportsTableViewCellDelegate> delegate;
@property (strong, nonatomic)ZWCompanyBaseDataRankModel *model;
@property (strong, nonatomic)ZWAreaViolationRankModel *rankModel;
@property (strong, nonatomic)ZWAreaViolationRankModel *unearthedModel;
@property (strong, nonatomic)ZWCarUnClosenessModel *closenessModel;
@property (strong, nonatomic)ZWSingleMonitoringModel *singleMonitoringModel;
@end
