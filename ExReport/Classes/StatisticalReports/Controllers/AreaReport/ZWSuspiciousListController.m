//
//  ZWSuspiciousListController.m
//  Muck
//
//  Created by 张威 on 2018/8/8.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWSuspiciousListController.h"
#import "ZWStatisticalTableHeaderView.h"
#import "ZWStatisticalBarChartTableViewCell.h"
#import "ZWSuspiciousSectionHeaderView.h"
#import "ZWSuspiciousTableViewCell.h"
#import "CJCalendarViewController.h"
#import "ZWSusUnearthedDetailModel.h"
#import "ZWSusUnearthedDetailRankModel.h"
#import "ZWCarInstallDeveiceSituationViewController.h"
#import "ZWInAdvanceSiteDayModel.h"
#import "ZWInadvanceSiteRegionModel.h"
#import "ZWBlackSiteStaticDayModel.h"
#import "ZWBlackSiteRegionModel.h"
#import "ZWSelectedTimeView.h"

@interface ZWSuspiciousListController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    CalendarViewControllerDelegate
>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)ZWAlarmStatues *statues;//假数据
@property (strong, nonatomic)ZWSelectedTimeView *selectedTimeView;
@property (strong, nonatomic)ZWStatisticalTableHeaderView *headerView;
@property (strong, nonatomic)CJCalendarViewController *startCalendar;
@property (strong, nonatomic)CJCalendarViewController *endCalendar;
@property (strong, nonatomic)NSMutableArray *dayArray;
@property (strong, nonatomic)NSMutableArray *UnLoadCountArray;
@property (strong, nonatomic)NSMutableArray *dataArray;

@end

@implementation ZWSuspiciousListController

#pragma mark - 生命控制器函数
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = COLORWITHHEX(kColor_FFFFFF);
    self.headerView = [[ZWStatisticalTableHeaderView alloc] init];
    self.tableView.tableHeaderView = self.headerView;
    self.statues = [[ZWAlarmStatues alloc] init];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (self.controllerType == rSuspiciousViewControllerWorkSite) {
        self.headerView.controllerType = rSuspiciousViewControllerWorkSite;
        [self loadSusUnearthedData];//区域可疑工地
    }else if(self.controllerType == rSuspiciousViewControllerTypeAbsorptive){
        self.headerView.controllerType = rSuspiciousViewControllerTypeAbsorptive;//区域可疑消纳点
        [self loadSusConsumptiveData];
    }else if(self.controllerType == rSuspiciousViewControllerTypeAheadUnearth){//提前出土工地
        self.headerView.controllerType = rSuspiciousViewControllerTypeAheadUnearth;
        [self loadAheadUnearthData];

    }else if (self.controllerType == rSuspiciousViewControllerTypeBlackSite){//黑土地
        self.headerView.controllerType = rSuspiciousViewControllerTypeBlackSite;
        [self loadBlackSiteData];
    }else{
    }
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, ExNavigationHeight+kWidth(100)+kWidth(88), kScreenWidth, kScreenHeight-(ExNavigationHeight+kWidth(100)+kWidth(88)));
}

#pragma mark - method
- (void)updateType{
    if (self.controllerType == rSuspiciousViewControllerWorkSite) {
        self.headerView.controllerType = rSuspiciousViewControllerWorkSite;
        [self loadSusUnearthedData];//区域可疑工地
    }else if(self.controllerType == rSuspiciousViewControllerTypeAbsorptive){
        self.headerView.controllerType = rSuspiciousViewControllerTypeAbsorptive;//区域可疑消纳点
        [self loadSusConsumptiveData];
    }else if(self.controllerType == rSuspiciousViewControllerTypeAheadUnearth){//提前出土工地
        self.headerView.controllerType = rSuspiciousViewControllerTypeAheadUnearth;
        [self loadAheadUnearthData];

    }else if (self.controllerType == rSuspiciousViewControllerTypeBlackSite){//黑土地
        self.headerView.controllerType = rSuspiciousViewControllerTypeBlackSite;
        [self loadBlackSiteData];
    }else{

    }
}

- (void)selectTimeViewShow{
    [self.selectedTimeView show];
}



#pragma mark - 网络加载

