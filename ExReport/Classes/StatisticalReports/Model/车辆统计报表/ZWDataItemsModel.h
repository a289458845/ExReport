//
//  ZWDataItemsModel.h
//  Muck
//
//  Created by 张威 on 2018/8/31.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZWVehicleImgsModel;
@interface ZWDataItemsModel : NSObject
/**安装时间*/
@property (copy, nonatomic)NSString *InstallTime;
/**车牌号*/
@property (copy, nonatomic)NSString *VehicleNo;
/**图片数组*/
@property (strong, nonatomic)NSArray *VehicleImgs;
@end
