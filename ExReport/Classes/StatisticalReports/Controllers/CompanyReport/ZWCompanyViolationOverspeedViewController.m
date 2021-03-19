//
//  ZWCompanyViolationOverspeedViewController.m
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCompanyViolationOverspeedViewController.h"
#import "ZWDayHeaderView.h"
//#import "ZWCompanyBasicInfoViewController.h"
#import "ZWCompanyStatisticalReportsSectionHeaderView.h"
#import "ZWCompanyStatisticalReportsTableViewCell.h"
#import "ZWCompanyViolationStatisticalDetailCell.h"
#import "ExSelectAreaViewController.h"
#import "ZWAreaViolationRankModel.h"
#import "CJCalendarViewController.h"
#import "ZWRegionModel.h"
#import "ZWSelectedTimeView.h"

static NSInteger pageSize = 10;
@interface ZWCompanyViolationOverspeedViewController ()
<UITableViewDelegate,
UITableViewDataSource,
ZWCompanyStatisticalReportsTableViewCellDelegate,
ZWDayHeaderViewDelegate,
ExelectAreaViewControllerDelegate,
CalendarViewControllerDelegate
>

@property (strong, nonatomic) ZWDayHeaderView *dayView;
@property (strong, nonatomic)UIButton *rightButton;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) ZWSelectedTimeView *selectedTimeView;
@property (nonatomic, strong) NSMutableArray *dataSource;//假数据

@property (nonatomic) BOOL detailFlag;
@property (nonatomic, strong) NSIndexPath *detailIndexPath;

@property(assign, nonatomic)NSInteger OrderBy;
@property(assign, nonatomic)NSInteger Type;
@property (copy, nonatomic)NSString *DepartmentId;
@property (copy, nonatomic)NSString *DepartmentName;
@property (copy, nonatomic)NSString *BeginDate;
@property (copy, nonatomic)NSString *EndDate;
@property(strong, nonatomic)NSArray *AlarmType;
@property (strong, nonatomic)CJCalendarViewController *startCalendar;
@property (strong, nonatomic)CJCalendarViewController *endCalendar;
@property(assign, nonatomic)NSInteger PageIndex;
@end

@implementation ZWCompanyViolationOverspeedViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[].mutableCopy;
        self.AlarmType = @[@"1",@"106"];
    if (self.controllerType == ZWCompanyViolationOverspeedViewControllerMost) {
        [self setupNavigationTitleWithTitle:@"超速率最高企业"];
    } else {
        [self setupNavigationTitleWithTitle:@"超速率最低企业"];
    }

    self.Type = 2;
    [self loadDate];
    
    NSString *path = [kDocPath stringByAppendingPathComponent:@"region.data"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    ZWRegionModel *model = [array firstObject];
    self.DepartmentName = model.Name;
    self.DepartmentId = model.Id;
    

    [self setupNavBar];

    MJWeakSelf
    self.dayView = [[ZWDayHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(160))];
    self.dayView.type = ZWDayWeekMonth;
    self.dayView.didSelectTimeBlock = ^{
        weakSelf.Type = 5;
        [weakSelf.selectedTimeView show];
    };
    self.dayView.delegate = self;
    self.tableView.tableHeaderView = self.dayView;
}

