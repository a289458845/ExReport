//
//  rTools.h
//  ExReport
//
//  Created by exsun on 2021/3/16.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface rTools : NSObject

///  获取资源文件路径
/// @param name 文件名
/// @param type 类型
/// @param fName 文件在bundle 下的目录
+(NSString *)getResrouceBundleWithName:(NSString *)name type:(NSString *)type folderName:(NSString *)fName;

///  获取图片资源默认Image路径下，如果需要其他路径使用上面的方法
/// @param name 图片名
+(UIImage *)getResourceImageName:(NSString *)name;

+(id )getCellWithName:(NSString *)cellName;



///  拼接图片地址
/// @param imagePath 图片路径
+(NSString *)appendNetworkImageUrl:(NSString *)imagePath;


/// 主页数据处理
/// @param source 数据源
+ (void)filterStatisticalSectionMeumWithSource:(NSArray *)source;
@end

NS_ASSUME_NONNULL_END