//区域可疑工地
- (void)loadSusUnearthedData{
    //Type:* 时间类型 1=昨日 2=今日 3=本周 4=本月 5=时间段 6=上周
    NSDictionary *params = [NSDictionary dictionary];
    if ([self.dateType.type integerValue] == 5) {
        params = @{
                   @"Type":self.dateType.type,
                   @"DepartmentName":self.DepartmentName,
                   @"Code":self.Code,
                   @"BeginDate":self.dateType.beginDate,
                   @"EndDate":self.dateType.endDate
                   };
    }else{
        params = @{
                   @"Type":self.dateType.type,
                   @"DepartmentName":self.DepartmentName,
                   @"Code":self.Code,
                   };
    }
    [ExProgressHUD showProgress:@"加载中" inView:self.view];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetRegionSusUnearthed parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSDictionary class]]) {
                NSArray *susUnearthedDetailArray = responseObject[@"Data"][@"SusUnearthedDetailModel"];
                NSMutableArray *temp = [NSMutableArray array];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dict in susUnearthedDetailArray) {
                    ZWSusUnearthedDetailModel *model = [ZWSusUnearthedDetailModel mj_objectWithKeyValues:dict];
                    [temp addObject:model.Day];
                    [tempArray addObject:model.UnLoadCount];
                }
                [self.dayArray removeAllObjects];
                [self.dayArray addObjectsFromArray:temp.copy];
                
                [self.UnLoadCountArray removeAllObjects];
                [self.UnLoadCountArray addObjectsFromArray:tempArray.copy];
                self.headerView.numCount = [NSString stringWithFormat:@"%@",responseObject[@"Data"][@"TotalCount"]];
                self.headerView.timeInterval = [NSString stringWithFormat:@"%@ - %@",[self.dayArray firstObject],[self.dayArray lastObject]];
                self.statues.legendName = @"个数";
                self.statues.xArray = self.dayArray;
                self.statues.yValueArray = self.UnLoadCountArray;
     
                long maxValue = 0.0;
                long minValue = 100000000.0;
                for (NSString *valueString in self.UnLoadCountArray) {
                    double value = [valueString doubleValue];
                    if (value >maxValue) {
                        maxValue = value;
                    }
                    if (value < minValue) {
                        minValue = value;
                    }
                }
                NSInteger max = (int)maxValue;
                self.statues.valueRange = CGPointMake(0, max);
           
                NSArray *susUnearthedDetailRankArray = responseObject[@"Data"][@"SusUnearthedDetailRankModel"];
                NSMutableArray *tempM = [NSMutableArray array];
                for (NSDictionary *dic in susUnearthedDetailRankArray) {
                    ZWSusUnearthedDetailRankModel *model = [ZWSusUnearthedDetailRankModel mj_objectWithKeyValues:dic];
                    [tempM addObject:model];
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempM.copy];
                [self.tableView reloadData];
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//区域可疑消纳点
- (void)loadSusConsumptiveData{
    NSDictionary *params = [NSDictionary dictionary];
    if ([self.dateType.type integerValue] == 5) {
        params = @{
                   @"Type":self.dateType.type,
                   @"DepartmentName":self.DepartmentName,
                   @"Code":self.Code,
                   @"BeginDate":self.dateType.beginDate,
                   @"EndDate":self.dateType.endDate
                   };
    }else{
        params = @{
                   @"Type":self.dateType.type,
                   @"DepartmentName":self.DepartmentName,
                   @"Code":self.Code,
                   };
    }
    [ExProgressHUD showProgress:@"加载中" inView:self.view];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetRegionSusConsumptive parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSDictionary class]]) {
                NSArray *susUnearthedDetailArray = responseObject[@"Data"][@"SusUnearthedDetailModel"];
                NSMutableArray *temp = [NSMutableArray array];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dict in susUnearthedDetailArray) {
                    ZWSusUnearthedDetailModel *model = [ZWSusUnearthedDetailModel mj_objectWithKeyValues:dict];
                    [temp addObject:model.Day];
                    [tempArray addObject:model.UnLoadCount];
                }
                [self.dayArray removeAllObjects];
                [self.dayArray addObjectsFromArray:temp.copy];
                
                [self.UnLoadCountArray removeAllObjects];
                [self.UnLoadCountArray addObjectsFromArray:tempArray.copy];
                self.headerView.numCount = [NSString stringWithFormat:@"%@",responseObject[@"Data"][@"TotalCount"]];
                self.headerView.timeInterval = [NSString stringWithFormat:@"%@ - %@",[self.dayArray firstObject],[self.dayArray lastObject]];

                self.statues.legendName = @"个数";
                self.statues.xArray = self.dayArray;
                self.statues.yValueArray = self.UnLoadCountArray;
                
                long maxValue = 0.0;
                long minValue = 100000000.0;
                for (NSString *valueString in self.UnLoadCountArray) {
                    double value = [valueString doubleValue];
                    if (value >maxValue) {
                        maxValue = value;
                    }
                    if (value < minValue) {
                        minValue = value;
                    }
                }
                NSInteger max = (int)maxValue;
                self.statues.valueRange = CGPointMake(0, max);
                
                NSArray *susUnearthedDetailRankArray = responseObject[@"Data"][@"SusUnearthedDetailRankModel"];
                NSMutableArray *tempM = [NSMutableArray array];
                for (NSDictionary *dic in susUnearthedDetailRankArray) {
                    ZWSusUnearthedDetailRankModel *model = [ZWSusUnearthedDetailRankModel mj_objectWithKeyValues:dic];
                    [tempM addObject:model];
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempM.copy];
                [self.tableView reloadData];
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

