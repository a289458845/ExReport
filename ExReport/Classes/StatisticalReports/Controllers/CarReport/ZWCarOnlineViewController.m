//
//  ZWCarOnlineViewController.m
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarOnlineViewController.h"
#import "ZWDayHeaderView.h"
#import "ZWCarStatisticalReportsSectionHeaderView.h"
#import "ZWCarStatisticalReportsTableViewCell.h"
#import "CJCalendarViewController.h"
#import "ExSelectAreaViewController.h"
#import "ZWSelectedTimeView.h"
#import "ZWRegionModel.h"
#import "ZWCarOnlineModel.h"

static NSInteger pageSize = 10;
@interface ZWCarOnlineViewController ()
<UITableViewDelegate,
UITableViewDataSource,
ZWDayHeaderViewDelegate,
ExelectAreaViewControllerDelegate,
CalendarViewControllerDelegate>

@property (strong, nonatomic) ZWDayHeaderView *dayView;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIButton *rightButton;
@property (nonatomic,strong)UIImageView *noDataImg;
@property (nonatomic,strong)UILabel *noDataLab;
@property (nonatomic,strong)UIButton *noDataBtn;
@property(assign, nonatomic)NSInteger OrderBy;
@property(assign, nonatomic)NSInteger Type;
@property (copy, nonatomic)NSString *DepartmentId;
@property (copy, nonatomic)NSString *DepartmentName;
@property (copy, nonatomic)NSString *BeginDate;
@property (copy, nonatomic)NSString *EndDate;


@property (strong, nonatomic)ZWSelectedTimeView *selectedTimeView;
@property (strong, nonatomic)CJCalendarViewController *startCalendar;
@property (strong, nonatomic)CJCalendarViewController *endCalendar;
@property (strong, nonatomic)NSMutableArray *dataArray;


@property(assign, nonatomic) NSInteger PageIndex;


@end

