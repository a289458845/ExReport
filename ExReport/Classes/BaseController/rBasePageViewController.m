//
//  rBasePageViewController.m
//  ExReport
//
//  Created by exsun on 2021/3/15.
//

#import "rBasePageViewController.h"

@interface rBasePageViewController ()<UIPageViewControllerDelegate,UIPageViewControllerDataSource>{
    NSInteger totalVC;//VC的总数量
    NSArray *VCArray; //存放VC的数组
    NSInteger currentVCIndex; //当前VC索引
}

@property (nonatomic,strong) UIPageViewController *pageViewController;



@end

@implementation rBasePageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
}


- (void)reloadPageViewController
{
    if ([self.dataSource respondsToSelector:@selector(numberViewControllersInBasePageViewController:)]) {
        totalVC = [self.dataSource numberViewControllersInBasePageViewController:self];
        NSMutableArray *VCList = @[].mutableCopy;
        for (int i = 0; i < totalVC; i++) {
            if ([self.dataSource respondsToSelector:@selector(basePageViewController:indexOfViewControllers:)]) {
                id viewController = [self.dataSource basePageViewController:self indexOfViewControllers:i];
                if ([viewController isKindOfClass:[UIViewController class]]) {
                    [VCList addObject:viewController];
                }
            }
        }
        VCArray = VCList.copy;
    }
    if (VCArray.count) {
        [_pageViewController setViewControllers:@[VCArray[0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    }
}

- (NSArray *)viewControllers
{
    return VCArray;
}

- (UIViewController *)currentViewController
{
    NSInteger index = [VCArray indexOfObject:self.pageViewController.viewControllers.firstObject];
    return VCArray[index];
}

- (void)setViewControllerIndex:(NSInteger)index direction:(rBasePageViewControllerDirection)direction animated:(BOOL)animated{
    //显示某个控制器
    [_pageViewController setViewControllers:@[VCArray[index]] direction:(UIPageViewControllerNavigationDirection)direction animated:animated completion:nil];
}

#pragma mark - UIPageViewControllerDelegate
//滑动结束时的回调
- (void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray<UIViewController *> *)previousViewControllers transitionCompleted:(BOOL)completed{
    if (completed) {//是否切换成功
        if (currentVCIndex != [VCArray indexOfObject:previousViewControllers[0]]) {
            if ([self.delegate respondsToSelector:@selector(basePageViewController:didFinishScrollWithCurrentViewController:)]) {
                [self.delegate basePageViewController:self didFinishScrollWithCurrentViewController:[VCArray objectAtIndex:currentVCIndex]];
            }
        }
    }
}

//手势滑动(或翻页)开始时回调
- (void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray<UIViewController *> *)pendingViewControllers{
    currentVCIndex = [VCArray indexOfObject:pendingViewControllers[0]];
    if ([self.delegate respondsToSelector:@selector(basePageViewController:willScrollerWithCurrentViewController:)]) {
        [self.delegate basePageViewController:self willScrollerWithCurrentViewController:pageViewController.viewControllers[0]];
    }
}

#pragma mark - UIPageViewControllerDataSource
// 返回当前控制器的前一个控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController{
    NSInteger index = [VCArray indexOfObject:viewController];
    if (index == 0 || index == NSNotFound) {
        return nil;
    }else{
        return VCArray[--index];
    }
}
// 返回当前控制器的后一个控制器
- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController{
    NSInteger index = [VCArray indexOfObject:viewController];
    if (index == VCArray.count-1 || index == NSNotFound) {
        return nil;
    }else{
        return VCArray[++index];
    }
}

//初始化
-(UIPageViewController *)pageViewController{
    if (!_pageViewController) {
        _pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
        _pageViewController.delegate = self;
        _pageViewController.dataSource = self;
    }
    return _pageViewController;
}


@end
