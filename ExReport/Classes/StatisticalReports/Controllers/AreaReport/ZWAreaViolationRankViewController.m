//
//  ZWAreaViolationRankViewController.m
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWAreaViolationRankViewController.h"
#import "ZWDayHeaderView.h"
#import "ZWAreaViolationRankSectionHeaderView.h"
#import "ZWAreaViolationRankTableViewCell.h"
#import "ZWStatiscalReportsCompanyOnlneDetailCell.h"//详情cell
#import "ZWAreaViolationRankModel.h"
#import "ZWSelectedTimeView.h"
#import "CJCalendarViewController.h"
@interface ZWAreaViolationRankViewController ()
<
    UITableViewDelegate,
    UITableViewDataSource,
    ZWDayHeaderViewDelegate,
    CalendarViewControllerDelegate
>

@property (strong, nonatomic) ZWDayHeaderView *dayView;

@property (nonatomic, strong) UITableView *tableView;

@property (nonatomic, strong) NSMutableArray<ZWAreaViolationRankModel *> *dataSource;//假数据
@property (strong, nonatomic)ZWSelectedTimeView *selectedTimeView;
@property (nonatomic) BOOL detailFlag;
@property (nonatomic, strong) NSIndexPath *detailIndexPath;
@property(strong, nonatomic)NSArray *AlarmType;
@property(assign, nonatomic)NSInteger Type;
@property (copy, nonatomic)NSString *BeginDate;
@property (copy, nonatomic)NSString *EndDate;
@property (strong, nonatomic)CJCalendarViewController *startCalendar;
@property (strong, nonatomic)CJCalendarViewController *endCalendar;


@property (nonatomic,strong)UIImageView *noDataImg;
@property (nonatomic,strong)UILabel *noDataLab;
@property (nonatomic,strong)UIButton *noDataBtn;

@end
@implementation ZWAreaViolationRankViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[].mutableCopy;
    self.Type = 2;
    [self loadTimeData];

    if (self.controllerType == ZWAreaViolationRankViewControllerUnClosenessRate) {
        self.AlarmType = @[@"100"];
        [self setupNavigationTitleWithTitle:@"区域未密闭率"];
    } else if (self.controllerType == ZWAreaViolationRankViewControllerOverspeedRate) {
        self.AlarmType =  @[@"1",@"106"];
        [self setupNavigationTitleWithTitle:@"区域超速率"];
    }
   
    self.dayView.timeString = [NSString stringWithFormat:@"%@ - %@",self.BeginDate,self.EndDate];

    MJWeakSelf
    self.dayView = [[ZWDayHeaderView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kWidth(160))];
    self.dayView.delegate = self;
    self.dayView.didSelectTimeBlock = ^{
        weakSelf.Type = 5;
        [weakSelf.selectedTimeView show];
    };

    self.dayView.type = ZWDayWeekMonth;
    self.tableView.tableHeaderView = self.dayView;
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
            self.dayView.timeString = [NSString stringWithFormat:@"%@ - %@",self.BeginDate,self.EndDate];
            
            if (self.controllerType == ZWAreaViolationRankViewControllerUnClosenessRate) {
                self.AlarmType = @[@"100"];
            } else if (self.controllerType == ZWAreaViolationRankViewControllerOverspeedRate) {
                self.AlarmType =  @[@"1",@"106"];
            }
            [self loadData];
       
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {
        
    }];
}

- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, ExNavigationHeight, kScreenWidth, kScreenHeight-ExNavigationHeight);
}


- (void)loadData{
    
    NSDictionary *params = [NSDictionary dictionary];
    if (self.Type == 5) {
        params = @{
                   @"Type":@(self.Type),
                   @"BeginDate":self.BeginDate,
                   @"EndDate":self.EndDate,
                   @"AlarmType":self.AlarmType
                   };
    }else{
        params = @{
                   @"Type":@(self.Type),
                   @"AlarmType":self.AlarmType
                   };
    }
    [ExProgressHUD showProgress:@"加载中" inView:self.view];;
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetRegionAlarm parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            NSMutableArray *tempArray = [NSMutableArray array];
           NSArray *resultArray = responseObject[@"Data"];
            for (NSDictionary *dict in resultArray) {
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


#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ZWAreaViolationRankModel *model = self.dataSource[indexPath.row];
    if (self.detailFlag && self.detailIndexPath.row == indexPath.row) {//隐藏的
        ZWStatiscalReportsCompanyOnlneDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWStatiscalReportsCompanyOnlneDetailCell class])];
        if (!cell) {
            cell = [[ZWStatiscalReportsCompanyOnlneDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([ZWStatiscalReportsCompanyOnlneDetailCell class])];
            cell.type = ZWStatiscalReportsDetailCellAreaViolationRate;
        }
        cell.model = model;
        return cell;
    } else {//非隐藏的
        ZWAreaViolationRankTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWAreaViolationRankTableViewCell class])];
        if (!cell) {
            cell = [[ZWAreaViolationRankTableViewCell alloc] initWithStyle:UITableViewCellStyleValue2 reuseIdentifier:NSStringFromClass([ZWAreaViolationRankTableViewCell class])];
        }
        cell.rank = indexPath.row+1;
        cell.model = model;
        return cell;
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[ZWAreaViolationRankTableViewCell class]]) {
        ZWAreaViolationRankModel *model = self.dataSource[indexPath.row];
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
            
            [self.dataSource insertObject:model atIndex:self.detailIndexPath.row];
            [tableView insertRowsAtIndexPaths:@[self.detailIndexPath] withRowAnimation:UITableViewRowAnimationTop];
        } else {
            //修改数据源插入一个cell
            self.detailFlag = YES;
            [self.dataSource insertObject:model atIndex:indexPath.row+1];
            NSIndexPath *insertIndexPath = [NSIndexPath indexPathForRow:indexPath.row+1 inSection:0];
            self.detailIndexPath = insertIndexPath;
            [tableView insertRowsAtIndexPaths:@[insertIndexPath] withRowAnimation:UITableViewRowAnimationTop];
        }
    } else {
        if (self.detailFlag) {
            //删除以前插入的cell
            [self.dataSource removeObjectAtIndex:self.detailIndexPath.row];
            [tableView deleteRowsAtIndexPaths:@[self.detailIndexPath] withRowAnimation:UITableViewRowAnimationTop];
            self.detailFlag = NO;
        }
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return kWidth(88);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.detailFlag && self.detailIndexPath.row == indexPath.row) {
        return UITableViewAutomaticDimension;
    } else {
        return kWidth(88);
    }
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ZWAreaViolationRankSectionHeaderView *header = [[ZWAreaViolationRankSectionHeaderView alloc] init];
    if (self.controllerType == ZWAreaViolationRankViewControllerUnClosenessRate) {
        header.contentStr = @"违规比率(未密闭时长/里程)";
    }else{
        header.contentStr = @"违规比率(超速时长/里程)";
    }
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

#pragma mark - ZWDayWeekMonthViewDelegate
- (void)dayHeaderViewSelectedIndex:(NSInteger)index{
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
    if (self.controllerType == ZWAreaViolationRankViewControllerUnClosenessRate) {
        self.AlarmType = @[@"100"];
 
    } else if (self.controllerType == ZWAreaViolationRankViewControllerOverspeedRate) {
        self.AlarmType =  @[@"1",@"106"];
    }
        [self loadData];
}


@end




