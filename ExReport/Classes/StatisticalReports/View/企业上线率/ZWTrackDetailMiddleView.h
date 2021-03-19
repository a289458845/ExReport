//
//  ZWTrackDetailMiddleView.h
//  Muck
//
//  Created by 张威 on 2018/9/26.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWHisLocStatModel;
@interface ZWTrackDetailMiddleView : UIView
@property (nonatomic,strong)ZWHisLocStatModel *model;

- (void)show;
- (void)disMiss;
@end
