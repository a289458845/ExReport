//
//  ExNetwork.m
//  ex_sdk
//
//  Created by exsun on 2020/12/14.
//  Copyright © 2020 exsun. All rights reserved.
//

#import "ExNetwork.h"
#import <AFNetworking/AFNetworking.h>
//#import <ExCheckCar/ExProgressHUD.h>
@implementation ExNetwork
static ExNetwork * _instanceType = nil;

+(void)initNetwork:(NSString *)baseUrl
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instanceType = [ExNetwork manager];
        NSURL *url = [NSURL URLWithString:baseUrl];
        _instanceType = [_instanceType initWithBaseURL:url];
    });
    _instanceType.requestSerializer = [AFJSONRequestSerializer serializer];
    _instanceType.requestSerializer.HTTPShouldHandleCookies = YES;
    _instanceType.requestSerializer.timeoutInterval = 120.0f;
    _instanceType.responseSerializer = [AFJSONResponseSerializer serializer];
    _instanceType.responseSerializer.acceptableContentTypes = [NSSet setWithObjects:@"application/json", @"text/json", @"text/javascript",@"text/html",nil];
}

+ (instancetype)sharedManager{
    return _instanceType;
}


- (void)GetUrlString:(NSString *)urlStr
          parameters:(NSDictionary *)parameters
             success:(void (^)(id _Nullable))success
             failure:(void (^)(NSError * _Nonnull))failure{
//    [self monitoringNetWorkStatus];
    NSLog(@"\n【url: %@】\n【parameters:\n %@】",urlStr,parameters);
     [self.requestSerializer setValue:self.token forHTTPHeaderField:@"token"];
    
    NSString * url;
       if ([urlStr hasPrefix:@"http"] || [urlStr hasPrefix:@"https"]) {
           url = urlStr;
       }else
       {
           url = [NSString stringWithFormat:@"%@%@",self.baseURL,urlStr];
       }
    
    [self GET:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dict = [self processDictionaryIsNSNull:responseObject];
        NSLog(@"%@----%@",task.currentRequest,dict);
        if (success) {
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
//        NSHTTPURLResponse *response  = (NSHTTPURLResponse *)task.response;
        if (failure) {
            failure(error);
            NSLog(@"error----%@",error);
            if (error.code == -1001) {//请求超时
//                [ExProgressHUD showMessage:@"请求超时"];
                UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请求超时" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
                alert.delegate = self;
                [alert show];
            }
            
        }
    }];
}

- (void)PostUrlString:(NSString *)urlStr
           parameters:(NSDictionary *)parameters
              success:(void (^)(id _Nullable))success
              failure:(void (^)(NSError * _Nonnull))failure{
//    [self monitoringNetWorkStatus];
//     NSLog(@"\n【url: %@】\n【parameters:\n %@】   \n rememberCookie = %@",urlStr,[parameters dictionaryToJsonString],[kDefaults objectForKey:@"rememberCookie"]);
     [self.requestSerializer setValue:self.token forHTTPHeaderField:@"token"];
    NSString * url;
    if ([urlStr hasPrefix:@"http"] || [urlStr hasPrefix:@"https"]) {
        url = urlStr;
    }else
    {
        url = [NSString stringWithFormat:@"%@%@",self.baseURL,urlStr];
    }
    [self POST:url parameters:parameters success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dict = [self processDictionaryIsNSNull:responseObject];
//        NSLog(@"%@----%@",task.currentRequest,[dict dictionaryToJsonString]);
        if (success) {
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            NSLog(@"error----%@",error);
        }
    }];
}
- (void)PostUrlString:(NSString *)urlStr
AppendToUrlSuffix:(NSDictionary *)parameters
   success:(void (^)(id _Nullable))success
              failure:(void (^)(NSError * _Nonnull))failure{
//    [self monitoringNetWorkStatus];
//     NSLog(@"\n【url: %@】\n【parameters:\n %@】   \n rememberCookie = %@",urlStr,[parameters dictionaryToJsonString],[kDefaults objectForKey:@"rememberCookie"]);
     [self.requestSerializer setValue:self.token forHTTPHeaderField:@"token"];
    
    
      
      NSMutableArray * temp = [NSMutableArray new];
      //self.requestParameter为外部传进来的参数字典
      //1.遍历字典
        [parameters enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
      //2.将参数字典按照key=value的形式存放到数组中
            [temp addObject:[NSString stringWithFormat:@"%@=%@", key, obj]];
        }];
      NSString * suffixValue = [temp componentsJoinedByString:@"&"];
    NSString * url = [[NSString stringWithFormat:@"%@%@?%@",self.baseURL,urlStr,suffixValue]stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    
    [self POST:url parameters:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dict = [self processDictionaryIsNSNull:responseObject];
        NSLog(@"%@----%@",task.currentRequest,dict);
        if (success) {
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (failure) {
            failure(error);
            NSLog(@"error----%@",error);
//            if (error.code == -1001) {//请求超时
//                [ExProgressHUD showMessage:@"请求超时"];
//            }
        }
    }];
}

