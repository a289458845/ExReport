//
//  ZWCarInstallDeviceListViewController.m
//  Muck
//
//  Created by 张威 on 2018/8/16.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarInstallDeviceListViewController.h"
#import "ZWStatisticalTableHeaderView.h"
#import "ZWStatisticalBarChartTableViewCell.h"
#import "ZWSuspiciousSectionHeaderView.h"
#import "ZWBuildingHorizontalBarChartCell.h"
#import "ZWCompanyBasicDetailInfoSectionHeaderView.h"
#import "ZWCarInstallDeveiceSituationViewController.h"
#import "ZWdayDataModel.h"
#import "ZWChildDataModel.h"
#import "CJCalendarViewController.h"
#import "ZWSelectedTimeView.h"

@interface ZWCarInstallDeviceListViewController ()<UITableViewDelegate,UITableViewDataSource,CalendarViewControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (strong, nonatomic)ZWSelectedTimeView *selectedTimeView;
@property (nonatomic, strong) ZWAlarmStatues *statues;//假数据
@property (nonatomic, strong) ZWAlarmStatues *statues1;//假数据
@property (nonatomic, strong) NSMutableArray *dayArray;
@property (nonatomic, strong) NSMutableArray *deviceCountArray;
@property (nonatomic, strong) NSMutableArray *regionNameArray;
@property (nonatomic, strong) NSMutableArray *regionSiteCountArray;


@property (strong, nonatomic)CJCalendarViewController *startCalendar;
@property (strong, nonatomic)CJCalendarViewController *endCalendar;
@end

@implementation ZWCarInstallDeviceListViewController

#pragma mark - 生命控制函数
- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.statues = [[ZWAlarmStatues alloc] init];//竖直条形图
    self.statues1 = [[ZWAlarmStatues alloc] init];//水平条形图
    
//    self.statues.xArray = @[@"8.1",@"8.2",@"8.3",@"8.4",@"8.5",@"8.6",@"8.7",@"8.8",@"8.9",@"8.10",@"8.11",@"8.12",@"8.13"];
//    self.statues.yValueArray = @[@"12",@"35",@"21",@"59",@"37",@"0",@"23",@"46",@"33",@"1",@"19",@"51",@"42"];
//    self.statues.valueRange = CGPointMake(0, 60);
//    self.statues.legendName = @"个数";
    

//    self.statues1.xArray = @[@"蔡甸区",@"东湖高新区",@"东西湖区",@"汉南区",@"汉阳区",@"洪山区",@"江夏区",@"黄陂区",@"江岸区",@"江汉区",@"硚口区",@"青山区",@"武昌区",@"武汉开发区",@"新洲区",@"东湖风景区"];
//    self.statues1.yValueArray = @[@"15",@"35",@"21",@"60",@"37",@"0",@"23",@"46",@"33",@"1",@"19",@"51",@"42",@"21",@"18",@"50"];
//    self.statues1.valueRange = CGPointMake(0, 60);
//    self.statues1.legendName = @"个数";

}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

#pragma mark - lazy
- (void)updateType{
    [self loadData];
}

- (void)selectTimeViewShow{
    [self.selectedTimeView show];
}


- (void)loadData{
    NSDictionary *params  = @{
                              @"BeginDate":self.dateType.beginDate,
                              @"EndDate":self.dateType.endDate,
                              @"DepartmentId":self.DepartmentId,
                              @"DepartmentName":self.DepartmentName,
                              @"IsPermission":@(2) //控制数据权限
                              };
    [ExProgressHUD showProgress:@"加载中" inView:self.view];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetInstallVehicle parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSDictionary class]]) {
                NSArray *dayDataArray = responseObject[@"Data"][@"dayData"];
                NSMutableArray *temp = [NSMutableArray array];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dict in dayDataArray) {
                    ZWdayDataModel *model = [ZWdayDataModel mj_objectWithKeyValues:dict];
                    [temp addObject:model.DayTime];
                    [tempArray addObject:model.oneDayVhesCount];
                }
                [self.dayArray removeAllObjects];
                [self.dayArray addObjectsFromArray:temp.copy];
                [self.deviceCountArray removeAllObjects];
                [self.deviceCountArray addObjectsFromArray:tempArray.copy];
                
                self.statues.legendName = @"台";
                self.statues.xArray = self.dayArray;
                self.statues.yValueArray = self.deviceCountArray;
                long maxValue = 0.0;
                long minValue = 100000000.0;
                for (NSString *valueString in self.deviceCountArray) {
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
                
                NSArray *childDataArray = responseObject[@"Data"][@"ChildData"];
                NSMutableArray *regionTemp = [NSMutableArray array];
                NSMutableArray *countTemp = [NSMutableArray array];
                for (NSDictionary *dic in childDataArray) {
                    ZWChildDataModel *model = [ZWChildDataModel mj_objectWithKeyValues:dic];
                    [regionTemp addObject:model.Name];
                    [countTemp addObject:model.VehCount];
                }

                [self.regionNameArray removeAllObjects];
                [self.regionNameArray addObjectsFromArray:regionTemp.copy];
                [self.regionSiteCountArray removeAllObjects];
                [self.regionSiteCountArray addObjectsFromArray:countTemp.copy];

                 self.statues1.xArray = self.regionNameArray;
                 self.statues1.yValueArray = self.regionSiteCountArray;
                long maxValue1 = 0.0;
                long minValue1 = 100000000.0;
                for (NSString *valueString in self.regionSiteCountArray) {
                    double value = [valueString doubleValue];
                    if (value >maxValue1) {
                        maxValue1 = value;
                    }
                    if (value < minValue1) {
                        minValue1 = value;
                    }
                }
                NSInteger max1 = (int)maxValue1;
                self.statues1.valueRange = CGPointMake(0, max1);
                self.statues1.legendNameArray = @[@"台"];
                [self.tableView reloadData];
                
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    self.tableView.frame = CGRectMake(0, ExNavigationHeight+kWidth(100)+kWidth(88), kScreenWidth, kScreenHeight-(ExNavigationHeight+kWidth(100)+kWidth(88)));
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
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

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZWSuspiciousSectionHeaderView *header = [[ZWSuspiciousSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    if(section == 0){
        header.title = [NSString stringWithFormat:@"%@已装设备台数(台)",self.DepartmentName];
    }else{
        header.title = [NSString stringWithFormat:@"%@已装设备企业列表",self.DepartmentName];
    }
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return .1;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    return [UIView new];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWCarInstallDeveiceSituationViewController *vc = [[ZWCarInstallDeveiceSituationViewController alloc]init];
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - 懒加载
- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
            [self.view addSubview:_tableView];
    }
    return _tableView;
}

- (NSMutableArray *)dayArray{
    if (!_dayArray) {
        _dayArray = [NSMutableArray array];
    }
    return _dayArray;
}
- (NSMutableArray *)deviceCountArray{
    if (!_deviceCountArray) {
        _deviceCountArray = [NSMutableArray array];
    }
    return _deviceCountArray;
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
