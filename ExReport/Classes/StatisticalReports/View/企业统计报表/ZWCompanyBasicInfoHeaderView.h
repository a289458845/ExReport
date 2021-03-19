//
//  ZWCompanyBasicInfoHeaderView.h
//  Muck
//
//  Created by 张威 on 2018/8/21.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWCompanyBasicInfoModel;
@interface ZWCompanyBasicInfoHeaderView : UIView
@property (strong, nonatomic)ZWCompanyBasicInfoModel *model;
@property (copy, nonatomic)NSString *EnterpriseName;
@end