//提前出土工地
- (void)loadAheadUnearthData{
    NSDictionary *params = [NSDictionary dictionary];
    if ([self.dateType.type integerValue] == 5) {
        params = @{
                   @"Type":self.dateType.type,
                   @"BeginDate":self.dateType.beginDate,
                   @"EndDate":self.dateType.endDate,
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName
                   };
    }else{
        params = @{
                   @"Type":self.dateType.type,
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName
                   };
    }
        [ExProgressHUD showProgress:@"加载中" inView:self.view];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetInAdvanceSite parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSDictionary class]]) {
                NSArray *inAdvanceSiteDayModelArray = responseObject[@"Data"][@"InAdvanceSiteDayModel"];
                NSMutableArray *temp = [NSMutableArray array];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dict in inAdvanceSiteDayModelArray) {
                    ZWInAdvanceSiteDayModel *model = [ZWInAdvanceSiteDayModel mj_objectWithKeyValues:dict];
                    [temp addObject:model.Day];
                    [tempArray addObject:model.SiteCount];
                }
                [self.dayArray removeAllObjects];
                [self.dayArray addObjectsFromArray:temp.copy];
                [self.UnLoadCountArray removeAllObjects];
                [self.UnLoadCountArray addObjectsFromArray:tempArray.copy];
                self.headerView.numCount = [NSString stringWithFormat:@"%@",responseObject[@"Data"][@"TotalCount"]];
                 self.headerView.timeInterval = [NSString stringWithFormat:@"%@ - %@",[self.dayArray firstObject],[self.dayArray lastObject]];
                self.statues.legendName = @"个数";
                self.statues.xArray = self.dayArray;
                self.statues.yValueArray = self.UnLoadCountArray;
                
                long maxValue = 0.0;
                long minValue = 100000000.0;
                for (NSString *valueString in self.UnLoadCountArray) {
                    double value = [valueString doubleValue];
                    if (value >maxValue) {
                        maxValue = value;
                    }
                    if (value < minValue) {
                        minValue = value;
                    }
                }
                NSInteger max = (int)maxValue;
                self.statues.valueRange = CGPointMake(0, max);

                NSArray *inadvanceSiteRegionModelArray = responseObject[@"Data"][@"InadvanceSiteRegionModel"];
                NSMutableArray *tempM = [NSMutableArray array];
                for (NSDictionary *dic in inadvanceSiteRegionModelArray) {
                    ZWInadvanceSiteRegionModel *model = [ZWInadvanceSiteRegionModel mj_objectWithKeyValues:dic];
                    [tempM addObject:model];
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempM.copy];
                [self.tableView reloadData];
            }
        }else{
                [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
    
}

//黑工地数目
- (void)loadBlackSiteData{
//    NSDictionary *params = @{
//                             @"Type":self.dateType.type,
//                             @"BeginDate":self.dateType.beginDate,
//                             @"EndDate":self.dateType.endDate,
//                             @"DepartmentId":self.DepartmentId,
//                             @"DepartmentName":self.DepartmentName,
//                             @"Code":self.Code
//                             };
    NSDictionary *params = [NSDictionary dictionary];
    if ([self.dateType.type integerValue] == 5) {
        params = @{
                   @"Type":self.dateType.type,
                   @"BeginDate":self.dateType.beginDate,
                   @"EndDate":self.dateType.endDate,
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName,
                   @"Code":self.Code
                   };
    }else{
        params = @{
                   @"Type":self.dateType.type,
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName,
                   @"Code":self.Code
                   };
    }

    [ExProgressHUD showProgress:@"加载中" inView:self.view];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetBlackSiteStatic parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSDictionary class]]) {
                NSArray *blackSiteStaticDayModelArray = responseObject[@"Data"][@"BlackSiteStaticDayModel"];
                NSMutableArray *temp = [NSMutableArray array];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dict in blackSiteStaticDayModelArray) {
                    ZWBlackSiteStaticDayModel *model = [ZWBlackSiteStaticDayModel mj_objectWithKeyValues:dict];
                    [temp addObject:model.Day];
                    [tempArray addObject:model.TotalCount];
                }
                [self.dayArray removeAllObjects];
                [self.dayArray addObjectsFromArray:temp.copy];
                
                [self.UnLoadCountArray removeAllObjects];
                [self.UnLoadCountArray addObjectsFromArray:tempArray.copy];
                
                self.headerView.numCount = [NSString stringWithFormat:@"%@",responseObject[@"Data"][@"TotalCount"]];
                self.headerView.timeInterval = [NSString stringWithFormat:@"%@ - %@",[self.dayArray firstObject],[self.dayArray lastObject]];
                self.statues.legendName = @"黑土地个数";
                self.statues.xArray = self.dayArray;
                self.statues.yValueArray = self.UnLoadCountArray;
                
                long maxValue = 0.0;
                long minValue = 100000000.0;
                for (NSString *valueString in self.UnLoadCountArray) {
                    double value = [valueString doubleValue];
                    if (value >maxValue) {
                        maxValue = value;
                    }
                    if (value < minValue) {
                        minValue = value;
                    }
                }
                NSInteger max = (int)maxValue;
                self.statues.valueRange = CGPointMake(0, max);
                
                NSArray *blackSiteRegionModelArray = responseObject[@"Data"][@"BlackSiteRegionModel"];
                NSMutableArray *tempM = [NSMutableArray array];
                for (NSDictionary *dic in blackSiteRegionModelArray) {
                    ZWBlackSiteRegionModel *model = [ZWBlackSiteRegionModel mj_objectWithKeyValues:dic];
                    [tempM addObject:model];
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempM.copy];
                [self.tableView reloadData];
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];

}

