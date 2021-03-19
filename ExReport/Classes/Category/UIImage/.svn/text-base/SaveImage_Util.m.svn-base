//
//  SaveImage_Util.m
//  photo
//
//  Created by admin on 2017/5/31.
//  Copyright © 2017年 Shenzhen Xinwo Transport. All rights reserved.
//

#import "SaveImage_Util.h"

@implementation SaveImage_Util
#pragma mark  保存图片到document
+ (void)saveImage:(UIImage *)saveImage ImageName:(NSString *)imageName back:(void(^)(NSString *imagePath))back
{
    NSString *path = [SaveImage_Util getImageDocumentFolderPath];
    NSData *imageData = UIImagePNGRepresentation(saveImage);
    NSString *documentsDirectory = [NSString stringWithFormat:@"%@/", path];
    // Now we get the full path to the file
    NSString *imageFile = [documentsDirectory stringByAppendingPathComponent:imageName];
    // and then we write it out
//    NSFileManager *fileManager = [NSFileManager defaultManager];
    //如果文件路径存在的话
    
    [imageData writeToFile:imageFile atomically:YES];
    
    
    
    
    
    
    
    
    
    back(imageFile);
    
//    if (bRet)
//    {
//        //        NSLog(@"文件已存在");
//        if ([fileManager removeItemAtPath:imageFile error:nil])
//        {
//            //            NSLog(@"删除文件成功");
//            if ([imageData writeToFile:imageFile atomically:YES])
//            {
//                //                NSLog(@"保存文件成功");
//                back(imageFile);
//            }
//        }
//        else
//        {
//            
//        }
//        
//    }
//    else
//    {
//        if (![imageData writeToFile:imageFile atomically:NO])
//        {
//            [fileManager createDirectoryAtPath:documentsDirectory withIntermediateDirectories:YES attributes:nil error:nil];
//            if ([imageData writeToFile:imageFile atomically:YES])
//            {
//                back(imageFile);
//            }
//        }
//        else
//        {
//            return YES;
//        }
//        
//    }
//    return NO;
}
#pragma mark  从文档目录下获取Documents路径
+ (NSString *)getImageDocumentFolderPath
{
    
//    NSData *imageData = UIImageJPEGRepresentation(getImage, 0.5);
//    //获取沙盒路径
//    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
//    formatter.dateFormat = @"yyyyMMddHHmmss";
//    NSString *str = [formatter stringFromDate:[NSDate date]];
//    NSString *imageName = [NSString stringWithFormat:@"%@.jpg",str];
//    NSString *fullPath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:imageName];
//    [imageData writeToFile:fullPath atomically:NO];
    NSString *patchDocument = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject];
    return [NSString stringWithFormat:@"%@", patchDocument];
}
@end
//获取这些目录路径的方法：
//1，获取家目录路径的函数：
//NSString *homeDir = NSHomeDirectory();
//2，获取Documents目录路径的方法：
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
//NSString *docDir = [paths objectAtIndex:0];
//3，获取Caches目录路径的方法：
//NSArray *paths = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES);
//NSString *cachesDir = [paths objectAtIndex:0];
//4，获取tmp目录路径的方法：
//NSString *tmpDir = NSTemporaryDirectory();
//5，获取应用程序程序包中资源文件路径的方法：
//例如获取程序包中一个图片资源（apple.png）路径的方法：
//NSString *imagePath = [[NSBundle mainBundle] pathForResource:@”apple” ofType:@”png”];
//UIImage *appleImage = [[UIImage alloc] initWithContentsOfFile:imagePath];
//代码中的mainBundle类方法用于返回一个代表应用程序包的对象。
