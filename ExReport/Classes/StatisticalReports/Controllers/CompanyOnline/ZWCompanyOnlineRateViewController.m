//
//  ZWCompanyOnlineRateViewController.m
//  Muck
//
//  Created by 张威 on 2018/7/29.
//  Copyright © 2018年 张威. All rights reserved.
//
#import "ZWCompanyOnlineRateViewController.h"
#import "ZWCommonTableViewCell.h"
#import "ZWAreaUnearthedTableSectionHeaderView.h"
#import "ZWStatiscalReportsCompanyOnlneDetailCell.h"
#import "ExSelectAreaViewController.h"
#import "ZWCompanyOnlineRateModel.h"
#import "ZWRegionModel.h"
//#import "ZWCompanyDetailViewController.h"
@interface ZWCompanyOnlineRateViewController ()
<UITableViewDelegate,
UITableViewDataSource,
ZWCommonTableViewCellDelegate,
ExelectAreaViewControllerDelegate>

@property (strong, nonatomic)UITableView *tableView;
@property (strong, nonatomic)UIButton *rightButton;
@property (nonatomic,strong)UIImageView *noDataImg;
@property (nonatomic,strong)UILabel *noDataLab;
@property (nonatomic,strong)UIButton *noDataBtn;
@property (nonatomic) BOOL detailFlag;
@property (nonatomic, strong) NSIndexPath *detailIndexPath;
@property (nonatomic, strong) NSMutableArray *dataSource;//假数据
@property (copy, nonatomic)NSString *DepartmentName;
@property (copy, nonatomic)NSString *DepartmentId;

@end

@implementation ZWCompanyOnlineRateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.dataSource = @[].mutableCopy;
    [self setupNavigationTitleWithTitle:@"企业上线率"];
    
    NSString *path = [kDocPath stringByAppendingPathComponent:@"region.data"];
    NSArray *array = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    ZWRegionModel *model = [array firstObject];
    self.DepartmentName = model.Name;
    self.DepartmentId = model.Id;

    [self setupNavBar];
    [self loadData];
    
}

- (void)loadData{
    NSDictionary *params = @{
                             @"DepartmentId":self.DepartmentId,
                             @"DepartmentName":self.DepartmentName
                             };
    [ExProgressHUD showProgress:@"加载中" inView:self.view];;
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetEnterpriseTheWholePoint parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSArray class]]) {
                NSMutableArray *temp = [NSMutableArray array];
                for (NSDictionary *dict in responseObject[@"Data"]) {
                    ZWCompanyOnlineRateModel *model = [ZWCompanyOnlineRateModel mj_objectWithKeyValues:dict];
                    [temp addObject:model];
                }
                [self.dataSource removeAllObjects];
                [self.dataSource addObjectsFromArray:temp.copy];
                [self.tableView reloadData];
                if(self.dataSource.count == 0){
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
        
    }];

}
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

#pragma mark - ZWCommonTableViewCellDelegate
////企业详情
//- (void)ZWCommonTableViewCellSelectedCompany:(ZWCommonTableViewCell *)cell{
//    ZWCompanyDetailViewController *vc = [[ZWCompanyDetailViewController alloc] init];
//    vc.EnterpriseId = @[cell.rateModel.Id];
//    [self.navigationController pushViewController:vc animated:YES];
//}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWCompanyOnlineRateModel *rateModel = self.dataSource[indexPath.row];
    if (self.detailFlag && self.detailIndexPath.row == indexPath.row) {
        ZWStatiscalReportsCompanyOnlneDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWStatiscalReportsCompanyOnlneDetailCell class])];
        if (!cell) {
            cell = [[ZWStatiscalReportsCompanyOnlneDetailCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([ZWStatiscalReportsCompanyOnlneDetailCell class])];
            cell.type = ZWStatiscalReportsDetailCellCompanyOnline;
            
        }
        cell.rateModel = rateModel;
        return cell;
        
    } else {
        ZWCommonTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWCommonTableViewCell class])];
        if (!cell) {
            cell = [[ZWCommonTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([self class])];
            cell.delegate = self;
        }
        cell.rateModel = rateModel;
        cell.rank = indexPath.row+1;
        return cell;
    }
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.detailFlag && self.detailIndexPath.row == indexPath.row) {
        return UITableViewAutomaticDimension;
    } else {
        return kWidth(88);
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    ZWAreaUnearthedTableSectionHeaderView *header = [[ZWAreaUnearthedTableSectionHeaderView alloc] init];
    header.titleStr = @"区名";
    header.typeStr = @"企业";
    header.contentStr = @"上线率(上线车辆/总车辆)";
    return header;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWidth(88);
}

- (CGFloat)tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    if ([cell isKindOfClass:[ZWCommonTableViewCell class]]) {
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

- (UITableView *)tableView{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStylePlain];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.rowHeight = 44;
        _tableView.separatorInset = UIEdgeInsetsMake(0, 0, 0, 0);
        _tableView.tableFooterView = [UIView new];
        [self.view addSubview:_tableView];
    }
    return _tableView;
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

- (void)noDataBtnClick:(UIButton *)sedner{
    [self loadData];
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