#pragma mark - UITableViewDelegate,UITableViewDataSource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 1;
    }
    return self.dataArray.count;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ZWStatisticalBarChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWStatisticalBarChartTableViewCell class])];
        if (!cell) {
            cell = [[ZWStatisticalBarChartTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([ZWStatisticalBarChartTableViewCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.statues = self.statues;
        return cell;
    }
    ZWSuspiciousTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWSuspiciousTableViewCell class])];
    if (!cell) {
        cell = [[ZWSuspiciousTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([ZWSuspiciousTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    if (self.controllerType == rSuspiciousViewControllerWorkSite || self.controllerType == rSuspiciousViewControllerTypeAbsorptive) {
         cell.model = self.dataArray[indexPath.row];
    }else if( self.controllerType == rSuspiciousViewControllerTypeAheadUnearth){
        cell.regionModel = self.dataArray[indexPath.row];
    }else if (self.controllerType == rSuspiciousViewControllerTypeBlackSite){
        cell.blackModel = self.dataArray[indexPath.row];
    }else{
        
    }

    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 250;
    }
    return kWidth(140);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZWSuspiciousSectionHeaderView *header = [[ZWSuspiciousSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    if (section == 0) {
        if (self.controllerType == rSuspiciousViewControllerWorkSite) {
            header.title = [NSString stringWithFormat:@"%@ - %@可疑工地",[self.dayArray firstObject],[self.dayArray lastObject]];
        }else if(self.controllerType == rSuspiciousViewControllerTypeAbsorptive){
            header.title = [NSString stringWithFormat:@"%@ - %@可疑消纳点",[self.dayArray firstObject],[self.dayArray lastObject]];
        }else if(self.controllerType == rSuspiciousViewControllerTypeAheadUnearth){
               header.title = [NSString stringWithFormat:@"%@ - %@提前出土工地(个)",[self.dayArray firstObject],[self.dayArray lastObject]];
        }else if(self.controllerType == rSuspiciousViewControllerTypeBlackSite){
                header.title = [NSString stringWithFormat:@"%@ - %@黑土地(个)",[self.dayArray firstObject],[self.dayArray lastObject]];
        }else{
            
        }
    } else {
        if (self.controllerType == rSuspiciousViewControllerWorkSite) {
            header.title = [NSString stringWithFormat:@"%@可疑工地",self.DepartmentName];
        }else if(self.controllerType == rSuspiciousViewControllerTypeAbsorptive){
            header.title = [NSString stringWithFormat:@"%@可疑消纳点",self.DepartmentName];
        }else if(self.controllerType == rSuspiciousViewControllerTypeAheadUnearth){
            header.title = [NSString stringWithFormat:@"%@提前出土工地对比(个)",self.DepartmentName];
        }else if(self.controllerType == rSuspiciousViewControllerTypeBlackSite){
              header.title = [NSString stringWithFormat:@"%@黑土地数(个)",self.DepartmentName];
        }else{
            
        }
        
    }
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
#pragma mark - 懒加载
- (NSMutableArray *)dayArray{
    if (!_dayArray) {
        _dayArray = [NSMutableArray array];
    }
    return _dayArray;
}


- (NSMutableArray *)UnLoadCountArray{
    if (!_UnLoadCountArray) {
        _UnLoadCountArray = [NSMutableArray array];
    }
    return _UnLoadCountArray;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (ZWSelectedTimeView *)selectedTimeView{
    MJWeakSelf
    if (!_selectedTimeView) {
        _selectedTimeView = [[ZWSelectedTimeView alloc]initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kWidth(264))];
        _selectedTimeView.tipString = @"自定义时间";
        _selectedTimeView.didSelectAction = ^(NSInteger index) {
            [weakSelf jumpCalendarViewControllerWithIndex:index];
        };
        _selectedTimeView.confirmAction = ^{
            [weakSelf updateType];
        };
        [self.navigationController.view addSubview:_selectedTimeView];
    }
    return _selectedTimeView;
}

- (void)jumpCalendarViewControllerWithIndex:(NSInteger )index{
    if (index == 0) {
        self.startCalendar = [[CJCalendarViewController alloc]init];
        self.startCalendar.contentBackgroundColor = COLORWITHHEX(kColor_FB5E52);
        self.startCalendar.headerBackgroundColor = COLORWITHHEX(kColor_FB5E52);
        self.startCalendar.view.frame = self.view.frame;// 显示底层controller
        self.startCalendar.delegate = self;
        [self presentViewController: self.startCalendar animated:YES completion:nil];
    }else{
        self.endCalendar = [[CJCalendarViewController alloc]init];
        self.endCalendar.contentBackgroundColor = COLORWITHHEX(kColor_FB5E52);
        self.endCalendar.headerBackgroundColor = COLORWITHHEX(kColor_FB5E52);
        self.endCalendar.view.frame = self.view.frame;// 显示底层controller
        self.endCalendar.delegate = self;
        [self presentViewController:self.endCalendar animated:YES completion:nil];
    }
}

#pragma mark - CalendarViewControllerDelegate
-(void) CalendarViewController:(CJCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
    NSString *selectedTime = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
    if (controller == self.startCalendar) {
        self.selectedTimeView.startTime = selectedTime;
        self.dateType.beginDate = [NSString stringWithFormat:@"%@-%@-%@ 07:00:00",year,month,day];

    }else{
        self.selectedTimeView.endTime = selectedTime;
        self.dateType.endDate = [NSString stringWithFormat:@"%@-%@-%@ 07:00:00" ,year,month,day];
    }
    
    [self.selectedTimeView.tableView reloadData];
}


- (void)dealloc{

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
