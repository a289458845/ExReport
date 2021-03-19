//
//  ExProgressHUD.m
//  PictureHouseKeeper
//
//  Created by 李亚军 on 16/8/19.
//  Copyright © 2016年 zyyj. All rights reserved.
//

#import "ExProgressHUD.h"

@implementation ExProgressHUD

+(instancetype)shareinstance{
    
    static ExProgressHUD *instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        instance = [[ExProgressHUD alloc] init];
    });
    
    return instance;
    
}

+(void)show:(NSString *)msg inView:(UIView *)view mode:(YJProgressMode)myMode{
    //如果已有弹框，先消失
    if ([ExProgressHUD shareinstance].hud != nil) {
        [[ExProgressHUD shareinstance].hud hideAnimated:YES];
        [ExProgressHUD shareinstance].hud = nil;
    }
    //4\4s屏幕避免键盘存在时遮挡
    if ([UIScreen mainScreen].bounds.size.height == 480) {
        [view endEditing:YES];
    }
    
    [ExProgressHUD shareinstance].hud = [MBProgressHUD showHUDAddedTo:view animated:YES];
    [ExProgressHUD shareinstance].hud.userInteractionEnabled = NO;
    //[ExProgressHUD shareinstance].hud.dimBackground = YES;    //是否显示透明背景
    [ExProgressHUD shareinstance].hud.color = [UIColor blackColor];
    [[ExProgressHUD shareinstance].hud setMargin:kWidth(20)];
    [[ExProgressHUD shareinstance].hud setRemoveFromSuperViewOnHide:YES];
    [ExProgressHUD shareinstance].hud.detailsLabel.text = msg;
    [ExProgressHUD shareinstance].hud.contentColor = [UIColor whiteColor];
    [ExProgressHUD shareinstance].hud.detailsLabel.font = kSystemFont(36);
    switch ((NSInteger)myMode) {
        case YJProgressModeOnlyText:
            [ExProgressHUD shareinstance].hud.mode = MBProgressHUDModeText;
            break;
        case YJProgressModeLoading:
            [ExProgressHUD shareinstance].hud.mode = MBProgressHUDModeIndeterminate;
            break;
        case YJProgressModeCircleLoading:
            [ExProgressHUD shareinstance].hud.mode = MBProgressHUDModeDeterminate;
            break;
        case YJProgressModeSuccess:
            [ExProgressHUD shareinstance].hud.mode = MBProgressHUDModeCustomView;
            [ExProgressHUD shareinstance].hud.customView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"success"]];
            break;
        default:
            break;
    }
}
    

+(void)hide{
    if ([ExProgressHUD shareinstance].hud != nil) {
        [[ExProgressHUD shareinstance].hud hideAnimated:YES];
    }
}


+(void)showMessage:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:YJProgressModeOnlyText];
    [[ExProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.0];
}
+(void)showMessage:(NSString *)msg {
   
    dispatch_async(dispatch_get_main_queue(), ^{
         [self show:msg inView:[[UIApplication sharedApplication].windows lastObject] mode:YJProgressModeOnlyText];
        [[ExProgressHUD shareinstance].hud hideAnimated:YES afterDelay:2.0];
    });
    
}
+(void)showOnlyText:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:YJProgressModeOnlyText];
}
+(void)showMessage:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay{
    [self show:msg inView:view mode:YJProgressModeOnlyText];
    [[ExProgressHUD shareinstance].hud hideAnimated:YES afterDelay:delay];
}
+(void)showSuccess:(NSString *)msg inview:(UIView *)view{
    [self show:msg inView:view mode:YJProgressModeSuccess];
    [[ExProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.0];
}
+(void)showProgress:(NSString *)msg inView:(UIView *)view{
    [self show:msg inView:view mode:YJProgressModeLoading];
}
+(void)showProgress:(NSString *)msg inView:(UIView *)view afterDelayTime:(NSInteger)delay{
    [self show:msg inView:view mode:YJProgressModeLoading];
     [[ExProgressHUD shareinstance].hud hideAnimated:YES afterDelay:delay];
}
+ (void)showProgress:(NSString *)msg
{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIWindow *window = [ExProgressHUD lastWindow];
        [self show:msg inView:window mode:YJProgressModeLoading];
    });
}
+(void)showMsgWithoutView:(NSString *)msg{
    UIWindow *view = [[UIApplication sharedApplication].windows lastObject];
    [self show:msg inView:view mode:YJProgressModeOnlyText];
    [[ExProgressHUD shareinstance].hud hideAnimated:YES afterDelay:1.0];
}


+ (UIWindow *)lastWindow
{
    NSArray *windows = [UIApplication sharedApplication].windows;
    for(UIWindow *window in [windows reverseObjectEnumerator]) {
        
        if ([window isKindOfClass:[UIWindow class]] &&
            CGRectEqualToRect(window.bounds, [UIScreen mainScreen].bounds))
            return window;
    }
    
    return [UIApplication sharedApplication].keyWindow;
}
@end