- (void)monitoringNetWorkStatus{
    AFNetworkReachabilityManager *manager = [AFNetworkReachabilityManager sharedManager];
    [manager setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        // 当网络状态改变时调用
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未知网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"没有网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"手机自带网络");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"WIFI");
                break;
        }
        if (status ==AFNetworkReachabilityStatusReachableViaWWAN || status ==AFNetworkReachabilityStatusReachableViaWiFi ) {
            NSLog(@"有网");
        }else{
            NSLog(@"没有网");
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"网络失去连接" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alert.delegate = self;
            [alert show];
//            [ExProgressHUD hide];
        }
    }];
    //开始监控
    [manager startMonitoring];
}

-(void)uploadImageWithUrlString:(NSString *)urlStr
                         method:(NSString *)method
                     parameters:(NSDictionary *)parameters
                     imageArray:(NSArray *)imageArray
                        success:(void(^_Nullable)(id _Nullable responseObject))success
                        failure:(void(^_Nullable)(NSError * _Nonnull error))failure
{
//    [self monitoringNetWorkStatus];
    [self.requestSerializer setValue:self.token forHTTPHeaderField:@"token"];
    NSLog(@"%@--%@",urlStr,parameters);
    NSString * url;
       if ([urlStr hasPrefix:@"http"] || [urlStr hasPrefix:@"https"]) {
           url = urlStr;
       }else
       {
           url = [NSString stringWithFormat:@"%@%@",self.baseURL,urlStr];
       }
    
    [self POST:url parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        for (int i=0; i<imageArray.count; i++) {
            NSDictionary *dic = imageArray[i];
            [formData appendPartWithFileData:dic[@"data"] name:dic[@"key"] fileName:[NSString stringWithFormat:@"upload%d.png",i] mimeType:@"image/png"];
        }
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
        NSDictionary *dict = [self processDictionaryIsNSNull:responseObject];
        NSLog(@"%@----%@",task.currentRequest,dict);
        if (success) {
            success(dict);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        if (error.code  == -1001) {
//            [ExProgressHUD showMessage:@"请求超时"];
            UIAlertView *alert = [[UIAlertView alloc]initWithTitle:@"请求超时" message:nil delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil,nil];
            alert.delegate = self;
            [alert show];
        }
        if (failure) {
            failure(error);
        }
    }];
}



//替换null为空
- (id) processDictionaryIsNSNull:(id)obj{
    const NSString *blank = @"";
    
    if ([obj isKindOfClass:[NSDictionary class]]) {
        NSMutableDictionary *dt = [(NSMutableDictionary*)obj mutableCopy];
        for(NSString *key in [dt allKeys]) {
            id object = [dt objectForKey:key];
            if([object isKindOfClass:[NSNull class]]) {
                [dt setObject:blank
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSString class]]){
                NSString *strobj = (NSString*)object;
                if ([strobj isEqualToString:@"<null>"]) {
                    [dt setObject:blank
                           forKey:key];
                }
                if ([strobj isEqualToString:@"(null)"]) {
                    [dt setObject:blank
                           forKey:key];
                }
                if ([strobj isEqualToString:@"NULL"]) {
                    [dt setObject:blank
                           forKey:key];
                }
            }
            else if ([object isKindOfClass:[NSArray class]]){
                NSArray *da = (NSArray*)object;
                da = [self processDictionaryIsNSNull:da];
                [dt setObject:da
                       forKey:key];
            }
            else if ([object isKindOfClass:[NSDictionary class]]){
                NSDictionary *ddc = (NSDictionary*)object;
                ddc = [self processDictionaryIsNSNull:object];
                [dt setObject:ddc forKey:key];
            }
        }
        return [dt copy];
    }
    else if ([obj isKindOfClass:[NSArray class]]){
        NSMutableArray *da = [(NSMutableArray*)obj mutableCopy];
        for (int i=0; i<[da count]; i++) {
            NSDictionary *dc = [obj objectAtIndex:i];
            dc = [self processDictionaryIsNSNull:dc];
            [da replaceObjectAtIndex:i withObject:dc];
        }
        return [da copy];
    }
    else{
        return obj;
    }
}

@end
