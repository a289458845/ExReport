//
//  UIImage+clip.m
//  MonitoringNetwork
//
//  Created by admin on 2017/11/30.
//  Copyright © 2017年 wtmcxlm. All rights reserved.
//

#import "UIImage+clip.h"

@implementation UIImage (clip)
- (UIImage *)scaleImage:(UIImage *)image toSize:(CGSize)size
{
    UIGraphicsBeginImageContextWithOptions(size,NO,0.0);
    [image drawInRect:CGRectMake(0, 0, size.width, size.height)];
    UIImage *scaledImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    return scaledImage;
}
@end
