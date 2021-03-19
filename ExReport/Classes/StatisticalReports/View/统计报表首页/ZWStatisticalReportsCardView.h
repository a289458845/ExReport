//
//  ZWStatisticalReportsCardView.h
//  Muck
//
//  Created by 张威 on 2018/7/24.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWStatisticalReportsCardView,ZWCompanyOnlineRateModel;

@protocol ZWStatisticalReportsCardViewDelegate <NSObject>

@required
- (void)ZWStatisticalReportsCardViewDidClick:(ZWStatisticalReportsCardView *)view;

@end

@interface ZWStatisticalReportsCardView : UIView

@property (weak, nonatomic) id<ZWStatisticalReportsCardViewDelegate> delegate;

@property (strong, nonatomic)ZWCompanyOnlineRateModel *model;
@end
