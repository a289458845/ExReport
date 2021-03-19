//
//  ZWAreaUnearthedViewController.m
//  Muck
//
//  Created by 张威 on 2018/8/2.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWAreaUnearthedViewController.h"
#import "ZWAreaUnearchedHeaderView.h"
#import "ZWDayWeekMonthView.h"
#import "ZWAreaUnearthedTableSectionHeaderView.h"
#import "ZWCommonTableViewCell.h"
#import "ZWStatuesTool.h"
#import "ZWSelectedTimeView.h"
#import "CJCalendarViewController.h"
#import "ZWUnearthedDetailModel.h"
#import "ZWUnearthedDetailRankModel.h"
#import "ExSelectAreaViewController.h"
#import "rBaseNavigationViewController.h"
#import "ZWRegionModel.h"
//#import "ZWSiteDetailViewController.h"
@interface ZWAreaUnearthedViewController ()
< UITableViewDelegate,
  UITableViewDataSource,
  CalendarViewControllerDelegate,
  ZWDayWeekMonthViewDelegate,
  ExelectAreaViewControllerDelegate,
  ZWCommonTableViewCellDelegate
>

@property (strong, nonatomic) UITableView *tableView;
@property (nonatomic, strong) ZWAreaUnearchedHeaderView *headerView;
@property (nonatomic, strong) ZWDayWeekMonthView *dateView;
@property (nonatomic, strong) ZWAlarmStatues *statues;
@property (strong, nonatomic)ZWSelectedTimeView *selectedTimeView;
@property (nonatomic,strong)UIImageView *noDataImg;
@property (nonatomic,strong)UILabel *noDataLab;
@property (nonatomic,strong)UIButton *noDataBtn;
@property (strong, nonatomic)NSMutableArray *dayArray;
@property (strong, nonatomic)NSMutableArray *unearthedArray;
@property (copy, nonatomic)NSString *BeginDate;
@property (copy, nonatomic)NSString *EndDate;

@property (copy, nonatomic)NSString *beginTime;
@property (copy, nonatomic)NSString *endTime;
@property (strong, nonatomic)NSMutableArray *dataArray;
@property (strong, nonatomic)ZWRegionModel *currentRegionModel;//当前位置

@property(assign, nonatomic)NSInteger Type;
@property (copy, nonatomic)NSString *DepartmentName;
@property (copy, nonatomic)NSString *DepartmentId;
@property (strong, nonatomic)CJCalendarViewController *startCalendar;
@property (strong, nonatomic)CJCalendarViewController *endCalendar;
@property (strong, nonatomic)UIButton *rightButton;

@end

@implementation ZWAreaUnearthedViewController

#pragma mark - life Cycle
- (void)viewDidLoad {
    [super viewDidLoad];
    NSString *path = [kDocPath stringByAppendingPathComponent:@"region.data"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    ZWRegionModel *model = [array firstObject];
    self.DepartmentName = model.Name;
    self.DepartmentId = model.Id;
    self.Type = 2;

    [self loadTimeData];

    [self setupNavBar];
    MJWeakSelf
    self.headerView = [[ZWAreaUnearchedHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(400))];
    self.headerView.didSelectTimeBlock = ^{
        weakSelf.Type = 5;
        [weakSelf.selectedTimeView show];
    };
    self.tableView.tableHeaderView = self.headerView;
    self.statues = [[ZWAlarmStatues alloc] init];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.dateView.frame=  CGRectMake(0, ExNavigationHeight, kScreenWidth, kWidth(100));
    self.tableView.frame = CGRectMake(0, CGRectGetMaxY(self.dateView.frame), kScreenWidth, kScreenHeight-CGRectGetMaxY(self.dateView.frame));

}


#pragma mark - UI以及约束
- (void)setupNavBar{
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationController.navigationBar setNeedsLayout];
    UIView *rightContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 94, 44)];
    self.rightButton = [[UIButton alloc] initWithFrame:rightContentView.bounds];
    [self.rightButton setImage:[UIImage imageNamed:@"yijianchawei_dingwei"] forState:UIControlStateNormal];
    self.rightButton .titleLabel.font = kSystemFont(30);
//    [self.rightButton  setTitle:[kDefaults objectForKey:@"CurrentCity"] forState:UIControlStateNormal];
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

