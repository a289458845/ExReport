//
//  ExService.h
//  ExReport
//
//  Created by exsun on 2021/2/4.
//

#import <Foundation/Foundation.h>
//#import <ExReport/ZWStatisticalReportsViewController.h>
#import "ZWStatisticalReportsViewController.h"
NS_ASSUME_NONNULL_BEGIN

@interface ExService : NSObject
+(ExService *)manager;
@property(nonatomic,copy)NSString * baseUrl;
@property(nonatomic,copy)NSString * token;
@property(nonatomic,copy)NSString * userAccount;

/**
    获取地理信息数据 (必须获取， 如果其他sdk获取了可以忽略)
 本地存储路径   [kDocumentPath stringByAppendingPathComponent:@"region.data"]
 */
-(void)getReginData;

-(ZWStatisticalReportsViewController *)goToBaseVC;
@end

NS_ASSUME_NONNULL_END
