//
//  ZWStatisticalReportsCommonView.h
//  Muck
//
//  Created by 张威 on 2018/7/25.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWStatisticalReportsCommonView;
@protocol ZWStatisticalReportsCommonViewDelegate<NSObject>
@required
- (void)tatisticalReportsCommonViewDidSelected:(ZWStatisticalReportsCommonView *)view WithUrl:(NSInteger )url;
@end
@interface ZWStatisticalReportsCommonView : UIView

@property (weak, nonatomic)id<ZWStatisticalReportsCommonViewDelegate>delegate;

@end
