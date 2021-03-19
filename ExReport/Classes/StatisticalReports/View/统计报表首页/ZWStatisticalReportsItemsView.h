//
//  ZWStatisticalReportsItemsView.h
//  Muck
//
//  Created by 张威 on 2018/7/25.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWStatisticalReportsItemsView;

@protocol ZWStatisticalReportsItemsViewDelegate <NSObject>

@required

- (void)ZWStatisticalReportsItemsViewDidSelected:(ZWStatisticalReportsItemsView *)view didSelectIndex:(NSInteger)index;



@end

@interface ZWStatisticalReportsItemsView : UIView

@property (weak, nonatomic) id<ZWStatisticalReportsItemsViewDelegate> delegate;

@property (nonatomic, strong) NSArray *Menus;

@end
