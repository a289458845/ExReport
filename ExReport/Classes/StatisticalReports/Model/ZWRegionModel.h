//
//  ZWRegionModel.h
//  Muck
//
//  Created by 张威 on 2018/8/6.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface ZWRegionModel : NSObject <NSCoding>
@property (copy, nonatomic)NSString *Code;
@property (copy, nonatomic)NSString *Id;
@property (copy, nonatomic)NSString *Name;
@property (assign,nonatomic) BOOL selected;
@end
