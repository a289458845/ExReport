//
//  ZWCarInstallDeviceOtherListViewController.m
//  Muck
//
//  Created by 张威 on 2018/8/31.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarInstallDeviceOtherListViewController.h"
#import "ZWAlarmStatues.h"
#import "ZWStatisticalBarChartTableViewCell.h"
#import "ZWCarInstallDeviceOtherListCell.h"
#import "ZWdayDataModel.h"
#import "ZWChildDataModel.h"
#import "ZWSuspiciousSectionHeaderView.h"
#import "ZWCarInstallDeveiceSituationViewController.h"
#import "CJCalendarViewController.h"
#import "ZWSelectedTimeView.h"

@interface ZWCarInstallDeviceOtherListViewController ()<UITableViewDelegate,UITableViewDataSource,CalendarViewControllerDelegate>
@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) ZWAlarmStatues *statues;//假数据
@property (strong, nonatomic)ZWSelectedTimeView *selectedTimeView;
@property (strong, nonatomic)NSMutableArray *dayArray;
@property (strong, nonatomic)NSMutableArray *deviceCountArray;
@property (strong, nonatomic)NSMutableArray *dataArray;

@property (strong, nonatomic)CJCalendarViewController *startCalendar;
@property (strong, nonatomic)CJCalendarViewController *endCalendar;

@end

@implementation ZWCarInstallDeviceOtherListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.statues = [[ZWAlarmStatues alloc] init];
    
//    self.statues.xArray = @[@"8.1",@"8.2",@"8.3",@"8.4",@"8.5",@"8.6",@"8.7",@"8.8",@"8.9",@"8.10",@"8.11",@"8.12",@"8.13"];
//    self.statues.yValueArray = @[@"12",@"35",@"21",@"59",@"37",@"0",@"23",@"46",@"33",@"1",@"19",@"51",@"42"];
//    self.statues.valueRange = CGPointMake(0, 60);
//    self.statues.legendName = @"个数";
    

}


- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self loadData];
}

- (void)updateType{
    [self loadData];
    
}
- (void)selectTimeViewShow{
    [self.selectedTimeView show];
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

- (void)loadData{
    NSDictionary *params = @{
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
                NSMutableArray *tempM = [NSMutableArray array];
                for (NSDictionary *dic in childDataArray) {
                    ZWChildDataModel *model = [ZWChildDataModel mj_objectWithKeyValues:dic];
                    [tempM addObject:model];
            
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempM];

                [self.tableView reloadData];
                
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, ExNavigationHeight+kWidth(100)+kWidth(88), kScreenWidth, kScreenHeight-(ExNavigationHeight+kWidth(100)+kWidth(88)));
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
    ZWCarInstallDeviceOtherListCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWCarInstallDeviceOtherListCell class])];
    if (!cell) {
        cell = [[ZWCarInstallDeviceOtherListCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([ZWCarInstallDeviceOtherListCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataArray[indexPath.row];
    
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 250;
    }
    return kWidth(140);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWidth(88);
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

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWCarInstallDeveiceSituationViewController *vc = [[ZWCarInstallDeveiceSituationViewController alloc]init];
    ZWChildDataModel *model = self.dataArray[indexPath.row];
    vc.BeginDate = self.dateType.beginDate;
    vc.EndDate = self.dateType.endDate;
    vc.DepartmentId = model.Id;
    vc.DepartmentName = model.Name;
    [self.navigationController pushViewController:vc animated:YES];
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
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
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
