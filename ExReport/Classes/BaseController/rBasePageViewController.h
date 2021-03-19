//
//  rBasePageViewController.h
//  ExReport
//
//  Created by exsun on 2021/3/15.
//

#import "rBaseViewController.h"

NS_ASSUME_NONNULL_BEGIN

@class rBasePageViewController;

typedef NS_ENUM(NSInteger, rBasePageViewControllerDirection) {
    rBasePageViewControllerDirectionForward,//is right-to-left 正向切换
    rBasePageViewControllerDirectionReverse//is left-to-right  反向切换
};

@protocol rBasePageViewControllerDelegate <NSObject>
@optional
///返回当前显示的视图控制器
- (void)basePageViewController:(rBasePageViewController *)pageVC didFinishScrollWithCurrentViewController:(UIViewController *)viewController;
///返回当前将要滑动的视图控制器
-(void)basePageViewController:(rBasePageViewController *)pageVC willScrollerWithCurrentViewController:(UIViewController *)ViewController;

@end

@protocol rBasePageViewControllerDataSource <NSObject>
@required
- (NSInteger)numberViewControllersInBasePageViewController:(rBasePageViewController *)pageVC;
- (UIViewController *)basePageViewController:(rBasePageViewController *)pageVC indexOfViewControllers:(NSInteger)index;


@end

@interface rBasePageViewController : rBaseViewController
///刷新
- (void)reloadPageViewController;

@property (weak, nonatomic) id<rBasePageViewControllerDelegate> delegate;
@property (weak, nonatomic) id<rBasePageViewControllerDataSource> dataSource;

@property (nonatomic, strong, readonly) NSArray *viewControllers;
@property (nonatomic, strong, readonly) UIViewController *currentViewController;

- (void)setViewControllerIndex:(NSInteger)index direction:(rBasePageViewControllerDirection)direction animated:(BOOL)animated;


@end

NS_ASSUME_NONNULL_END
