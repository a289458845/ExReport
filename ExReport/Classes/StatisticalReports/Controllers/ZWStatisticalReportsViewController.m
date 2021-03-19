//
//  ZWStatisticalReportsViewController.m
//  Muck
//
//  Created by 张威 on 2018/7/18.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWStatisticalReportsViewController.h"
#import "ZWStatisticalReportsCardView.h"
#import "ZWStatisticalReportsItemsView.h"
#import "ZWStatisticalReportsCommonView.h"
#import "ZWStatisticalReportsItemsListView.h"
#import "ZWStatisticalReportsCell.h"
#import "ZWStatisticalReportsReusableHeader.h"
//#import "ZWCompanyOnlineRateViewController.h"
#import "ZWAreaUnearthedViewController.h"
#import "ZWSuspiciousViewController.h"
#import "ZWAreaViolationRankViewController.h"
#import "ZWCompanyBaseDataRankViewController.h"
#import "ZWCompanyViolationUnClosenessViewController.h"
#import "ZWCompanyViolationOverspeedViewController.h"
#import "ZWBuildingUnearthedViewController.h"
#import "ZWAbsorptiveViewController.h"
#import "ZWCarUnClosenessViewController.h"
#import "ZWCarOverspeedViewController.h"
#import "ZWCarOverloadViewController.h"
#import "ZWCarOnlineViewController.h"
#import "ZWBuildingAheadOfUnearthedViewController.h"
#import "ZWBuildingBlackStatisticalReportsViewController.h"
#import "ZWBuildingUnearthedConditionViewController.h"
#import "ZWCarInstallDeviceViewController.h"
#import "ZWKeyMonitoringViewController.h"
//#import <AMapLocationKit/AMapLocationKit.h>
#import "ZWCompanyOnlineRateModel.h"
#import "ZWRegionModel.h"
#import "NSDate+String.h"

@interface ZWStatisticalReportsViewController ()
<
    UICollectionViewDelegate,
    UICollectionViewDataSource,
    ZWStatisticalReportsItemsListViewDelegate,
    ZWStatisticalReportsItemsViewDelegate,
    ZWStatisticalReportsCardViewDelegate,
//    AMapLocationManagerDelegate,
    ZWStatisticalReportsCommonViewDelegate
>

//@property(strong, nonatomic)AMapLocationManager *locationManager;
@property (nonatomic, strong) UIScrollView *scrollView;
/** 企业上线率*/
@property (nonatomic, strong) ZWStatisticalReportsCardView *cardView;
/** 主菜单*/
@property (nonatomic, strong) ZWStatisticalReportsItemsView *itemsView;
/** 常用统计报表*/
@property (nonatomic, strong) ZWStatisticalReportsCommonView *commonView;
/** 顶部菜单*/
@property (nonatomic, strong) ZWStatisticalReportsItemsListView *itemsListView;

@property (nonatomic, strong) UICollectionView *collectionView;
@property (nonatomic, strong) UICollectionViewFlowLayout *layout;
@property (nonatomic, strong) NSArray *dataSource;//数据源
@property (nonatomic, strong) NSArray *sectionHeaderTitles;//组头标题数据源

@property (nonatomic, assign) NSInteger selectedItem;//当前选择的统计报表类型

@property (copy, nonatomic)NSString *currentCity;
@property (copy, nonatomic)NSString *DepartmentName;
@property (copy, nonatomic)NSString *DepartmentId;
@property (strong, nonatomic)ZWCompanyOnlineRateModel *rateModel;
@end
//区域统计报表    1111
//企业统计报表    1112
//工地统计报表    1113
//消纳点统计报表  1114
//车辆统计报表    1115
//专题统计报表    1116
@implementation ZWStatisticalReportsViewController

#pragma mark - 生命控制函数
- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationTitleWithTitle:@"统计报表"];
    self.selectedItem = 0;

    self.scrollView = [[UIScrollView alloc] init];
    self.scrollView.backgroundColor = [UIColor whiteColor];
    self.scrollView.showsVerticalScrollIndicator = NO;
    self.scrollView.delegate = self;
    self.scrollView.bounces = NO;
    [self.view addSubview:self.scrollView];
    
    [self.scrollView addSubview:self.cardView];
    [self.scrollView addSubview:self.itemsView];
    [self.scrollView addSubview:self.commonView];
    [self.scrollView addSubview:self.itemsListView];
    [self.scrollView addSubview:self.collectionView];
    