#pragma mark -ExelectAreaViewControllerDelegate
- (void)selectAreaViewControllerDelegateItemClick:(ZWRegionModel *)model{
    if (model == nil) {
        return;
    }
    self.DepartmentName = model.Name;
        self.DepartmentId = model.Id;
    [self.rightButton setTitle:self.DepartmentName forState:UIControlStateNormal];
    if (self.controllerType == ZWAreaUnearthedController) {
        [self loadUnearthedData];
    }else{
        [self loadAbsorptiveData];
    }
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
        self.beginTime = [NSString stringWithFormat:@"%@/%@/%@",year,month,day];
        self.BeginDate = [NSString stringWithFormat:@"%@-%@-%@ 07:00:00",year,month,day];
    }else{
        self.selectedTimeView.endTime = selectedTime;
        self.endTime = [NSString stringWithFormat:@"%@/%@/%@",year,month,day];
        self.EndDate = [NSString stringWithFormat:@"%@-%@-%@ 07:00:00" ,year,month,day];
    }
  
    [self.selectedTimeView.tableView reloadData];
}

#pragma mark - 网络加载
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
            if (self.controllerType == ZWAreaUnearthedController) {
                [self setupNavigationTitleWithTitle:@"区域出土量"];
                [self loadUnearthedData];
            } else {
                [self setupNavigationTitleWithTitle:@"区域消纳量"];
                [self loadAbsorptiveData];
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}


