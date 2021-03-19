//
//  ZWAreaUnearthedModel.h
//  Muck
//
//  Created by 张威 on 2018/8/14.
//  Copyright © 2018年 张威. All rights reserved.
//

#import <Foundation/Foundation.h>
@class ZWUnearthedDetailRankModel,ZWUnearthedDetailModel;
@interface ZWAreaUnearthedModel : NSObject

@property (copy, nonatomic)NSString *BeginDateValue;
@property (copy, nonatomic)NSString *EndDateValue;
@property (strong, nonatomic)NSArray <ZWUnearthedDetailModel *>*UnearthedDetailArray;
@property (strong, nonatomic)NSArray <ZWUnearthedDetailRankModel *>*UnearthedDetailRankArray;

@end
