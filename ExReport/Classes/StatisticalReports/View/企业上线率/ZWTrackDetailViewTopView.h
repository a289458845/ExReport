//
//  ZWTrackDetailViewTopView.h
//  Muck
//
//  Created by 邵明明 on 2018/8/30.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWHisLocPayModel;
@interface ZWTrackDetailViewTopView : UIView

/**车牌号*/
@property (copy, nonatomic)NSString *vehicleNo;
@property (nonatomic,strong)ZWHisLocPayModel *model;

- (void)show;
- (void)disMiss;

@end