/** 区域出土量 网络加载*/
- (void)loadUnearthedData{
    //Type: 时间类型 1=昨日 2=今日 3=本周 4=本月 5=时间段 6=上周
    NSDictionary *params = [NSDictionary dictionary];
    if (self.Type == 5) {
        params = @{
                   @"Type":@(self.Type),
                   @"DepartmentName":self.DepartmentName,
                    @"DepartmentId":self.DepartmentName,
                   @"BeginDate":self.BeginDate,
                   @"EndDate":self.EndDate
                   };
    }else{
        params = @{
                   @"Type":@(self.Type),
                   @"DepartmentName":self.DepartmentName,
                    @"DepartmentId":self.DepartmentId
                   };
    }
    [ExProgressHUD showProgress:@"加载中" inView:self.view];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetRegionUnearthed parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"][@"UnearthedDetailModel"] isKindOfClass:[NSArray class]]) {
                NSMutableArray *temp = [NSMutableArray array];
                NSMutableArray *tempArray = [NSMutableArray array];
                for (NSDictionary *dic in responseObject[@"Data"][@"UnearthedDetailModel"]) {
                    ZWUnearthedDetailModel *model = [ZWUnearthedDetailModel mj_objectWithKeyValues:dic];
                    [tempArray addObject:model.Unearthed];
                    [temp addObject:[ self getDateStr:model.Day]];
                }
                [self.dayArray removeAllObjects];
                [self.dayArray addObjectsFromArray:temp.copy];
                [self.unearthedArray removeAllObjects];
                [self.unearthedArray addObjectsFromArray:tempArray.copy];
                
                self.headerView.controllerType = ZWAreaUnearthedController;
                self.headerView.timeString  = [NSString stringWithFormat:@"%@ - %@", self.BeginDate,self.EndDate];
                self.headerView.beginTime = self.beginTime;
                self.headerView.endTime = self.endTime;
                self.headerView.timeType = self.Type;
                
                if (self.dayArray && self.dayArray.count) {
                    self.statues.xArray = self.dayArray;
                }
                if (self.unearthedArray && self.unearthedArray.count) {
                    self.statues.yValueArray = self.unearthedArray;
                    CGPoint range = [ZWStatuesTool configureValueRangeWithData:self.statues.yValueArray];
                    self.statues.valueRange = CGPointMake(0, range.y);
                    self.headerView.statues = self.statues;
                }else{
                    self.noDataImg.hidden = NO;
                    self.noDataLab.hidden = NO;
                    self.noDataBtn.hidden = NO;
                    self.tableView.hidden = YES;
                }
            }

            if ([responseObject[@"Data"][@"UnearthedDetailRankModel"] isKindOfClass:[NSArray class]]) {
                NSMutableArray *tempM = [NSMutableArray array];
                for (NSDictionary *dict in responseObject[@"Data"][@"UnearthedDetailRankModel"]) {
                    ZWUnearthedDetailRankModel *model = [ZWUnearthedDetailRankModel mj_objectWithKeyValues:dict];
                    [tempM addObject:model];
                  
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempM.copy];
                [self.tableView reloadData];
                if (self.dataArray.count== 0) {
                    self.noDataImg.hidden = NO;
                    self.noDataLab.hidden = NO;
                    self.noDataBtn.hidden = NO;
                    self.tableView.hidden = YES;
                }else{
                    self.noDataImg.hidden = YES;
                    self.noDataLab.hidden = YES;
                    self.noDataBtn.hidden = YES;
                    self.tableView.hidden = NO;
                }
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}
/** 区域消纳量  网络加载*/
- (void)loadAbsorptiveData{
    // Type:时间类型 1=昨日 2=今日 3=本周 4=本月 5=时间段 6=上周
    NSDictionary *params = [NSDictionary dictionary];
    if (self.Type== 5) {
        params = @{
                   @"Type":@(self.Type),
                   @"DepartmentName":self.DepartmentName,
                   @"DepartmentId":self.DepartmentId,
                   @"BeginDate":self.BeginDate,
                   @"EndDate":self.EndDate
                   };
    }else{
        params = @{
                    @"Type":@(self.Type),
                    @"DepartmentName":self.DepartmentName,
                    @"DepartmentId":self.DepartmentId,
                   };
    };
    [ExProgressHUD showProgress:@"加载中" inView:self.view];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetRegionConsumptive parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            NSArray *UnearthedDetailArray = responseObject[@"Data"][@"UnearthedDetailModel"];
            NSMutableArray *temp = [NSMutableArray array];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dic in UnearthedDetailArray) {
                ZWUnearthedDetailModel *model = [ZWUnearthedDetailModel mj_objectWithKeyValues:dic];
                [tempArray addObject:model.Unearthed];
                [temp addObject:[ self getDateStr:model.Day]];
            }
            [self.dayArray removeAllObjects];
            [self.dayArray addObjectsFromArray:temp.copy];
            [self.unearthedArray removeAllObjects];
            [self.unearthedArray addObjectsFromArray:tempArray.copy];
            
            self.headerView.controllerType = ZWAreaAbsorptiveController;
            self.headerView.timeString  = [NSString stringWithFormat:@"%@ - %@", self.BeginDate,self.EndDate];
            self.headerView.beginTime = self.beginTime;
            self.headerView.endTime = self.endTime;
            self.headerView.timeType = self.Type;
            
            
            if (self.dayArray && self.dayArray.count) {
                self.statues.xArray = self.dayArray;
            }
            if (self.unearthedArray && self.unearthedArray.count) {
                self.statues.yValueArray = self.unearthedArray;
                CGPoint range = [ZWStatuesTool configureValueRangeWithData:self.statues.yValueArray];
                self.statues.valueRange = CGPointMake(0, range.y);
                self.headerView.statues = self.statues;
            }
            NSString *beginStr = responseObject[@"Data"][@"BeginDateValue"];
            NSString *endStr = responseObject[@"Data"][@"EndDateValue"];
            self.headerView.timeString = [NSString stringWithFormat:@"%@ - %@",beginStr,endStr];
            
            //获取当天的数据
            [self getSingleDayDataWithType:5];
            [self.tableView reloadData];
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
    }];
}


-(void)getSingleDayDataWithType:(NSInteger )type{
    NSDictionary *params = @{
                             @"Type":@(type),
                             @"DepartmentName":self.DepartmentName,
                             @"DepartmentId":self.DepartmentId,
                             @"BeginDate":self.BeginDate,
                             @"EndDate":self.EndDate
                             };
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetRegionConsumptive parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            if ([responseObject[@"Data"][@"UnearthedDetailRankModel"] isKindOfClass:[NSArray class]]) {
                NSMutableArray *tempM = [NSMutableArray array];
                for (NSDictionary *dict in responseObject[@"Data"][@"UnearthedDetailRankModel"]) {
                    ZWUnearthedDetailRankModel *model = [ZWUnearthedDetailRankModel mj_objectWithKeyValues:dict];
                    [tempM addObject:model];
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:tempM.copy];
                [self.tableView reloadData];
                if (self.dataArray.count== 0) {
                    self.noDataImg.hidden = NO;
                    self.noDataLab.hidden = NO;
                    self.noDataBtn.hidden = NO;
                    self.tableView.hidden = YES;
                }else{
                    self.noDataImg.hidden = YES;
                    self.noDataLab.hidden = YES;
                    self.noDataBtn.hidden = YES;
                    self.tableView.hidden = NO;
                }
            }
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}






