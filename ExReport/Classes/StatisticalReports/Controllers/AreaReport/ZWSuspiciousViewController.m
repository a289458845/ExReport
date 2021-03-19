//
//  ZWSuspiciousViewController.m
//  Muck
//
//  Created by 张威 on 2018/8/5.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWSuspiciousViewController.h"
#import "ZWDivDateView.h"
#import "ZWSwitchAreaView.h"
#import "ZWStatisticalTableHeaderView.h"
#import "ZWSuspiciousListController.h"
#import "ZWRegionModel.h"
#import "ZWDateTypeModel.h"

static NSString *collectionViewCellRid = @"collectionViewCellRid";

@interface ZWSuspiciousViewController ()
<
  ZWSwitchAreaViewDelegate,
  rBasePageViewControllerDelegate,
  rBasePageViewControllerDataSource,
  ZWDivDateViewDelegate
>
@property (nonatomic, strong) ZWDivDateView *dateView;
@property (nonatomic, strong) ZWSwitchAreaView *switchAreaView;
@property (nonatomic, strong) NSArray <ZWRegionModel *>*areaDataSource;
@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) ZWDateTypeModel *dateType;

@end

@implementation ZWSuspiciousViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
//    self.Type = 3;
    
    [self loadTimeData];
    if (self.controllerType == rSuspiciousViewControllerWorkSite) {
        [self setupNavigationTitleWithTitle:@"区域可疑工地"];
    } else if (self.controllerType == rSuspiciousViewControllerTypeAbsorptive) {
        [self setupNavigationTitleWithTitle:@"区域可疑消纳点"];
    }
    self.delegate = self;
    self.dataSource = self;
    [self reloadPageViewController];

}

- (void)loadTimeData{
    
    NSDictionary *params = @{
                             @"Type":self.dateType.type
                             };
    
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetTypeTime parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            self.dateType.beginDate = responseObject[@"Data"][@"BeginDate"];
            self.dateType.endDate = responseObject[@"Data"][@"EndDate"];
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
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
    ZWSuspiciousListController *vc = [[ZWSuspiciousListController alloc] init];
    if (self.controllerType == rSuspiciousViewControllerWorkSite) {
        vc.controllerType = rSuspiciousViewControllerWorkSite;
    }else{
        vc.controllerType = rSuspiciousViewControllerTypeAbsorptive;
    }
    vc.index = index;
    ZWRegionModel *model = self.areaDataSource[index];
    vc.DepartmentName = model.Name;
    vc.Code = model.Code;
    vc.dateType = self.dateType;
    return vc;
}
#pragma mark - rBasePageViewControllerDelegate
///返回当前显示的视图控制器
- (void)basePageViewController:(rBasePageViewController *)pageVC didFinishScrollWithCurrentViewController:(UIViewController *)viewController
{
    ZWSuspiciousListController *listVC = (ZWSuspiciousListController *)viewController;
    self.switchAreaView.selectedIndex = listVC.index;

}
///返回当前将要滑动的视图控制器
-(void)basePageViewController:(rBasePageViewController *)pageVC willScrollerWithCurrentViewController:(UIViewController *)ViewController{
    
}

#pragma mark - ZWSwitchAreaViewDelegate

- (void)switchAreaView:(ZWSwitchAreaView *)switchAreaView didClickLastWithCurrentIndex:(NSInteger)index currentTitle:(NSString *)title{
    [self setViewControllerIndex:index direction:rBasePageViewControllerDirectionReverse animated:YES];
}

- (void)switchAreaView:(ZWSwitchAreaView *)switchAreaView didClickNextWithCurrentIndex:(NSInteger)index currentTitle:(NSString *)title{
    [self setViewControllerIndex:index direction:rBasePageViewControllerDirectionForward animated:YES];
}

#pragma mark - ZWDivDateViewDelegate
// Type  1=昨日 2=今日 3=本周 4=本月 5=时间段 6=上周
- (void)ZWDivDateViewDelegateClickType:(NSInteger)index{
    switch (index) {
        case 0:{
            self.dateType.type = @5;
            [self showSelectedTimeType];
            break;
        }
        case 1:{
            self.dateType.type = @6;
            [self setViewControllersType];
            break;
        }
        case 2:{
            self.dateType.type = @3;
            [self setViewControllersType];
            break;
        }
        default:
            break;
    }
    
}

- (void)setViewControllersType
{
    for (ZWSuspiciousListController *controller in self.viewControllers) {
        controller.dateType = self.dateType;
        
    }
    ZWSuspiciousListController *vc = (ZWSuspiciousListController *)self.currentViewController;
    [vc updateType];
}

- (void)showSelectedTimeType{
    for (ZWSuspiciousListController *controller in self.viewControllers) {
        controller.dateType = self.dateType;
    }
    ZWSuspiciousListController *vc = (ZWSuspiciousListController *)self.currentViewController;
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

- (ZWDateTypeModel *)dateType
{
    if (!_dateType) {
        _dateType = [[ZWDateTypeModel alloc] init];
        _dateType.dateType = ZWDateTypeWeek;
    }
    return _dateType;
}

@end