@implementation ZWCarOnlineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    if (self.controllerType == ZWCarOnlineViewControllerHightest) {
        [self setupNavigationTitleWithTitle:@"上线时长最高车辆"];
    } else if (self.controllerType == ZWCarOnlineViewControllerLowest) {
        [self setupNavigationTitleWithTitle:@"上线时长最低车辆"];
    }

    self.Type = 3;
    [self loadDate];
    NSString *path = [kDocPath stringByAppendingPathComponent:@"region.data"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    ZWRegionModel *model = [array firstObject];
    self.DepartmentName = model.Name;
    self.DepartmentId = model.Id;

    [self setupNavBar];

    
    MJWeakSelf
    self.dayView = [[ZWDayHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(160))];
    self.dayView.type = ZWWeekMonth;
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
            
            if (self.controllerType == ZWCarOnlineViewControllerHightest) {
                self.OrderBy = 1;
                [self loadNewData];
            } else if (self.controllerType == ZWCarOnlineViewControllerLowest) {
                self.OrderBy = 2;
                [self loadNewData];
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)loadNewData{
    self.PageIndex = 1;
    NSDictionary *params = [NSDictionary dictionary];
    if (self.Type == 5) {
        params = @{
                   @"Type":@(self.Type),
                   @"BeginDate":self.BeginDate,
                   @"EndDate":self.EndDate,
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName,
                   @"OrderBy":@(self.OrderBy),
                   @"PageSize":@(pageSize),
                   @"PageIndex":@(self.PageIndex)
                   };
    }else{
        params = @{
                   @"Type":@(self.Type),
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName,
                   @"OrderBy":@(self.OrderBy),
                   @"PageSize":@(pageSize),
                   @"PageIndex":@(self.PageIndex)
                   };
    }
    [ExProgressHUD showProgress:@"加载中" inView:self.view];;
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetVehicleOnLine parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue ] == 0) {
           [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSArray class]]) {
                NSMutableArray *temp = [NSMutableArray array];
                for (NSDictionary *dict in responseObject[@"Data"]) {
                    ZWCarOnlineModel *model = [ZWCarOnlineModel mj_objectWithKeyValues:dict];
                    [temp addObject:model];
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:temp.copy];
                [self.tableView reloadData];
                [self.tableView.mj_header endRefreshing];
                if (self.dataArray.count == 0) {
                    self.noDataImg.hidden = NO;
                    self.noDataLab.hidden = NO;
                    self.noDataBtn.hidden = NO;
                }else{
                    self.noDataImg.hidden = YES;
                    self.noDataLab.hidden = YES;
                    self.noDataBtn.hidden = YES;
                }
            }
        }else{
              [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
         [self.tableView.mj_header endRefreshing];
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
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName,
                   @"OrderBy":@(self.OrderBy),
                   @"PageSize":@(pageSize),
                   @"PageIndex":@(self.PageIndex)
                   };
    }else{
        params = @{
                   @"Type":@(self.Type),
                   @"DepartmentId":self.DepartmentId,
                   @"DepartmentName":self.DepartmentName,
                   @"OrderBy":@(self.OrderBy),
                   @"PageSize":@(pageSize),
                   @"PageIndex":@(self.PageIndex)
                   };
    }
    [ExProgressHUD showProgress:@"加载中" inView:self.view];;
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetVehicleOnLine parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue ] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSArray class]]) {
                NSArray *resultArray = responseObject[@"Data"];
                NSMutableArray *temp = [NSMutableArray array];
                for (NSDictionary *dict in resultArray) {
                    ZWCarOnlineModel *model = [ZWCarOnlineModel mj_objectWithKeyValues:dict];
                    [temp addObject:model];
                }
                if (resultArray.count == 0) {
                     [self.tableView.mj_footer endRefreshingWithNoMoreData];
                }else{
                    [self.dataArray addObjectsFromArray:temp.copy];
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
    [self.rightButton setTitle:self.DepartmentName forState:UIControlStateNormal];
    [self.rightButton setTitleColor:COLORWITHHEX(kColor_3A3D44) forState:UIControlStateNormal];
    [self.rightButton addTarget:self action:@selector(rightItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
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
    [self loadNewData];
}

#pragma mark - UITableViewDelegate,UITableViewDataSource


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWCarStatisticalReportsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWCarStatisticalReportsTableViewCell class])];
    if (!cell) {
        cell = [[ZWCarStatisticalReportsTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([ZWCarStatisticalReportsTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    cell.rank = indexPath.row+1;
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return kWidth(88);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kWidth(88);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZWCarStatisticalReportsSectionHeaderView *header = [[ZWCarStatisticalReportsSectionHeaderView alloc] init];
    return header;
}


- (UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        _tableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingTarget:self refreshingAction:@selector(loadNewData)];
        _tableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingTarget:self refreshingAction:@selector(loadMoreData)];
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
            
            [weakSelf loadNewData];
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
- (UIImageView *)noDataImg{
    if (!_noDataImg) {
        _noDataImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchcar_nodata_tips"]];
        [self.view addSubview:_noDataImg];
        [_noDataImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.center.mas_equalTo(self.view);
        }];
        
    }
    return _noDataImg;
}
- (UILabel *)noDataLab{
    if (!_noDataLab) {
        _noDataLab = [UILabel LabelWithFont:kSystemFont(28) andColor:COLORWITHHEX(kColor_AFB4C0) andTextAlignment:center andString:@"当前数据为空,请刷新"];
        [self.view addSubview:_noDataLab];
        [_noDataLab mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.equalTo(self.noDataImg.mas_bottom).offset(kWidth(10));
        }];
    }
    return _noDataLab;
}

- (UIButton *)noDataBtn{
    if (!_noDataBtn) {
        _noDataBtn = [[UIButton alloc]init];
        [_noDataBtn setTitle:@"点击刷新" forState:UIControlStateNormal];
        _noDataBtn.layer.backgroundColor = COLORWITHHEX(kColor_3A62AC).CGColor;
        _noDataBtn.layer.cornerRadius = kWidth(6);
        [_noDataBtn addTarget:self action:@selector(noDataBtnClick:) forControlEvents:UIControlEventTouchUpInside];
        _noDataBtn.titleLabel.font = kSystemFont(28);
        _noDataBtn.layer.masksToBounds = YES;
        _noDataBtn.titleLabel.textColor = COLORWITHHEX(kColor_FFFFFF);
        [self.view addSubview:_noDataBtn];
        [_noDataBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.top.equalTo(self.noDataLab.mas_bottom).offset(kWidth(40));
            make.size.mas_equalTo(CGSizeMake(kWidth(180), kWidth(60)));
        }];
        
    }
    return _noDataBtn;
}

- (void)noDataBtnClick:(UIButton *)sender{
    [self loadNewData];
}
#pragma mark - ZWDayHeaderViewDelegate
- (void)dayHeaderViewSelectedIndex:(NSInteger)index{
    switch (index) {
        case 0:{
            self.Type = 3;
            [self loadDate];
            break;
        }
        case 1:{
            self.Type = 4;
            [self loadDate];
            break;
        }
        default:
            break;
    }
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
