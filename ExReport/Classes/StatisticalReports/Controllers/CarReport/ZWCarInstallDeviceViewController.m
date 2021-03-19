//
//  ZWCarInstallDeviceViewController.m
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarInstallDeviceViewController.h"
#import "ZWDivDateView.h"
#import "ZWSwitchAreaView.h"
#import "ZWCarInstallDeviceListViewController.h"
#import "ZWCarInstallDeviceOtherListViewController.h"
#import "ZWRegionModel.h"
#import "ZWDateTypeModel.h"
#import "NSDate+String.h"

@interface ZWCarInstallDeviceViewController ()
    <ZWSwitchAreaViewDelegate,
    rBasePageViewControllerDelegate,
    rBasePageViewControllerDataSource,
    ZWDivDateViewDelegate
    >

@property (nonatomic, strong) ZWDivDateView *dateView;
@property (nonatomic, strong) ZWSwitchAreaView *switchAreaView;
@property (nonatomic, strong) NSArray <ZWRegionModel *>*areaDataSource;
@property(strong, nonatomic)ZWDateTypeModel  *dateType;

@property (copy, nonatomic)NSString *beginDate;
@property (copy, nonatomic)NSString *endDate;
@end

@implementation ZWCarInstallDeviceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self setupNavigationTitleWithTitle:@"已装设备车辆统计"];

    self.dateType.beginDate = [NSDate thisWeekBeginDate];
    self.dateType.endDate = [NSDate thisWeekEndDate];
    




    self.delegate = self;
    self.dataSource = self;
    [self reloadPageViewController];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.dateView.frame = CGRectMake(0, ExNavigationHeight, kScreenWidth, kWidth(88));
    self.switchAreaView.frame = CGRectMake(0, CGRectGetMaxY(self.dateView.frame), kScreenWidth, kWidth(88));
    
}





#pragma mark - rBasePageViewControllerDataSource
- (NSInteger)numberViewControllersInBasePageViewController:(rBasePageViewController *)pageVC{
    return self.areaDataSource.count;
}

- (UIViewController *)basePageViewController:(rBasePageViewController *)pageVC indexOfViewControllers:(NSInteger)index{
    if (index == 0) {
        ZWCarInstallDeviceListViewController *vc = [[ZWCarInstallDeviceListViewController alloc] init];
        vc.index = index;
        ZWRegionModel *model = self.areaDataSource[index];
        vc.DepartmentName  = model.Name;
        vc.DepartmentId = model.Id;
        vc.dateType = self.dateType;
        return vc;
    } else {
        ZWCarInstallDeviceOtherListViewController *vc = [[ZWCarInstallDeviceOtherListViewController alloc] init];
        vc.index = index;
        ZWRegionModel *model = self.areaDataSource[index];
        vc.DepartmentName  = model.Name;
        vc.DepartmentId = model.Id;
        vc.dateType = self.dateType;
        return vc;
    }
}
#pragma mark - rBasePageViewControllerDelegate
///返回当前显示的视图控制器
- (void)basePageViewController:(rBasePageViewController *)pageVC didFinishScrollWithCurrentViewController:(UIViewController *)viewController
{
    ZWCarInstallDeviceOtherListViewController *listVC = (ZWCarInstallDeviceOtherListViewController *)viewController;
    self.switchAreaView.selectedIndex = listVC.index;
}
///返回当前将要滑动的视图控制器
-(void)basePageViewController:(rBasePageViewController *)pageVC willScrollerWithCurrentViewController:(UIViewController *)ViewController
{
    
}

#pragma mark - ZWSwitchAreaViewDelegate

- (void)switchAreaView:(ZWSwitchAreaView *)switchAreaView didClickLastWithCurrentIndex:(NSInteger)index currentTitle:(NSString *)title
{
    [self setViewControllerIndex:index direction:rBasePageViewControllerDirectionReverse animated:YES];
}

- (void)switchAreaView:(ZWSwitchAreaView *)switchAreaView didClickNextWithCurrentIndex:(NSInteger)index currentTitle:(NSString *)title
{
    [self setViewControllerIndex:index direction:rBasePageViewControllerDirectionForward animated:YES];
}

#pragma mark - ZWDivDateViewDelegate
// Type  1=昨日 2=今日 3=本周 4=本月 5=时间段 6=上周
- (void)ZWDivDateViewDelegateClickType:(NSInteger)index{
    switch (index) {
        case 0:{
            [self showSelectedTimeType];
            break;
        }
        case 1:{
            self.dateType.beginDate = [NSDate lastWeekBeginDate];
            self.dateType.endDate = [NSDate lastWeekEndDate];
            
            [self setViewControllersType];
            break;
        }
        case 2:{
            self.dateType.beginDate = [NSDate thisWeekBeginDate];
            self.dateType.endDate = [NSDate thisWeekEndDate];
            [self setViewControllersType];
            break;
        }
        default:
            break;
    }
}

- (void)setViewControllersType
{
    for (ZWCarInstallDeviceListViewController *controller in self.viewControllers) {
        controller.dateType = self.dateType;
        
    }
    ZWCarInstallDeviceListViewController *vc = (ZWCarInstallDeviceListViewController *)self.currentViewController;
    [vc updateType];
}

- (void)showSelectedTimeType{
    for (ZWCarInstallDeviceOtherListViewController *controller in self.viewControllers) {
        controller.dateType = self.dateType;
    }
    ZWCarInstallDeviceOtherListViewController *vc = (ZWCarInstallDeviceOtherListViewController *)self.currentViewController;
    [vc selectTimeViewShow];
}


#pragma mark - lazy

- (ZWDivDateView *)dateView{
    if (!_dateView) {
        _dateView = [[ZWDivDateView alloc] init];
        _dateView.type = ZWDivDateTypeWeek;
        _dateView.delegate = self;
        [self.view addSubview:_dateView];
    }
    return _dateView;
}

- (ZWSwitchAreaView *)switchAreaView{
    if (!_switchAreaView) {
        _switchAreaView = [[ZWSwitchAreaView alloc] init];
        NSMutableArray *temp = @[].mutableCopy;
        for (ZWRegionModel *model in self.areaDataSource) {
            [temp addObject:model.Name];
        }
        _switchAreaView.dataSource = temp;
        _switchAreaView.delegate = self;
        [self.view addSubview:_switchAreaView];
    }
    return _switchAreaView;
}

- (NSArray *)areaDataSource{
    if (!_areaDataSource) {
        NSString *path = [kDocPath stringByAppendingPathComponent:@"region.data"];
        NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
        _areaDataSource = array;
    }
    return _areaDataSource;
}

- (ZWDateTypeModel *)dateType{
    if (!_dateType) {
        _dateType = [[ZWDateTypeModel alloc] init];
        
    }
    return _dateType;
}









- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
