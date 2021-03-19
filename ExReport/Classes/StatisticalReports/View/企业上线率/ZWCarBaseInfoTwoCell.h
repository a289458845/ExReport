//
//  ZWCarBaseInfoTwoCell.h
//  Muck
//
//  Created by 张威 on 2018/10/30.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ZWVehicleLastUnerModel;
@interface ZWCarBaseInfoTwoCell : UITableViewCell
@property (nonatomic,strong)NSIndexPath *indexPath;
@property (nonatomic,assign)BOOL isExtend;
@property (nonatomic,copy)void(^clickExtend)(NSIndexPath *indexPath,BOOL extend);

@property (strong, nonatomic)ZWVehicleLastUnerModel *model;
@end
