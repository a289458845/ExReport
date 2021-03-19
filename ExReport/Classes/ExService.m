//
//  ExService.m
//  ExReport
//
//  Created by exsun on 2021/2/4.
//

#import "ExService.h"
#import <ExNetwork/ExNetwork.h>
#import "BaseController/rBaseViewController.h"
#import "ZWRegionModel.h"
static ExService * _service ;
@implementation ExService

+(ExService *)manager{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _service = [[ExService alloc]init];
    });
    return _service;
}

-(void)setBaseUrl:(NSString *)baseUrl
{
    _baseUrl = baseUrl;
    [ExNetwork initNetwork:baseUrl];
}

-(void)setToken:(NSString *)token
{
    _token = token;
    [ExNetwork sharedManager].token = token;
}

-(void)getReginData
{
    NSString *path = [kDocPath stringByAppendingPathComponent:@"region.data"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    if (!array) {
        [self loadRegionData];
    }
}
///Users/exsun/Desktop/组件/ExReport/ExReport/Assets/Resource.bundle
/** 获取区域信息 */
- (void)loadRegionData{
    NSDictionary *params = @{
        @"App_Key":@"ty_ztc"
    };
    
    [[ExNetwork sharedManager] PostUrlString:@"/api/AppReports/GetRegion" parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            
            NSArray *regionListArray  = responseObject[@"Data"];
            NSMutableArray *temp = [NSMutableArray array];
            for (NSDictionary *dict in regionListArray) {
                ZWRegionModel *model = [ZWRegionModel mj_objectWithKeyValues:dict];
                [temp addObject:model];
            }
            //归档
            NSString *path = [kDocumentPath stringByAppendingPathComponent:@"region.data"];
            [NSKeyedArchiver archiveRootObject:temp toFile:path];
        }
        NSLog(@"aaaaaaa");
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(ZWStatisticalReportsViewController *)goToBaseVC
{
    ZWStatisticalReportsViewController * vc = [ZWStatisticalReportsViewController new];
    return vc;
}

@end
