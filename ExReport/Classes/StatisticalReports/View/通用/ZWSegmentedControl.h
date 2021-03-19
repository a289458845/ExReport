//
//  ZWSegmentedControl.h
//  Muck
//
//  Created by 张威 on 2018/8/2.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ZWSegmentedControl : UIView
@property(nonatomic,strong)void(^didTitleLabBlock)(NSInteger titleTag);//点击标题
@end
