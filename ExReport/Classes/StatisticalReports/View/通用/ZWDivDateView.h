//
//  ZWDivDateView.h
//  Muck
//
//  Created by 张威 on 2018/8/5.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol ZWDivDateViewDelegate<NSObject>

- (void)ZWDivDateViewDelegateClickType:(NSInteger)index;

@end

typedef NS_ENUM(NSInteger, ZWDivDateType) {
    ZWDivDateTypeWeek,
    ZWDivDateTypeDay,
};
@interface ZWDivDateView : UIView
@property(nonatomic,strong)UIView *baseView;


@property (nonatomic) ZWDivDateType type;


@property (weak, nonatomic) id <ZWDivDateViewDelegate>delegate;
@end
