//
//  ZWCompanyViolationStatisticalDetailCell.h
//  Muck
//
//  Created by 张威 on 2018/8/11.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWAreaViolationRankModel;

typedef NS_ENUM(NSInteger, ZWCompanyViolationStatisticalDetailCellType) {
    ZWCompanyViolationStatisticalDetailCellUnCloseness,//未密闭率
    ZWCompanyViolationStatisticalDetailCellOverspeed,//超速率
};

@interface ZWCompanyViolationStatisticalDetailCell : UITableViewCell

- (instancetype)initWithType:(ZWCompanyViolationStatisticalDetailCellType)type reuseIdentifier:(NSString *)reuseIdentifier;

@property (nonatomic) ZWCompanyViolationStatisticalDetailCellType type;

@property (strong, nonatomic)ZWAreaViolationRankModel *rankModel;

@end
