//
//  ZWBuildingAheadOfUnearthedListController.m
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWBuildingAheadOfUnearthedListController.h"
#import "ZWStatisticalTableHeaderView.h"
#import "ZWStatisticalBarChartTableViewCell.h"
#import "ZWSuspiciousSectionHeaderView.h"
#import "ZWBuildingHorizontalBarChartCell.h"
#import "ZWInAdvanceSiteDayModel.h"
#import "ZWInadvanceSiteRegionModel.h"
#import "CJCalendarViewController.h"
#import "ZWSelectedTimeView.h"
@interface ZWBuildingAheadOfUnearthedListController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    CalendarViewControllerDelegate
>

@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic)ZWSelectedTimeView *selectedTimeView;
@property (strong, nonatomic)ZWStatisticalTableHeaderView *headerView;
@property (nonatomic, strong) ZWAlarmStatues *statues;//假数据
@property (nonatomic, strong) ZWAlarmStatues *statues1;//假数据
@property (strong, nonatomic)NSMutableArray *dayArray;
@property (strong, nonatomic)NSMutableArray *SiteCountArray;

@property (strong, nonatomic)NSMutableArray *regionNameArray;
@property (strong, nonatomic)NSMutableArray *regionSiteCountArray;

@property (strong, nonatomic)CJCalendarViewController *startCalendar;
@property (strong, nonatomic)CJCalendarViewController *endCalendar;

@end

@implementation ZWBuildingAheadOfUnearthedListController

#pragma mark - 生命控制函数
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    self.headerView = [[ZWStatisticalTableHeaderView alloc] init];
    self.tableView.tableHeaderView = self.headerView;
    
    self.statues = [[ZWAlarmStatues alloc] init];

    self.statues1 = [[ZWAlarmStatues alloc] init];

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, ExNavigationHeight+kWidth(100)+kWidth(88), kScreenWidth, kScreenHeight-(ExNavigationHeight+kWidth(100)+kWidth(88)));
}

#pragma mark - method
- (void)updateType{
    [self loadData];
}

- (void)selectTimeViewShow{
      [self.selectedTimeView show];
}



#pragma mark -网络加载
- (void)loadData{
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
                [self.SiteCountArray removeAllObjects];
                [self.SiteCountArray addObjectsFromArray:tempArray.copy];
                self.headerView.numCount = [NSString stringWithFormat:@"%@",responseObject[@"Data"][@"TotalCount"]];
                self.headerView.timeInterval = [NSString stringWithFormat:@"%@ - %@",[self.dayArray firstObject],[self.dayArray lastObject]];
                self.statues.legendName = @"个数";
                self.statues.xArray = self.dayArray;
                self.statues.yValueArray = self.SiteCountArray;
                
                long maxValue = 0.0;
                long minValue = 100000000.0;
                for (NSString *valueString in self.SiteCountArray) {
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
                NSMutableArray *regionTemp = [NSMutableArray array];
                 NSMutableArray *countTemp = [NSMutableArray array];
                for (NSDictionary *dic in inadvanceSiteRegionModelArray) {
                    ZWInadvanceSiteRegionModel *model = [ZWInadvanceSiteRegionModel mj_objectWithKeyValues:dic];
                    [regionTemp addObject:model.RegionName];
                    [countTemp addObject:model.SiteCount];
                }
                [self.regionNameArray removeAllObjects];
                [self.regionNameArray addObjectsFromArray:regionTemp.copy];
                [self.regionSiteCountArray removeAllObjects];
                [self.regionSiteCountArray addObjectsFromArray:countTemp.copy];
                
                
                self.statues1.legendName = @"个数";
                self.statues1.xArray = self.regionNameArray;
                self.statues1.yValueArray = self.regionSiteCountArray;
                self.statues1.valueRange = CGPointMake(0, 50);


                [self.tableView reloadData];
    
                
            }
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ZWStatisticalBarChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWStatisticalBarChartTableViewCell class])];
        if (!cell) {
            cell = [[ZWStatisticalBarChartTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([ZWStatisticalBarChartTableViewCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.statues = self.statues;
        return cell;
    }
    ZWBuildingHorizontalBarChartCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWBuildingHorizontalBarChartCell class])];
    if (!cell) {
        cell = [[ZWBuildingHorizontalBarChartCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([ZWBuildingHorizontalBarChartCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.statues = self.statues1;
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 250;
    }
    return UITableViewAutomaticDimension;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZWSuspiciousSectionHeaderView *header = [[ZWSuspiciousSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    if (section == 0) {
        header.title = @"最近七天提前出土工地(个)";
    } else {
        header.title = @"各区提前出土工地对比";
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return .1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

#pragma mark - 懒加载
- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
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

- (NSMutableArray *)dayArray{
    if (!_dayArray) {
        _dayArray = [NSMutableArray array];
    }
    return _dayArray;
}
- (NSMutableArray *)SiteCountArray{
    if (!_SiteCountArray) {
        _SiteCountArray = [NSMutableArray array];
    }
    return _SiteCountArray;
}

- (NSMutableArray *)regionNameArray{
    if (!_regionNameArray) {
        _regionNameArray = [NSMutableArray array];
    }
    return _regionNameArray;
}
- (NSMutableArray *)regionSiteCountArray{
    if (!_regionSiteCountArray) {
        _regionSiteCountArray = [NSMutableArray array];
    }
    return _regionSiteCountArray;
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


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