- (void)loadDate{
    NSDictionary *params = @{
                             @"Type":@(self.Type)
                             };
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetTypeTime parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            NSString *BeginDate = responseObject[@"Data"][@"BeginDate"];
            self.BeginDate = [BeginDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            NSString *EndDate = responseObject[@"Data"][@"EndDate"];
            self.EndDate = [EndDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            self.dayView.timeString = [NSString stringWithFormat:@"%@ - %@",self.BeginDate,self.EndDate];
            
            if (self.controllerType == ZWCompanyViolationOverspeedViewControllerMost) {
                self.OrderBy = 1;
            } else {
                self.OrderBy = 2;
            }
            
            [self loadData];
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


- (void)loadData{
    NSDictionary *params = [NSDictionary dictionary];
    if (self.Type == 5) {
        params = @{
                   @"Type":@(self.Type),
                   @"BeginDate":self.BeginDate,
                   @"EndDate":self.EndDate,
                   @"AlarmType":self.AlarmType,
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName,
                   @"OrderBy":@(self.OrderBy)
                   };
    }else{
        params = @{
                   @"Type":@(self.Type),
                   @"AlarmType":self.AlarmType,
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName,
                   @"OrderBy":@(self.OrderBy)

                   };
    }
    [ExProgressHUD showProgress:@"加载中" inView:self.view];;
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetEnterpriseAlarm parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
           [ExProgressHUD hide];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dict in responseObject[@"Data"]) {
                ZWAreaViolationRankModel *model = [ZWAreaViolationRankModel mj_objectWithKeyValues:dict];
                [tempArray addObject:model];
            }
            [self.dataSource removeAllObjects];
            [self.dataSource addObjectsFromArray:tempArray.copy];
            [self.tableView reloadData];
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)loadMoreData{
    self.PageIndex++;
    NSDictionary *params = [NSDictionary dictionary];
    if (self.Type == 5) {
        params = @{
                   @"Type":@(self.Type),
                   @"BeginDate":self.BeginDate,
                   @"EndDate":self.EndDate,
                   @"AlarmType":self.AlarmType,
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName,
                   @"OrderBy":@(self.OrderBy),
                   @"PageSize":@(pageSize),
                   @"PageIndex":@(self.PageIndex)
                   };
    }else{
        params = @{
                   @"Type":@(self.Type),
                   @"AlarmType":self.AlarmType,
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName,
                   @"OrderBy":@(self.OrderBy),
                   @"PageSize":@(pageSize),
                   @"PageIndex":@(self.PageIndex)
                   };
    }
    [ExProgressHUD showProgress:@"加载中" inView:self.view];;
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetEnterpriseAlarm parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            NSMutableArray *tempArray = [NSMutableArray array];
            if ([responseObject[@"Data"] isKindOfClass:[NSArray class]]) {
                NSArray *resultArray = responseObject[@"Data"];
                for (NSDictionary *dict in responseObject[@"Data"]) {
                    ZWAreaViolationRankModel *model = [ZWAreaViolationRankModel mj_objectWithKeyValues:dict];
                    [tempArray addObject:model];
                }
                if (resultArray.count == 0) {
                    [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.dataSource addObjectsFromArray:tempArray.copy];
                    [self.tableView reloadData];
                    [self.tableView.mj_footer endRefreshing];
                }
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
                 [self.tableView.mj_footer endRefreshing];
    }];
}

- (void)setupNavBar{
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationController.navigationBar setNeedsLayout];
    UIView *rightContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 94, 44)];
    self.rightButton = [[UIButton alloc] initWithFrame:rightContentView.bounds];
    [self.rightButton setImage:[UIImage imageNamed:@"yijianchawei_dingwei"] forState:UIControlStateNormal];
    self.rightButton .titleLabel.font = kSystemFont(30);
    [self.rightButton  setTitle:self.DepartmentName forState:UIControlStateNormal];
    [self.rightButton  setTitleColor:COLORWITHHEX(kColor_3A3D44) forState:UIControlStateNormal];
    [self.rightButton  addTarget:self action:@selector(rightItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightContentView addSubview:self.rightButton ];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightContentView];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)rightItemBtnClick:(UIBarButtonItem *)item{
    ExSelectAreaViewController *areaVc = [[ExSelectAreaViewController alloc]init];
    areaVc.delegate = self;
    [self.navigationController pushViewController:areaVc animated:YES];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, ExNavigationHeight, kScreenWidth, kScreenHeight-ExNavigationHeight);
}

#pragma mark -ExelectAreaViewControllerDelegate
- (void)selectAreaViewControllerDelegateItemClick:(ZWRegionModel *)model{
    if (model == nil) {
        return;
    }
    self.DepartmentName = model.Name;
    self.DepartmentId = model.Id;
    [self.rightButton setTitle:self.DepartmentName forState:UIControlStateNormal];
    [self loadData];
}

