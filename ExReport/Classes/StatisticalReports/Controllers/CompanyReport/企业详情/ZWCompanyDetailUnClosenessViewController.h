//
//  ZWCompanyDetailUnClosenessViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/23.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBaseViewController.h"
@protocol JScrollViewDelegate<NSObject>
@optional
- (void)johnScrollViewDidScroll:(CGFloat)scrollY;

@end
@interface ZWCompanyDetailUnClosenessViewController : rBaseViewController

@property (nonatomic,copy) void(^DidScrollBlock)(CGFloat scrollY);

@property (strong, nonatomic)UITableView *tableView;
@property (nonatomic,weak) id<JScrollViewDelegate>delegate;
@end
