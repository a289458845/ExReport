//
//  ZWStatisticalReportsItemsListView.h
//  Muck
//
//  Created by 张威 on 2018/7/25.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWStatisticalReportsItemsListView;

@protocol ZWStatisticalReportsItemsListViewDelegate <NSObject>

- (void)ZWStatisticalReportsItemsListView:(ZWStatisticalReportsItemsListView *)view didSelectIndex:(NSInteger)index;



@end

@interface ZWStatisticalReportsItemsListView : UIView

@property (weak, nonatomic) id<ZWStatisticalReportsItemsListViewDelegate> delegate;

@property (nonatomic, assign) NSInteger selectIndex;
@property (nonatomic, strong) NSArray *Menus;

@end