#pragma mark -UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([self class])];
    if (!cell) {
        cell = [[ZWCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([self class])];
        cell.delegate = self;
    }
    cell.model = self.dataArray[indexPath.row];
    cell.rank = indexPath.row+1;
    return cell;
}

#pragma mark - UITableViewDelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(88);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWidth(88);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZWAreaUnearthedTableSectionHeaderView *header = [[ZWAreaUnearthedTableSectionHeaderView alloc] init];
    if (self.controllerType == ZWAreaUnearthedController) {
        header.contentStr = @"出土量(立方)";
        header.typeStr = @"工地";
    }else{
        header.contentStr = @"消纳量(立方)";
        header.typeStr = @"消纳点";
    }
    return header;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{

}

#pragma mark - 懒加载
- (NSMutableArray *)dayArray{
    if (!_dayArray) {
        _dayArray = [NSMutableArray array];
    }
    return _dayArray;
}
- (NSMutableArray *)unearthedArray{
    if (!_unearthedArray) {
        _unearthedArray = [NSMutableArray array];
    }
    return _unearthedArray;
}
- (NSMutableArray *)dataArray{
    if (!_dataArray) {
        _dataArray = [NSMutableArray array];
    }
    return _dataArray;
}

- (ZWDayWeekMonthView *)dateView{
    if (!_dateView) {
        _dateView = [[ZWDayWeekMonthView alloc] init];
        _dateView.type = ZWDayWeekMonth;
        _dateView.delegate = self;
        _dateView.backgroundColor = COLORWITHHEX(kColor_3A62AC);
        [self.view addSubview:_dateView];
    }
    return _dateView;
}

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.bounces = NO;
        _tableView.tableFooterView = [UIView new];

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
            if (weakSelf.controllerType == ZWAreaUnearthedController) {
                [weakSelf loadUnearthedData];
            }else{
                [weakSelf loadAbsorptiveData];
            }
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

-(void)noDataBtnClick:(UIButton *)sedner{
    if (self.controllerType == ZWAreaUnearthedController) {
        [self loadUnearthedData];
    }else{
        [self loadAbsorptiveData];
    }
}

#pragma mark - ZWCommonTableViewCellDelegate
//详情
- (void)ZWCommonTableViewCellSelectedCompany:(ZWCommonTableViewCell *)cell{
//    ZWSiteDetailViewController *vc = [[ZWSiteDetailViewController alloc] init];
//    ZWUnearthedDetailRankModel *model = cell.model;
//    vc.Type = self.Type;
//    if (self.controllerType == ZWAreaUnearthedController) {
//        vc.SiteId = model.Id;
//        vc.SiteType = @"1";
//        vc.controllerType =  ZWSiteDetailController;
//    }else{
//        vc.UnLoadId = model.Id;
//        vc.PointType = @"1";
//        vc.controllerType =  ZWGivenPointDetailController;
//    }
//    [self.navigationController pushViewController:vc animated:YES];
}




#pragma mark - ZWDayWeekMonthViewDelegate
// Type  1=昨日 2=今日 3=本周 4=本月 5=时间段 6=上周
- (void)ZWDayWeekMonthViewSegmentedControlClick:(NSInteger)index{
    switch (index) {
        case 0:{
            self.Type = 2;
            [self loadTimeData];

            break;
        }
        case 1:{
            self.Type = 3;
            [self loadTimeData];

            break;
        }
        case 2:{
            self.Type = 4;
               [self loadTimeData];

            break;
        }
        default:
            break;
    }
}

- (NSString *)getDateStr:(NSString *)string{
    NSDateFormatter * formatter =  [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"yyyyMMdd";
    NSDate *date = [formatter dateFromString:string];
    NSDateFormatter * fmt=  [[NSDateFormatter alloc] init];
    fmt.dateFormat = @"MM-dd";
    return [fmt stringFromDate:date];
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
