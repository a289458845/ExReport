//
//  ExNetwork.h
//  ex_sdk
//
//  Created by exsun on 2020/12/14.
//  Copyright © 2020 exsun. All rights reserved.
//

//#import <Foundation/Foundation.h>
//#import <AFHTTPSessionManager.h>
#import <AFNetworking/AFNetworking.h>
NS_ASSUME_NONNULL_BEGIN

@interface ExNetwork : AFHTTPSessionManager
+ (void)initNetwork:(NSString *)baseUrl;


+ (instancetype)sharedManager;

@property(nonatomic,copy)NSString * token;


- (void)PostUrlString:(NSString *_Nullable)urlStr
           parameters:(NSDictionary *_Nullable)parameters
              success:(void(^_Nullable)(id _Nullable responseObject))success
              failure:(void(^_Nullable)(NSError * _Nonnull error))failure;

- (void)GetUrlString:(NSString *_Nullable)urlStr
           parameters:(NSDictionary *_Nullable)parameters
              success:(void(^_Nullable)(id _Nullable responseObject))success
              failure:(void(^_Nullable)(NSError * _Nonnull error))failure;

-(void)uploadImageWithUrlString:(NSString *)urlStr
    method:(NSString *)method
parameters:(NSDictionary *)parameters
imageArray:(NSArray *)imageArray
   success:(void(^_Nullable)(id _Nullable responseObject))success
   failure:(void(^_Nullable)(NSError * _Nonnull error))failur;

- (void)PostUrlString:(NSString *)urlStr
AppendToUrlSuffix:(NSDictionary *)parameters
   success:(void (^)(id _Nullable))success
                  failure:(void (^)(NSError * _Nonnull))failure;
@end

NS_ASSUME_NONNULL_END