#pragma mark - ZWCompanyStatisticalReportsTableViewCellDelegate
- (void)companyStatisticalReportsTableViewCellDidSelectCompany:(ZWCompanyStatisticalReportsTableViewCell *)cell{
//    ZWCompanyBasicInfoViewController *vc = [[ZWCompanyBasicInfoViewController alloc]init];
//    [self.navigationController pushViewController:vc animated:YES];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWAreaViolationRankModel *rankModel = self.dataSource[indexPath.row];
    if (self.detailFlag && self.detailIndexPath.row == indexPath.row) {
        ZWCompanyViolationStatisticalDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWCompanyViolationStatisticalDetailCell class])];
        if (!cell) {
            cell = [[ZWCompanyViolationStatisticalDetailCell alloc] initWithType:ZWCompanyViolationStatisticalDetailCellUnCloseness reuseIdentifier:NSStringFromClass([ZWCompanyViolationStatisticalDetailCell class])];
            cell.type = ZWCompanyViolationStatisticalDetailCellUnCloseness;
        }
        cell.rankModel = rankModel;
        return cell;
    } else {
        if (self.controllerType == ZWCompanyViolationOverspeedViewControllerMost) {
            ZWCompanyStatisticalReportsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWCompanyStatisticalReportsTableViewCell class])];
            if (!cell) {
                cell = [[ZWCompanyStatisticalReportsTableViewCell alloc] initWithType:ZWCompanyStatisticalReportsTableViewCellUnCloseness reuseIdentifier:NSStringFromClass([ZWCompanyStatisticalReportsTableViewCell class])];
                cell.delegate = self;
            }
            cell.rankModel = rankModel;
            cell.rank = indexPath.row+1;
            return cell;
        }else{
            ZWCompanyStatisticalReportsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWCompanyStatisticalReportsTableViewCell class])];
            if (!cell) {
                cell = [[ZWCompanyStatisticalReportsTableViewCell alloc] initWithType:ZWCompanyStatisticalReportsTableViewCellUnearthed reuseIdentifier:NSStringFromClass([ZWCompanyStatisticalReportsTableViewCell class])];
                cell.delegate = self;
            }
            cell.rankModel = rankModel;
            cell.rank = indexPath.row+1;
            return cell;
        }

    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[ZWCompanyStatisticalReportsTableViewCell class]]) {
        ZWAreaViolationRankModel *rankModel = self.dataSource[indexPath.row];
        if (self.detailFlag) {
            //删除以前插入的cell
            [self.dataSource removeObjectAtIndex:self.detailIndexPath.row];
            [tableView deleteRowsAtIndexPaths:@[self.detailIndexPath] withRowAnimation:UITableViewRowAnimationTop];
            
            if (self.detailIndexPath.row - 1 == indexPath.row) {
                self.detailFlag = NO;
                return;
            }
            
            //修改数据源插入一个cell
            if (self.detailIndexPath.row < indexPath.row) {
                self.detailIndexPath = indexPath;
            } else {
                self.detailIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
            }
            [self.dataSource insertObject:rankModel atIndex:self.detailIndexPath.row];
            [tableView insertRowsAtIndexPaths:@[self.detailIndexPath] withRowAnimation:UITableViewRowAnimationTop];
        } else {
            //修改数据源插入一个cell
            self.detailFlag = YES;
            [self.dataSource insertObject:rankModel atIndex:indexPath.row+1];
            NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
            self.detailIndexPath = insertIndexPath;
            [tableView insertRowsAtIndexPaths:@[insertIndexPath] withRowAnimation:UITableViewRowAnimationTop];
        }
    }else {
        if (self.detailFlag) {
            //删除以前插入的cell
            [self.dataSource removeObjectAtIndex:self.detailIndexPath.row];
            [tableView deleteRowsAtIndexPaths:@[self.detailIndexPath] withRowAnimation:UITableViewRowAnimationTop];
            self.detailFlag = NO;
        }
    }
    
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.detailFlag && self.detailIndexPath.row == indexPath.row) {
        return UITableViewAutomaticDimension;
    } else {
        return kWidth(88);
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kWidth(88);
}
- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZWCompanyStatisticalReportsSectionHeaderView *header = [[ZWCompanyStatisticalReportsSectionHeaderView alloc] init];
    header.contentStr = @"超速率(超速时长/里程)";
    return header;
}



- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
            
            [weakSelf loadData];
        };
        [self.view addSubview:_selectedTimeView];
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
        self.BeginDate = [NSString stringWithFormat:@"%@-%@-%@ 07:00:00",year,month,day];
    }else{
        self.selectedTimeView.endTime = selectedTime;
        self.EndDate = [NSString stringWithFormat:@"%@-%@-%@ 07:00:00",year,month,day];
    }
    
    self.dayView.timeString = [NSString stringWithFormat:@"%@ - %@",self.BeginDate,self.EndDate];
    [self.selectedTimeView.tableView reloadData];
}

#pragma mark - ZWDayHeaderViewDelegate
- (void)dayHeaderViewSelectedIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            self.Type = 2;
            [self loadDate];
            break;
        }
        case 1:{
            self.Type = 3;
            [self loadDate];

            break;
        }
        case 2:{
            self.Type = 4;
            [self loadDate];

            break;
        }
        default:
            break;
    }
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
