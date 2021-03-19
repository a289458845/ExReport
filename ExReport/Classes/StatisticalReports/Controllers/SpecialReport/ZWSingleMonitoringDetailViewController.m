//
//  ZWSingleMonitoringDetailViewController.m
//  Muck
//
//  Created by 张威 on 2018/8/22.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWSingleMonitoringDetailViewController.h"
#import "ZWCompanyStatisticalReportsTableViewCell.h"
#import "ZWCompanyStatisticalReportsSectionHeaderView.h"
#import "ZWKeyMonitoringHeaderView.h"
#import "ZWSingleMonitoringModel.h"
#import "ZWSelectedTimeView.h"
#import "CJCalendarViewController.h"

static NSInteger pageSize = 10;
@interface ZWSingleMonitoringDetailViewController ()
<UITableViewDataSource,
UITableViewDelegate,
CalendarViewControllerDelegate>

@property (strong, nonatomic)ZWKeyMonitoringHeaderView *headerView;
@property (strong, nonatomic)UITableView *tableView;
@property (nonatomic,strong)UIImageView *noDataImg;
@property (nonatomic,strong)UILabel *noDataLab;
@property (nonatomic,strong)UIButton *noDataBtn;
@property (strong, nonatomic)ZWSelectedTimeView *selectedTimeView;

@property(assign, nonatomic)NSInteger Type;
@property (copy, nonatomic)NSString *BeginDate;
@property (copy, nonatomic)NSString *EndDate;
@property(assign, nonatomic)NSInteger pageIndex;
@property (strong, nonatomic)CJCalendarViewController *startCalendar;
@property (strong, nonatomic)CJCalendarViewController *endCalendar;

@property (strong, nonatomic)NSMutableArray *dataArray;

@end

@implementation ZWSingleMonitoringDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationTitleWithTitle:self.model.Name];
    self.Type = 2;
    
    [self loadTimeData];
    
    [self loadNewData];
    
    MJWeakSelf
    self.headerView = [[ZWKeyMonitoringHeaderView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(450))];
    self.headerView.didSelectTimeBlock = ^{
        weakSelf.Type = 5;
        [weakSelf.selectedTimeView show];
    };
    self.tableView.tableHeaderView = self.headerView;
    
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, ExNavigationHeight, kScreenWidth, kScreenHeight-ExNavigationHeight);
}

- (void)loadTimeData{
    NSDictionary *params = @{
                             @"Type":@(self.Type)
                             };
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetTypeTime parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            NSString *BeginDate = responseObject[@"Data"][@"BeginDate"];
            self.BeginDate = [BeginDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            NSString *EndDate = responseObject[@"Data"][@"EndDate"];
            self.EndDate = [EndDate stringByReplacingOccurrencesOfString:@"T" withString:@" "];
            self.headerView.timeString = [NSString stringWithFormat:@"%@ - %@",self.BeginDate,self.EndDate];
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

-(void)loadNewData{
    self.pageIndex = 1;
    NSDictionary *params = [NSDictionary dictionary];
    if (self.Type == 5) {
        params = @{
                   @"Type":@(self.Type),
                   @"BeginDate":self.BeginDate,
                   @"EndDate":self.EndDate,
                   @"PageSize":@(pageSize),
                   @"PageIndex":@(self.pageIndex),
                   @"CloudMapId":self.model.Id,
                   };
    }else{
        params = @{
                   @"Type":@(self.Type),
                   @"PageSize":@(pageSize),
                   @"PageIndex":@(self.pageIndex),
                   @"CloudMapId":self.model.Id,
                   };
    }
    [ExProgressHUD showProgress:@"加载中"];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetVehicleFenceTrips parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSDictionary class]]) {
             self.headerView.inOutNum =  [NSString stringWithFormat:@"%@",responseObject[@"Data"][@"Total"]];
                if ([responseObject[@"Data"][@"Details"] isKindOfClass:[NSArray class]]) {
                    NSMutableArray *temp =[NSMutableArray array];
                    
                    for (NSDictionary *dict in responseObject[@"Data"][@"Details"]) {
                        ZWSingleMonitoringModel *model = [ZWSingleMonitoringModel mj_objectWithKeyValues:dict];
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
             
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
            [self.tableView.mj_header endRefreshing];
    }];
}

