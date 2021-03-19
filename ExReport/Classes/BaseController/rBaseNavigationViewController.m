//
//  rBaseNavigationViewController.m
//  ExReport
//
//  Created by exsun on 2021/3/15.
//

#import "rBaseNavigationViewController.h"

@interface rBaseNavigationViewController ()<UINavigationControllerDelegate, UIGestureRecognizerDelegate>
@property (assign, nonatomic) BOOL isSwitching;

@end

@implementation rBaseNavigationViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    UIBarButtonItem *barItem =[UIBarButtonItem appearance];
    // 2.2.设置item的文字属性
    
    NSDictionary *barItemTextAttr = @{NSFontAttributeName:kSystemFont(36),NSForegroundColorAttributeName:COLORWITHHEX(kColor_3A3D44)};
    [barItem setTitleTextAttributes:barItemTextAttr forState:UIControlStateNormal];

    self.navigationBar.tintColor = COLORWITHHEX(kColor_FFFFFF);
    self.delegate = self;
}


- (void)pushViewController:(UIViewController *)viewController animated:(BOOL)animated {
    if (animated) {
        if (self.isSwitching) {
            return; // 1. 如果是动画，并且正在切换，直接忽略
        }
        self.isSwitching = YES; // 2. 否则修改状态
    }
    //在二级界面隐藏TabBar
    if (self.childViewControllers.count==1) {
        viewController.hidesBottomBarWhenPushed = YES; //viewController是将要被push的控制器
    }
    
    [super pushViewController:viewController animated:animated];
}

#pragma mark - UINavigationControllerDelegate

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated {
    self.isSwitching = NO; // 3. 还原状态
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
