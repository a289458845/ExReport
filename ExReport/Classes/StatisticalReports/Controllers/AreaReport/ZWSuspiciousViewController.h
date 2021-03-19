//
//  ZWSuspiciousViewController.h
//  Muck
//
//  Created by 张威 on 2018/8/5.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "rBasePageViewController.h"


@protocol ZWSuspiciousViewControllerDelegate<NSObject>
- (void)ZWSuspiciousViewControllerDelegateRefreshDataWithType:(NSInteger)type;
@end

@interface ZWSuspiciousViewController : rBasePageViewController

@property (nonatomic) rSuspiciousViewControllerType controllerType;



@end