//    [self configLocationManager];
//    [self.locationManager startUpdatingLocation];
    
    NSString *path = [kDocPath stringByAppendingPathComponent:@"region.data"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    ZWRegionModel *model = [array firstObject];
    self.DepartmentName = model.Name;
    self.DepartmentId = model.Id;
    [self loadData];
}
- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.scrollView.frame = CGRectMake(0, ExNavigationHeight, kScreenWidth, kScreenHeight-ExNavigationHeight);
//    self.cardView.frame = CGRectMake(16, 20, kScreenWidth-32, 100);
        self.cardView.frame = CGRectMake(16, 0, 0, 0);
    self.itemsView.frame = CGRectMake(0, CGRectGetMaxY(self.cardView.frame)+kWidth(20), kScreenWidth, 160);
    self.commonView.frame = CGRectMake(0, CGRectGetMaxY(self.itemsView.frame), kScreenWidth, 240+44);
    self.itemsListView.frame = CGRectMake(0, CGRectGetMaxY(self.itemsView.frame)-60, kScreenWidth, 60);
    self.collectionView.frame = CGRectMake(0, CGRectGetMinY(self.commonView.frame), kScreenWidth, kScreenHeight-CGRectGetHeight(self.itemsListView.frame)-ExNavigationHeight);
    self.scrollView.contentSize = CGSizeMake(kScreenWidth, CGRectGetHeight(self.view.frame)-ExNavigationHeight-ExSafeAreaBottom+CGRectGetMinY(self.itemsListView.frame));
}

#pragma mark - 网络加载
- (void)loadData{
    
    NSDictionary *params = @{
                             @"DepartmentId":self.DepartmentId,
                             @"DepartmentName":self.DepartmentName
                             };
    
  [ExProgressHUD showProgress:@"加载中"];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetEnterpriseTheWholePoint parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSArray class]]) {
                NSArray *resultArray = responseObject[@"Data"];
                if (resultArray && resultArray.count) {
                    NSMutableArray *tempArray = [NSMutableArray array];
                    for (NSDictionary *dict in resultArray) {
                        ZWCompanyOnlineRateModel *model = [ZWCompanyOnlineRateModel mj_objectWithKeyValues:dict];
                        [tempArray addObject:model];
                    }
                    self.rateModel = [tempArray firstObject];
                    self.cardView.model = self.rateModel;
                }
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}

//- (void)configLocationManager{
//    self.locationManager = [[AMapLocationManager alloc] init];
//    [self.locationManager setDelegate:self];
//    [self.locationManager setDesiredAccuracy:kCLLocationAccuracyBest];
//    [self.locationManager setPausesLocationUpdatesAutomatically:NO];
//    [self.locationManager setLocatingWithReGeocode:YES];
//    [self.locationManager setLocationTimeout:DefaultLocationTimeout];
//    [self.locationManager setReGeocodeTimeout:DefaultReGeocodeTimeout];
//}
//#pragma mark -AMapLocationManagerDelegate
//- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error;
//{
//    
//}
//- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode{
//    if (reGeocode.formattedAddress) {
//        self.currentCity = reGeocode.city;
//        [kDefaults setObject:self.currentCity forKey:@"CurrentCity"];
//        [self.locationManager stopUpdatingLocation];
//    }
//}


//点击报表类型滚动到对应的报表位置
- (void)scrollToItem{
    [self.scrollView scrollRectToVisible:CGRectMake(0, CGRectGetMinY(self.itemsListView.frame), kScreenWidth, self.scrollView.bounds.size.height-ExSafeAreaBottom) animated:YES];
    [self.collectionView reloadData];
}

#pragma mark - ZWStatisticalReportsCardViewDelegate
//点击企业上线率
- (void)ZWStatisticalReportsCardViewDidClick:(ZWStatisticalReportsCardView *)view{
//    ZWCompanyOnlineRateViewController *vc = [[ZWCompanyOnlineRateViewController alloc] init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - ZWStatisticalReportsItemsListViewDelegate


-(void)ZWStatisticalReportsItemsListView:(ZWStatisticalReportsItemsListView *)view didSelectIndex:(NSInteger)index{
    
    NSLog(@"%zd",index);
    self.selectedItem = index;
    [self.collectionView reloadData];
}

#pragma mark - UIScrollViewDelegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{
//    NSLog(@"%f",scrollView.contentOffset.y);
    //设定一个临界值
    CGFloat Y = CGRectGetMinY(self.itemsListView.frame);
    //此处过滤掉还未布局完之前的状态
    if (Y == 0) return;
    //初始值
    CGFloat O = 0;
    //当前值
    CGFloat offsetY = scrollView.contentOffset.y;
    if (offsetY+5 >= Y) {
        self.itemsView.alpha = 0;
        self.itemsListView.alpha = 1;
        self.collectionView.alpha = 1;
    } else {
        self.itemsView.alpha = (Y-(offsetY-O))/(Y-O);
        self.itemsListView.alpha = 0;
        self.collectionView.alpha = 0;
    }
}

