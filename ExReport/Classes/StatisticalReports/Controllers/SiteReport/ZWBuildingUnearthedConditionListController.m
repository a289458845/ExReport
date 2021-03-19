//
//  ZWBuildingUnearthedConditionListController.m
//  Muck
//
//  Created by 张威 on 2018/8/13.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWBuildingUnearthedConditionListController.h"
#import "ZWBuildingFanChartTableViewCell.h"
#import "ZWSuspiciousSectionHeaderView.h"
#import "ZWSuspiciousTableViewCell.h"
#import "ZWSiteStaticModel.h"
#import "CJCalendarViewController.h"
#import "ZWSelectedTimeView.h"
@interface ZWBuildingUnearthedConditionListController ()
<
UITableViewDelegate,
UITableViewDataSource,
CalendarViewControllerDelegate
>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *data;//饼状图数据字典
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (strong, nonatomic)NSMutableArray *UnearthedCountArray;//实际出土数组
@property (strong, nonatomic)NSMutableArray *UpLoadSiteCountArray;//上报出土数组
@property (strong, nonatomic)ZWSelectedTimeView *selectedTimeView;
@property (copy, nonatomic)NSString *BeginDate;
@property (copy, nonatomic)NSString *EndDate;
@property (strong, nonatomic)CJCalendarViewController *startCalendar;
@property (strong, nonatomic)CJCalendarViewController *endCalendar;


@end

@implementation ZWBuildingUnearthedConditionListController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];

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
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetSiteStatic parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSDictionary class]]) {
                NSString *TotalUnearthed = responseObject[@"Data"][@"TotalUnearthed"];
                NSString *TotalUpLoadSite = responseObject[@"Data"][@"TotalUpLoadSite"];
                NSMutableDictionary *data = @{}.mutableCopy;
                [data setObject:TotalUnearthed forKey:@"实际出土工地"];
                [data setObject:TotalUpLoadSite forKey:@"上报工地"];
                self.data = data.copy;
                if ([responseObject[@"Data"][@"SiteStaticModel"] isKindOfClass:[NSArray class]]) {
                    NSMutableArray *temp = [NSMutableArray array];
                    for (NSDictionary *dict in responseObject[@"Data"][@"SiteStaticModel"]) {
                        ZWSiteStaticModel *model = [ZWSiteStaticModel mj_objectWithKeyValues:dict];
                        [temp addObject:model];
                    }
                    [self.dataArray removeAllObjects];
                    [self.dataArray addObjectsFromArray:temp.copy];
                    [self.tableView reloadData];
                }
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

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        ZWBuildingFanChartTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWBuildingFanChartTableViewCell class])];
        if (!cell) {
            cell = [[ZWBuildingFanChartTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([ZWBuildingFanChartTableViewCell class])];
            cell.selectionStyle = UITableViewCellSelectionStyleNone;
        }
        cell.data = self.data;
        return cell;
    }
    ZWSuspiciousTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWSuspiciousTableViewCell class])];
    if (!cell) {
        cell = [[ZWSuspiciousTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([ZWSuspiciousTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.siteStaticModel = self.dataArray[indexPath.row];
    return cell;
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section == 0 && indexPath.row == 0) {
        return 250;
    }
    return kWidth(140);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZWSuspiciousSectionHeaderView *header = [[ZWSuspiciousSectionHeaderView alloc] initWithFrame:CGRectMake(0, 0, 0, 30)];
    if (section == 0) {
        header.title = [NSString stringWithFormat:@"%@工地出土情况",self.DepartmentName];
    } else {
        header.title = [NSString stringWithFormat:@"%@出土工地列表",self.DepartmentName];
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

- (NSMutableArray *)UnearthedCountArray{
    if (!_UnearthedCountArray) {
        _UnearthedCountArray = [NSMutableArray array];
    }
    return _UnearthedCountArray;
}


- (NSMutableArray *)UpLoadSiteCountArray{
    if (!_UpLoadSiteCountArray) {
        _UpLoadSiteCountArray = [NSMutableArray array];
    }
    return _UpLoadSiteCountArray;
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



/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
