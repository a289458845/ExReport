//
//  ExDefine.h
//  ExCheckCar
//
//  Created by exsun on 2020/12/17.
//

#ifndef ExDefine_h
#define ExDefine_h

#define MAS_COLOR UIColor

#import <ExReport/ExColor.h>
#import <ExReport/UIColor+Hex.h>
#import <ExReport/UILabel+BasicAttributes.h>
#import <ExReport/ExApi.h>
#import <ExReport/rTools.h>
//#import <ExCheckCar/ExPrivateTools.h>
//#import <Masonry/Masonry.h>
//#import <MJRefresh/MJRefresh.h>
//#import <MJExtension/MJExtension.h>
//#import <ExCheckCar/ExNetwork.h>
//#import <ExCheckCar/ExApi.h>
#define kScreenWidth  [UIScreen mainScreen].bounds.size.width
#define kScreenHeight [UIScreen mainScreen].bounds.size.height

#define kIsBangsScreen ({\
    BOOL isBangsScreen = NO; \
    if (@available(iOS 11.0, *)) { \
    UIWindow *window = [[UIApplication sharedApplication].windows firstObject]; \
    isBangsScreen = window.safeAreaInsets.bottom > 0; \
    } \
    isBangsScreen; \
})

//------获取沙盒Document路径
#define kDocumentPath [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]
//沙盒路径
#define kDocPath      [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) lastObject]

#define kWidth(x) (((x)/750.f)*[UIScreen mainScreen].bounds.size.width)
#define kHeight(x) (((x)/1334.f)*[UIScreen mainScreen].bounds.size.height)
#define kSystemFont(x) [UIFont fontWithName:@"Helvetica" size:(kScreenWidth/750.0)*x]
#define kSystemDefauletFont(x) [UIFont fontWithName:@"Helvetica-Bold" size:(kScreenWidth/750.0)*x]


#define COLORWITHHEX(h) [UIColor colorWithHexString:(h)]
#define ExStatuBarHeight (kIsBangsScreen ? 44 : 20 )
#define ExNavigationHeight (kIsBangsScreen ? 88 : 64 )
#define ExNavigationBarHeight  (kIsBangsScreen ? 83 : 49 )
#define ExSafeAreaBottom (kIsBangsScreen ? 34 : 0)

#define DefaultLocationTimeout 10
#define DefaultReGeocodeTimeout 5


#define kNavigationSize  kSystemDefauletFont(32)
#define kFirstLeveSize  kSystemFont(32)  //一级标题
#define kSecordLeveSize  kSystemFont(30) //二级标题
#define kLargeTitleSize  kSystemFont(30) //正文内容 大字体
#define kSmallTitleSize  kSystemFont(28) //正文内容 小字体
#define kRemarkTitleSize  kSystemFont(24) //备注内容
#define kDefaultRC      kWidth(6) //矩形圆角 6px

#endif /* ExDefine_h */
