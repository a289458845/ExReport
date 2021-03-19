//
//  UIImage+QrCode.h
//  ExSunTwoWheel
//
//  Created by 邵明明 on 2018/6/20.
//  Copyright © 2018年 com.exsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIImage (QrCode)
+ (UIImage *)qrCodeImageWithContent:(NSString *)content
                      codeImageSize:(CGFloat)size
                               logo:(UIImage *)logo
                          logoFrame:(CGRect)logoFrame
                                red:(CGFloat)red
                              green:(CGFloat)green
                               blue:(NSInteger)blue;
+ (UIImage *)barcodeImageWithContent:(NSString *)content
                       codeImageSize:(CGSize)size
                                 red:(CGFloat)red
                               green:(CGFloat)green
                                blue:(NSInteger)blue;
@end
