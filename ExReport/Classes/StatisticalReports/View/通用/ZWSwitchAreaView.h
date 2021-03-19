//
//  ZWSwitchAreaView.h
//  Muck
//
//  Created by 张威 on 2018/8/5.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@class ZWSwitchAreaView;

@protocol ZWSwitchAreaViewDelegate <NSObject>

- (void)switchAreaView:(ZWSwitchAreaView *)switchAreaView didClickLastWithCurrentIndex:(NSInteger)index currentTitle:(NSString *)title;
- (void)switchAreaView:(ZWSwitchAreaView *)switchAreaView didClickNextWithCurrentIndex:(NSInteger)index currentTitle:(NSString *)title;

@end

@interface ZWSwitchAreaView : UIView

@property (nonatomic, strong) NSArray *dataSource;

@property (weak, nonatomic) id<ZWSwitchAreaViewDelegate> delegate;

@property (nonatomic, assign) NSInteger selectedIndex;

@end