#pragma mark - ZWStatisticalReportsItemsViewDelegate
- (void)ZWStatisticalReportsItemsViewDidSelected:(ZWStatisticalReportsItemsView *)view didSelectIndex:(NSInteger)index{
    
    if (index == 0) {
        self.selectedItem = 0;
        self.itemsListView.selectIndex = 0;
        [self scrollToItem];
    }
    if (index == 1) {
        self.selectedItem = 1;
        self.itemsListView.selectIndex = 1;

        [self scrollToItem];
    }
    if (index == 2) {
        self.selectedItem = 2;
        self.itemsListView.selectIndex = 2;
        [self scrollToItem];
    }
    if (index == 3) {
        self.selectedItem = 3;
        self.itemsListView.selectIndex = 3;
        [self scrollToItem];
    }
    if (index == 4) {
        self.selectedItem = 4;
        self.itemsListView.selectIndex = 4;
        [self scrollToItem];
    }
    if (index == 5) {
        self.selectedItem = 5;
        self.itemsListView.selectIndex = 5;
        [self scrollToItem];
    }
}


#pragma mark - ZWStatisticalReportsCommonViewDelegate

- (void)tatisticalReportsCommonViewDidSelected:(ZWStatisticalReportsCommonView *)view WithUrl:(NSInteger)url{
    if (url == 11111) {
        //区域出土量
        ZWAreaUnearthedViewController *vc = [[ZWAreaUnearthedViewController alloc] init];
        vc.controllerType = ZWAreaUnearthedController;
        [self.navigationController pushViewController:vc animated:YES];
    }

    if (url == 11123) {
        //未密闭率最高企业
        ZWCompanyViolationUnClosenessViewController *vc = [[ZWCompanyViolationUnClosenessViewController alloc] init];
        vc.controllerType = ZWCompanyViolationUnClosenessViewControllerUnClosenessRateMost;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (url == 11161) {
        //专题监控区域
        ZWKeyMonitoringViewController *vc = [[ZWKeyMonitoringViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (url == 11133) {
        // 提前出土工地
        ZWBuildingAheadOfUnearthedViewController *vc = [[ZWBuildingAheadOfUnearthedViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (url == 11134) {
        //工地出土情况
        ZWBuildingUnearthedConditionViewController *vc = [[ZWBuildingUnearthedConditionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (url == 11113) {
        //区域可疑工地
        ZWSuspiciousViewController *vc = [[ZWSuspiciousViewController alloc] init];
        vc.controllerType = rSuspiciousViewControllerWorkSite;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (url == 11141) {
        //消纳量最多消纳点
        ZWAbsorptiveViewController *vc = [[ZWAbsorptiveViewController alloc] init];
        vc.controllerType = ZWAbsorptiveViewControllerMost;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if (url == 11153) {
        //未密闭时长最高车辆
        ZWCarUnClosenessViewController *vc = [[ZWCarUnClosenessViewController alloc] init];
        vc.controllerType = ZWCarUnClosenessViewControllerMost;
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - UICollectionViewDataSource

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    NSArray *tag = self.dataSource[self.selectedItem];
    return tag.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    NSArray *tag = self.dataSource[self.selectedItem];
    NSArray *sec = tag[section];
    return sec.count;
}


- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWStatisticalReportsCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZWStatisticalReportsCell class]) forIndexPath:indexPath];
    NSArray *tag = self.dataSource[self.selectedItem];
    NSArray *sec = tag[indexPath.section];
    cell.dict = sec[indexPath.item];
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    ZWStatisticalReportsReusableHeader *header = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ZWStatisticalReportsReusableHeader class]) forIndexPath:indexPath];
        NSArray *sec = self.sectionHeaderTitles[self.selectedItem];
        header.titleLabel.text = sec[indexPath.section];
    }
    return header;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSArray *tag = self.dataSource[self.selectedItem];
    NSArray *sec = tag[indexPath.section];
    NSDictionary *item = sec[indexPath.item];
    if ([item[@"Url"]  integerValue] == 11111) {
        //区域出土量
        ZWAreaUnearthedViewController *vc = [[ZWAreaUnearthedViewController alloc] init];
        vc.controllerType = ZWAreaUnearthedController;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11112) {
        //区域消纳量
        ZWAreaUnearthedViewController *vc = [[ZWAreaUnearthedViewController alloc] init];
        vc.controllerType = ZWAreaAbsorptiveController;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11113) {
        //区域可疑工地
        ZWSuspiciousViewController *vc = [[ZWSuspiciousViewController alloc] init];
        vc.controllerType = rSuspiciousViewControllerWorkSite;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11114) {
        //区域可疑消纳点
        ZWSuspiciousViewController *vc = [[ZWSuspiciousViewController alloc] init];
        vc.controllerType = rSuspiciousViewControllerTypeAbsorptive;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11115) {
        //区域未密闭率
        ZWAreaViolationRankViewController *vc = [[ZWAreaViolationRankViewController alloc] init];
        vc.controllerType = ZWAreaViolationRankViewControllerUnClosenessRate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11116) {
        //区域超速率
        ZWAreaViolationRankViewController *vc = [[ZWAreaViolationRankViewController alloc] init];
        vc.controllerType = ZWAreaViolationRankViewControllerOverspeedRate;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11121) {
        //出土量最多企业
        ZWCompanyBaseDataRankViewController *vc = [[ZWCompanyBaseDataRankViewController alloc] init];
        vc.controllerType = ZWCompanyBaseDataRankViewControllerUnearthedMost;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11122) {
        //出土量最少企业
        ZWCompanyBaseDataRankViewController *vc = [[ZWCompanyBaseDataRankViewController alloc] init];
        vc.controllerType = ZWCompanyBaseDataRankViewControllerUnearthedLess;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([item[@"Url"]  integerValue] == 11123) {
        //未密闭率最高企业
        ZWCompanyViolationUnClosenessViewController *vc = [[ZWCompanyViolationUnClosenessViewController alloc] init];
        vc.controllerType = ZWCompanyViolationUnClosenessViewControllerUnClosenessRateMost;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11124) {
        //未密闭率最低企业
        ZWCompanyViolationUnClosenessViewController *vc = [[ZWCompanyViolationUnClosenessViewController alloc] init];
        vc.controllerType = ZWCompanyBaseDataRankViewControllerUnClosenessRateLess;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11125) {
        //超速率最高企业
        ZWCompanyViolationOverspeedViewController *vc = [[ZWCompanyViolationOverspeedViewController alloc] init];
        vc.controllerType = ZWCompanyViolationOverspeedViewControllerMost;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11126) {
        //超速率低高企业
        ZWCompanyViolationOverspeedViewController *vc = [[ZWCompanyViolationOverspeedViewController alloc] init];
        vc.controllerType = ZWCompanyViolationOverspeedViewControllerless;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([item[@"Url"]  integerValue] == 11131) {
        //出土量最多工地
        ZWBuildingUnearthedViewController *vc = [[ZWBuildingUnearthedViewController alloc] init];
        vc.controllerType = ZWBuildingUnearthedViewControllerMost;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11132) {
        //出土量最少工地
        ZWBuildingUnearthedViewController *vc = [[ZWBuildingUnearthedViewController alloc] init];
        vc.controllerType = ZWBuildingUnearthedViewControllerLess;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11133) {
        //提前工地
        ZWBuildingAheadOfUnearthedViewController *vc = [[ZWBuildingAheadOfUnearthedViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11134) {
        //工地出土情况
        ZWBuildingUnearthedConditionViewController *vc = [[ZWBuildingUnearthedConditionViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11135) {
        //黑工地数
        ZWBuildingBlackStatisticalReportsViewController *vc = [[ZWBuildingBlackStatisticalReportsViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([item[@"Url"]  integerValue] == 11141) {
        //消纳量最多消纳点
        ZWAbsorptiveViewController *vc = [[ZWAbsorptiveViewController alloc] init];
        vc.controllerType = ZWAbsorptiveViewControllerMost;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11142) {
        //消纳量最少消纳点
        ZWAbsorptiveViewController *vc = [[ZWAbsorptiveViewController alloc] init];
        vc.controllerType = ZWAbsorptiveViewControllerless;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([item[@"Url"]  integerValue] == 11151) {
        //上线时长最高车辆
        ZWCarOnlineViewController *vc = [[ZWCarOnlineViewController alloc] init];
        vc.controllerType = ZWCarOnlineViewControllerHightest;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11152) {
        //上线时长最低车辆
        ZWCarOnlineViewController *vc = [[ZWCarOnlineViewController alloc] init];
        vc.controllerType = ZWCarOnlineViewControllerLowest;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([item[@"Url"]  integerValue] == 11153) {
        //未密闭时长最高车辆
        ZWCarUnClosenessViewController *vc = [[ZWCarUnClosenessViewController alloc] init];
        vc.controllerType = ZWCarUnClosenessViewControllerMost;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11154) {
        //未密闭时长最低车辆
        ZWCarUnClosenessViewController *vc = [[ZWCarUnClosenessViewController alloc] init];
        vc.controllerType = ZWCarUnClosenessViewControllerLess;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue] == 11155) {
        //超速时长最高车辆
        ZWCarOverspeedViewController *vc = [[ZWCarOverspeedViewController alloc] init];
        vc.controllerType = ZWCarOverspeedViewControllerMost;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue]  == 11156) {
        //超速时长最低车辆
        ZWCarOverspeedViewController *vc = [[ZWCarOverspeedViewController alloc] init];
        vc.controllerType = ZWCarOverspeedViewControllerLess;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue]  == 11157) {
        //超载时长最高车辆
        ZWCarOverloadViewController *vc = [[ZWCarOverloadViewController alloc] init];
        vc.controllerType = ZWCarOverloadViewControllerMost;
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue]  == 11158) {
        //超载时长最低车辆
        ZWCarOverloadViewController *vc = [[ZWCarOverloadViewController alloc] init];
        vc.controllerType = ZWCarOverloadViewControllerLess;
        [self.navigationController pushViewController:vc animated:YES];
    }
    
    if ([item[@"Url"]  integerValue]  == 11159) {
        //已装设备车辆统计
        ZWCarInstallDeviceViewController *vc = [[ZWCarInstallDeviceViewController alloc]init];
        [self.navigationController pushViewController:vc animated:YES];
    }
    if ([item[@"Url"]  integerValue]  == 11161) {
        //专题监控区域
        ZWKeyMonitoringViewController *vc = [[ZWKeyMonitoringViewController alloc] init];
        [self.navigationController pushViewController:vc animated:YES];
    }
}

#pragma mark - lazy
- (ZWStatisticalReportsCardView *)cardView{
    if (!_cardView) {
        _cardView = [[ZWStatisticalReportsCardView alloc] init];
        _cardView.layer.cornerRadius = 5;
        _cardView.layer.shadowColor = [UIColor blackColor].CGColor;
        _cardView.layer.shadowOffset = CGSizeMake(0, 0);
        _cardView.layer.shadowOpacity = .2;
        _cardView.delegate = self;
        _cardView.hidden = YES;
    }
    return _cardView;
}

- (ZWStatisticalReportsItemsView *)itemsView{
    if (!_itemsView) {
        _itemsView = [[ZWStatisticalReportsItemsView alloc] init];
        _itemsView.delegate = self;
        
        _itemsView.Menus = self.dataArray;
    }
    return _itemsView;
}


- (ZWStatisticalReportsCommonView *)commonView{
    if (!_commonView) {
        _commonView = [[ZWStatisticalReportsCommonView alloc] init];
        _commonView.delegate = self;
    }
    return _commonView;
}

- (ZWStatisticalReportsItemsListView *)itemsListView{
    if (!_itemsListView) {
        _itemsListView = [[ZWStatisticalReportsItemsListView alloc] init];
        _itemsListView.backgroundColor = [UIColor whiteColor];
        _itemsListView.alpha = 0;
        _itemsListView.delegate = self;
        _itemsListView.Menus = self.dataArray;
    }
    return _itemsListView;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        _collectionView.alpha = 0;
        [_collectionView registerClass:[ZWStatisticalReportsCell class] forCellWithReuseIdentifier:NSStringFromClass([ZWStatisticalReportsCell class])];
        [_collectionView registerClass:[ZWStatisticalReportsReusableHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ZWStatisticalReportsReusableHeader class])];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(kScreenWidth/3, kWidth(160));
        _layout.minimumLineSpacing = 0;
        _layout.minimumInteritemSpacing = 0;
        _layout.headerReferenceSize = CGSizeMake(0, 44);
    }
    return _layout;
}

- (NSArray *)dataSource{
    if (!_dataSource) {
        NSString *fileName = [kDocPath stringByAppendingPathComponent:@"filter.plist"];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:fileName];
        
            _dataSource = dataArray;
        if (dataArray.count != 0) {
            _dataSource = dataArray;
        }

    }
    return _dataSource;
}

- (NSArray *)sectionHeaderTitles{
    if (!_sectionHeaderTitles) {
        NSString *fileName = [kDocPath stringByAppendingPathComponent:@"filterSection.plist"];
        NSArray *dataArray = [NSArray arrayWithContentsOfFile:fileName];
        _sectionHeaderTitles = dataArray;
    }
    return _sectionHeaderTitles;
}
- (void)setDataArray:(NSArray *)dataArray
{
    _dataArray = dataArray;
    [rTools filterStatisticalSectionMeumWithSource:dataArray];
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
