//
//  ZWTrackDetailBottomView.h
//  Muck
//
//  Created by 邵明明 on 2018/8/30.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol ZWTrackDetailBottomViewDelegate <NSObject>
/**  开始*/
- (void)zWTrackDetailBottomViewDidClickStartButtonWithIndex:(NSInteger)index;
/**  暂停*/
- (void)zWTrackDetailBottomViewDidClickEndButtonWithIndex:(NSInteger)index;
/**  气泡*/
- (void)zWTrackDetailBottomViewDidClickPopButtonWithisShow:(BOOL)isShow;

- (void)zWTrackDetailBottomViewBeginSliding;
- (void)zWTrackDetailBottomViewDidSlidingToIndex:(NSInteger)index;
@end

@interface ZWTrackDetailBottomView : UIView
@property (nonatomic,weak)id <ZWTrackDetailBottomViewDelegate>delegate;
@property (nonatomic,copy)NSString *startTime;
@property (nonatomic,copy)NSString *endTime;
@property (nonatomic,assign)NSInteger count;
@property (nonatomic,assign)CGFloat progress;
@property (nonatomic,assign)BOOL playButtonSelected;


@end
