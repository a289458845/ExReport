//
//  ZWKeyMonitoringViewController.m
//  Muck
//
//  Created by 张威 on 2018/8/16.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWKeyMonitoringViewController.h"
#import "ZWKeykeyMonitoringTableViewCell.h"
#import "ZWkeyMonitoringModel.h"
#import "ZWSingleMonitoringDetailViewController.h"

@interface ZWKeyMonitoringViewController ()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic,strong)UIImageView *noDataImg;
@property (nonatomic,strong)UILabel *noDataLab;
@property (nonatomic,strong)UIButton *noDataBtn;
@property (strong, nonatomic)NSMutableArray *dataArray;


@end

@implementation ZWKeyMonitoringViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationTitleWithTitle:@"重点监控区域"];
    [self loadData];
}

- (void)loadData{

    [ExProgressHUD showProgress:@"加载中" inView:self.view];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetFenceList parameters:nil success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
            [ExProgressHUD hide];
            if ([responseObject[@"Data"] isKindOfClass:[NSArray class]]) {
                NSArray *resultArray = responseObject[@"Data"];
                NSMutableArray *temp= [NSMutableArray array];
                for (NSDictionary *dict in resultArray) {
                    ZWkeyMonitoringModel *model = [ZWkeyMonitoringModel mj_objectWithKeyValues:dict];
                    [temp addObject:model];
                }
                [self.dataArray removeAllObjects];
                [self.dataArray addObjectsFromArray:temp.copy];
                [self.tableView reloadData];
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
        
    }];
    
}


- (void)viewWillLayoutSubviews{
    [super viewWillLayoutSubviews];
    self.tableView.frame = CGRectMake(0, ExNavigationHeight, kScreenWidth, kScreenHeight-ExNavigationHeight);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWKeykeyMonitoringTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ZWKeykeyMonitoringTableViewCell class])];
    if (!cell) {
        cell = [[ZWKeykeyMonitoringTableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:NSStringFromClass([ZWKeykeyMonitoringTableViewCell class])];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = self.dataArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(88);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWSingleMonitoringDetailViewController *vc = [[ZWSingleMonitoringDetailViewController alloc]init];
    vc.model = self.dataArray[indexPath.row];
    [self.navigationController pushViewController:vc animated:YES];
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
