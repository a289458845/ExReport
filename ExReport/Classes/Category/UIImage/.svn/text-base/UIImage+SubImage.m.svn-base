//
//  UIImage+SubImage.m
//  UIImage+Categories
//
//  Created by lisong on 16/9/4.
//  Copyright © 2016年 lisong. All rights reserved.
//

#import "UIImage+SubImage.h"

@implementation UIImage (SubImage)

#pragma mark - 截取当前image对象rect区域内的图像
- (UIImage *)subImageWithRect:(CGRect)rect
{
    CGImageRef newImageRef = CGImageCreateWithImageInRect(self.CGImage, rect);
    
    UIImage *newImage = [UIImage imageWithCGImage:newImageRef];
    
    CGImageRelease(newImageRef);
    
    return newImage;
}

#pragma mark - 压缩图片至指定尺寸
- (UIImage *)rescaleImageToSize:(CGSize)size
{
    CGRect rect = (CGRect){CGPointZero, size};
    
    UIGraphicsBeginImageContextWithOptions(size, NO, [UIScreen mainScreen].scale);
    
    [self drawInRect:rect];
    
    UIImage *resImage = UIGraphicsGetImageFromCurrentImageContext();
    
    UIGraphicsEndImageContext();
    
    return resImage;
}
- (UIImage *)subImageWithRect:(CGRect)rect andSize:(CGSize)size
{
    return [[self subImageWithRect:rect] rescaleImageToSize:size];
}
#pragma mark - 压缩图片至指定像素
- (UIImage *)rescaleImageToPX:(CGFloat )toPX
{
    CGSize size = self.size;
    
    if(size.width <= toPX && size.height <= toPX)
    {
        return self;
    }
    
    CGFloat scale = size.width / size.height;
    
    if(size.width > size.height)
    {
        size.width = toPX;
        size.height = size.width / scale;
    }
    else
    {
        size.height = toPX;
        size.width = size.height * scale;
    }
    
    return [self rescaleImageToSize:size];
}

#pragma mark - 指定大小生成一个平铺的图片
- (UIImage *)getTiledImageWithSize:(CGSize)size
{
    UIView *tempView = [[UIView alloc] init];
    tempView.bounds = (CGRect){CGPointZero, size};
    tempView.backgroundColor = [UIColor colorWithPatternImage:self];
    
    UIGraphicsBeginImageContext(size);
    [tempView.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *bgImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return bgImage;
}

#pragma mark - UIView转化为UIImage
+ (UIImage *)imageFromView:(UIView *)view
{
    CGFloat scale = [UIScreen mainScreen].scale;
    UIGraphicsBeginImageContextWithOptions(view.frame.size, NO, scale);
    [view.layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    
    return image;
}

#pragma mark - 将两个图片生成一张图片
+ (UIImage*)mergeImage:(UIImage*)firstImage withImage:(UIImage*)secondImage
{
    CGImageRef firstImageRef = firstImage.CGImage;
    CGFloat firstWidth = CGImageGetWidth(firstImageRef);
    CGFloat firstHeight = CGImageGetHeight(firstImageRef);
    CGImageRef secondImageRef = secondImage.CGImage;
    CGFloat secondWidth = CGImageGetWidth(secondImageRef);
    CGFloat secondHeight = CGImageGetHeight(secondImageRef);
    CGSize mergedSize = CGSizeMake(MAX(firstWidth, secondWidth), MAX(firstHeight, secondHeight));
    UIGraphicsBeginImageContext(mergedSize);
    [firstImage drawInRect:CGRectMake(0, 0, firstWidth, firstHeight)];
    [secondImage drawInRect:CGRectMake(0, 0, secondWidth, secondHeight)];
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return image;
}
//压缩图片尺寸
+ (UIImage *)compressImageSize:(UIImage *)image toByte:(NSUInteger)maxLength {
    
    UIImage *resultImage = image;
    
    NSData *data = UIImageJPEGRepresentation(resultImage,1);
    
    NSUInteger lastDataLength = 0;
    
    while (data.length > maxLength && data.length != lastDataLength) {
        //
        
        lastDataLength = data.length;
        
        CGFloat ratio = (CGFloat) maxLength / data.length;
        
        //每次绘制的尺寸 size，要把宽 width 和 高 height 转换为整数，防止绘制出的图片有白边
        
        CGSize size = CGSizeMake((NSUInteger)(resultImage.size.width * sqrtf(ratio)),
                                 
                                 (NSUInteger)(resultImage.size.height * sqrtf(ratio))); // Use NSUInteger to prevent white blank
        UIGraphicsBeginImageContext(size);
        [resultImage drawInRect:CGRectMake(0, 0, size.width, size.height)];
        resultImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        data = UIImageJPEGRepresentation(resultImage, 1);
    }
    return resultImage;
    
}



+ (NSData *)compressOriginalImage:(UIImage *)image toMaxDataSizeKBytes:(CGFloat)size{
        //进行图像尺寸的压缩
        CGSize imageSize = image.size;//取出要压缩的image尺寸
        CGFloat width = imageSize.width;    //图片宽度
        CGFloat height = imageSize.height;  //图片高度
        //1.宽高大于1280(宽高比不按照2来算，按照1来算)
        if (width>1280||height>1280) {
            if (width>height) {
                CGFloat scale = height/width;
                width = 1280;
                height = width*scale;
            }else{
                CGFloat scale = width/height;
                height = 1280;
                width = height*scale;
            }
            //2.宽大于1280高小于1280
        }else if(width>1280||height<1280){
            CGFloat scale = height/width;
            width = 1280;
            height = width*scale;
            //3.宽小于1280高大于1280
        }else if(width<1280||height>1280){
            CGFloat scale = width/height;
            height = 1280;
            width = height*scale;
            //4.宽高都小于1280
        }else{
        }
        UIGraphicsBeginImageContext(CGSizeMake(width, height));
        [image drawInRect:CGRectMake(0,0,width,height)];
        UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
        UIGraphicsEndImageContext();
        
        //进行图像的画面质量压缩
        NSData *data=UIImageJPEGRepresentation(newImage, 1.0);
        CGFloat dataKBytes = data.length/1000.0;
        CGFloat maxQuality = 0.9f;
        CGFloat lastData = dataKBytes;
        while (dataKBytes > size && maxQuality > 0.00f) {
            maxQuality = maxQuality - 0.01f;
            data = UIImageJPEGRepresentation(newImage, maxQuality);
            dataKBytes = data.length / 1000.0;
            if (lastData == dataKBytes) {
                break;
            }else{
                lastData = dataKBytes;
            }
        }
        return data;
}






@end
