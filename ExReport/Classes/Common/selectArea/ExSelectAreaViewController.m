//
//  ExSelectAreaViewController.m
//  ExCheckCar
//
//  Created by exsun on 2021/1/21.
//

#import "ExSelectAreaViewController.h"
#import "ExAreaCollectionViewCell.h"
#import "ZWRegionModel.h"
@interface ExSelectAreaViewController ()<UICollectionViewDataSource,UICollectionViewDelegate>
@property(nonatomic,strong)UICollectionView *collectionView;
@property (strong, nonatomic)UICollectionViewFlowLayout *flowLayout;
@property (strong, nonatomic)NSArray *itemArray;


@property (strong, nonatomic)ZWRegionModel *model;

@end

@implementation ExSelectAreaViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [self setupNavigationTitleWithTitle:@"选择区域"];
    self.title = @"选择区域";
    [self setupNavBar];
    [self setupConstraint];
}


- (void)setupNavBar{
    self.navigationItem.rightBarButtonItem = nil;
    [self.navigationController.navigationBar setNeedsLayout];
    UIView *rightContentView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 84, 44)];
    UIButton *rightButton = [[UIButton alloc] initWithFrame:rightContentView.bounds];
    [rightButton setTitle:@"确定" forState:UIControlStateNormal];
    rightButton.titleLabel.font = kSystemFont(30);
    [rightButton setTitleColor:COLORWITHHEX(kColor_3A3D44) forState:UIControlStateNormal];
    [rightButton addTarget:self action:@selector(rightItemBtnClick:) forControlEvents:UIControlEventTouchUpInside];
    [rightContentView addSubview:rightButton];
    UIBarButtonItem *rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:rightContentView];
    self.navigationItem.rightBarButtonItem = rightBarButtonItem;
}

- (void)rightItemBtnClick:(UIBarButtonItem *)item{
    if (self.delegate && [self.delegate respondsToSelector:@selector(selectAreaViewControllerDelegateItemClick:)]) {
        [self.delegate selectAreaViewControllerDelegateItemClick:self.model];
    }
        
    [self.navigationController popViewControllerAnimated:YES];
}

- (UICollectionViewFlowLayout *)flowLayout{
    if (!_flowLayout) {
        _flowLayout = [[UICollectionViewFlowLayout alloc]init];
        _flowLayout.itemSize = CGSizeMake(kWidth(180), kWidth(56));
        _flowLayout.minimumLineSpacing = kWidth(30);
        _flowLayout.minimumInteritemSpacing = kWidth(55);
        _flowLayout.headerReferenceSize = CGSizeMake(kScreenWidth, kWidth(60));
        _flowLayout.footerReferenceSize = CGSizeMake(kScreenWidth, kScreenHeight);
        _flowLayout.sectionInset = UIEdgeInsetsMake(kWidth(30), kWidth(50), kWidth(30), kWidth(50));
    }
    return _flowLayout;
}

- (UICollectionView *)collectionView{
    if (!_collectionView) {
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectZero collectionViewLayout:self.flowLayout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.scrollEnabled = NO;
        _collectionView.backgroundColor = COLORWITHHEX(kColor_FFFFFF);
        [_collectionView registerClass:[ExAreaCollectionViewCell class] forCellWithReuseIdentifier:NSStringFromClass([ExAreaCollectionViewCell class])];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"header"];
        [_collectionView registerClass:[UICollectionReusableView class] forSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"footer"];
    
         [self.view addSubview:_collectionView];
    }
    return _collectionView;
}

- (void)setupConstraint{
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).offset(ExNavigationHeight);
        make.left.right.equalTo(self.view);
        make.bottom.equalTo(self.view).offset(-ExSafeAreaBottom);
    }];
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.itemArray.count;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    ExAreaCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:NSStringFromClass([ExAreaCollectionViewCell class]) forIndexPath:indexPath];
    if (!cell) {
        cell =[[ExAreaCollectionViewCell alloc]init];
    }
    ZWRegionModel *model = self.itemArray[indexPath.item];
    if (model.selected) {
        cell.areaBtn.backgroundColor = COLORWITHHEX(kColor_3A62AC);
        [cell.areaBtn setTitleColor:COLORWITHHEX(kColor_FFFFFF) forState:UIControlStateNormal];
    }else{
        cell.areaBtn.backgroundColor = COLORWITHHEX(kColor_FFFFFF);
        [cell.areaBtn setTitleColor:COLORWITHHEX(kColor_6D737F) forState:UIControlStateNormal];
    }
    [cell.areaBtn setTitle:model.Name forState:UIControlStateNormal];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    for (ZWRegionModel *model in self.itemArray) {
        model.selected = NO;
    }
    ZWRegionModel *model = self.itemArray[indexPath.item];
    model.selected = YES;
 
    self.model = model;
    [self.collectionView reloadData];
}


- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    NSLog(@"%zd",indexPath.item);
}
//返回组头和组尾方法
-(UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
    UICollectionReusableView *headerOrFooter = nil;
    if ([kind isEqualToString:UICollectionElementKindSectionHeader]) {
        headerOrFooter = [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"header" forIndexPath:indexPath];
        UILabel *label = [UILabel LabelWithFont:kSystemFont(32) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left];
        label.text = @"选择的区域:";
        [headerOrFooter addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(headerOrFooter).offset(kWidth(30));
            make.top.equalTo(headerOrFooter).offset(kWidth(20));
        }];

    }else if ([kind isEqualToString:UICollectionElementKindSectionFooter]){
        headerOrFooter =  [collectionView dequeueReusableSupplementaryViewOfKind:kind withReuseIdentifier:@"footer" forIndexPath:indexPath];
        headerOrFooter.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    }
    return headerOrFooter;
}

- (NSArray *)itemArray{
    if (!_itemArray) {
        NSString *path = [kDocPath stringByAppendingPathComponent:@"region.data"];
        _itemArray = [NSKeyedUnarchiver unarchiveObjectWithFile:path];
    }
    return _itemArray;
}


@end
