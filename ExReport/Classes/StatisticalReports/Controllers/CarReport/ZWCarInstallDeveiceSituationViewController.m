//
//  ZWCarInstallDeveiceSituationViewController.m
//  Muck
//
//  Created by 张威 on 2018/8/30.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarInstallDeveiceSituationViewController.h"
#import "ZWCarInstallDeveiceSituationCollectionViewCell.h"
#import "ZWCarInstallDeveiceSituationReusableViewHeader.h"
#import "ZWDataItemsModel.h"
#import "ZWVehicleImgsModel.h"

@interface ZWCarInstallDeveiceSituationViewController ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property(strong,nonatomic)UICollectionView *collectionView;
@property (strong, nonatomic)UICollectionViewFlowLayout *layout;

@property (strong, nonatomic)NSArray *sectionArray;

@property (nonatomic,strong)UIImageView *noDataImg;
@property (nonatomic,strong)UILabel *noDataLab;
@property (nonatomic,strong)UIButton *noDataBtn;


@end



@implementation ZWCarInstallDeveiceSituationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setupNavigationTitleWithTitle:self.DepartmentName];
    [self loadData];
}

- (void)loadData{
    NSDictionary *params = @{@"BeginDate":self.BeginDate,
                             @"EndDate":self.EndDate,
                             @"DepartmentId":self.DepartmentId
                             };
    [ExProgressHUD showProgress:@"加载中" inView:self.view];
    [[ExNetwork sharedManager] PostUrlString:URL_POST_GetInstallVehicleImgs parameters:params success:^(id  _Nullable responseObject) {
        if ([responseObject[@"Code"] integerValue] == 0) {
              [ExProgressHUD hide];
         NSArray *DataItemsArray =  responseObject[@"Data"][@"DataItems"];
            NSMutableArray *tempArray = [NSMutableArray array];
            for (NSDictionary *dict in DataItemsArray) {
                ZWDataItemsModel *model = [ZWDataItemsModel mj_objectWithKeyValues:dict];
                [tempArray addObject:model];
            }
            self.sectionArray = tempArray.copy;
            
            if (self.sectionArray.count == 0) {
                self.noDataImg.hidden = NO;
                self.noDataLab.hidden = NO;
                self.noDataBtn.hidden = NO;
           
            }else{
                self.noDataImg.hidden = YES;
                self.noDataLab.hidden = YES;
                self.noDataBtn.hidden = YES;
            }
            [self.collectionView reloadData];
        }else{
            [ExProgressHUD showMessage:responseObject[@"Message"]];
        }
    } failure:^(NSError * _Nonnull error) {

    }];
}

- (NSArray *)sectionArray{
    if (!_sectionArray) {
        _sectionArray = [NSArray array];
    }
    return _sectionArray;
}
- (void)setupConstraint{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(ExNavigationHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-ExSafeAreaBottom);
    }];
}
- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:self.layout];
        _collectionView.backgroundColor = [UIColor whiteColor];
        _collectionView.dataSource = self;
        _collectionView.delegate = self;
        [_collectionView registerClass:[ZWCarInstallDeveiceSituationCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ZWCarInstallDeveiceSituationCollectionViewCell class])];
        [_collectionView registerClass:[ZWCarInstallDeveiceSituationReusableViewHeader class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ZWCarInstallDeveiceSituationReusableViewHeader class])];
        [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (UICollectionViewFlowLayout *)layout
{
    if (!_layout) {
        _layout = [[UICollectionViewFlowLayout alloc] init];
        _layout.itemSize = CGSizeMake(kWidth(120), kWidth(180));
        _layout.headerReferenceSize = CGSizeMake(kScreenWidth, kWidth(160));
        _layout.minimumInteritemSpacing = (kScreenWidth -4*kWidth(120))/5;
        _layout.minimumLineSpacing = kWidth(10);
        _layout.sectionInset = UIEdgeInsetsMake(kWidth(20), kWidth(24), kWidth(20), kWidth(24));

    }
    return _layout;
}

#pragma mark -UICollectionViewDataSource
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return self.sectionArray.count;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
  ZWDataItemsModel *itemModel = self.sectionArray[section];
    return itemModel.VehicleImgs.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ZWCarInstallDeveiceSituationCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ZWCarInstallDeveiceSituationCollectionViewCell class]) forIndexPath:indexPath];
    ZWDataItemsModel *model1 = self.sectionArray[indexPath.section];
    ZWVehicleImgsModel *model = model1.VehicleImgs[indexPath.item];
    cell.model = model;
    return cell;
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
        ZWCarInstallDeveiceSituationReusableViewHeader *header = nil;

    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:NSStringFromClass([ZWCarInstallDeveiceSituationReusableViewHeader class]) forIndexPath:indexPath];
        header.model = self.sectionArray[indexPath.section];
  

    }
        return header;
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
    [self loadData];
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