-(void)loadMoewData{
    self.pageIndex++;
    NSDictionary *params = [NSDictionary dictionary];
    if (self.Type == 5) {
        params = @{
                   @"Type":@(self.Type),
                   @"BeginDate":self.BeginDate,
                   @"EndDate":self.EndDate,
                   @"PageSize":@(pageSize),
                   @"PageIndex":@(self.pageIndex),
                   @"CloudMapId":self.model.Id,
                   };
    }else{
        params = @{
                   @"Type":@(self.Type),
                   @"PageSize":@(pageSize),
                   @"PageIndex":@(self.pageIndex),
                   @"CloudMapId":self.model.Id,
                   };
    }
    [ExProgressHUD showProgress:@"加载中"];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetVehicleFenceTrips parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSDictionary class]]) {
                self.headerView.inOutNum =  [NSString stringWithFormat:@"%@",responseObject[@"Data"][@"Total"]];
                if ([responseObject[@"Data"][@"Details"] isKindOfClass:[NSArray class]]) {
                    NSArray *resultArray = responseObject[@"Data"][@"Details"];
                    NSMutableArray *temp =[NSMutableArray array];
                    
                    for (NSDictionary *dict in resultArray) {
                        ZWSingleMonitoringModel *model = [ZWSingleMonitoringModel mj_objectWithKeyValues:dict];
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
                
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
                    [self.tableView.mj_footer endRefreshing];
    }];
}


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWCompanyStatisticalReportsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWCompanyStatisticalReportsTableViewCell class])];
    if (!cell) {
        cell = [[ZWCompanyStatisticalReportsTableViewCell alloc] initWithType:ZWCompanyStatisticalReportsTableViewCellUnearthed reuseIdentifier:NSStringFromClass([ZWCompanyStatisticalReportsTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.rank = indexPath.row+1;
    cell.singleMonitoringModel = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(88);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWidth(88);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZWCompanyStatisticalReportsSectionHeaderView *header =
    [[ZWCompanyStatisticalReportsSectionHeaderView alloc] init];
    header.contentStr = @"进入次数";
    header.typeStr = @"车牌号";
    header.titleStr = @"企业";
    return header;
}

#pragma mark - CalendarViewControllerDelegate
-(void) CalendarViewController:(CJCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day{
    NSString *selectedTime = [NSString stringWithFormat:@"%@年%@月%@日",year,month,day];
    
    if (controller == self.startCalendar) {
        self.selectedTimeView.startTime = selectedTime;
        self.BeginDate = [NSString stringWithFormat:@"%@-%@-%@ 07:00:00",year,month,day];
    }else{
        self.selectedTimeView.endTime = selectedTime;
        self.EndDate = [NSString stringWithFormat:@"%@-%@-%@ 07:00:00" ,year,month,day];
    }
    
    [self.selectedTimeView.tableView reloadData];
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


- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
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


- (UIImageView *)noDataImg{
    if (!_noDataImg) {
        _noDataImg = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"searchcar_nodata_tips"]];
        [self.view addSubview:_noDataImg];
        [_noDataImg mas_makeConstraints:^(MASConstraintMaker *make) {
            make.centerX.mas_equalTo(self.view);
            make.bottom.equalTo(self.noDataLab.mas_top).offset(-kWidth(10));
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
            make.bottom.equalTo(self.noDataBtn.mas_top).offset(-kWidth(30));
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
            make.bottom.equalTo(self.view).offset(-kWidth(30));
            make.size.mas_equalTo(CGSizeMake(kWidth(180), kWidth(60)));
        }];
        
    }
    return _noDataBtn;
}
- (void)noDataBtnClick:(UIButton *)sender{
    [self loadNewData];
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
