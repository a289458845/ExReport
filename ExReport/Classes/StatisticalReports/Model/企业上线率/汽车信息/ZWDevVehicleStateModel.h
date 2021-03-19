//
//  ZWDevVehicleStateModel.h
//  Muck
//
//  Created by 张威 on 2018/8/26.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZWVehicleIconStatusModel;
@interface ZWDevVehicleStateModel : NSObject
@property (copy, nonatomic)NSString *ConectStatus;
@property (copy, nonatomic)NSString *DWStatus;
@property (copy, nonatomic)NSString *DeviceNo;
@property (copy, nonatomic)NSString *DeviceStatusStr;
@property (copy, nonatomic)NSString *LastDWTime;
@property (copy, nonatomic)NSString *Lat;
@property (copy, nonatomic)NSString *Lon;
@property (copy, nonatomic)NSString *Mileage;
@property (copy, nonatomic)NSString *SerAddress;
@property (copy, nonatomic)NSString *Speed;
@property (copy, nonatomic)NSString *VehicleStatusFlag;
@property (strong, nonatomic)NSArray <ZWVehicleIconStatusModel *>*ssStatus;

@end
