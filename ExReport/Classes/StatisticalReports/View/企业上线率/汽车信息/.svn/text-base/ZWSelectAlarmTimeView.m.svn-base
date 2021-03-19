//
//  ZWSelectAlarmTimeView.m
//  Muck
//
//  Created by 张威 on 2018/8/27.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWSelectAlarmTimeView.h"
#import "ZWSelectAlarmTimeViewCell.h"

static NSString *const selectAlarmTimeViewCellReusedID = @"selectAlarmTimeViewCellReusedID";
@interface ZWSelectAlarmTimeView ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong)UIView *dimView;
@property (nonatomic,strong)UIView *baseView;

@property (strong, nonatomic)NSArray *dataArray;
@end
@implementation ZWSelectAlarmTimeView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.hidden = NO;
        self.dimView.hidden = NO;
        self.baseView.hidden = NO;
        
        [self setupUI];
        [self setupConstraint];
        
    }
    return self;
}

- (NSString *)getCurrentTime {
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}
-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@"开始时间",@"结束时间"];
    }
    return _dataArray;
}

- (void)setupUI{
    self.tableView = [[UITableView alloc]init];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
    self.tableView.scrollEnabled = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ZWSelectAlarmTimeViewCell class] forCellReuseIdentifier:selectAlarmTimeViewCellReusedID];
    [self.baseView addSubview:self.tableView];
}

- (void)setupConstraint{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self.baseView);
    }];
}

- (UIView *)dimView{
    if (!_dimView) {
        _dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _dimView.alpha = 0.4;
        _dimView.backgroundColor = [UIColor blackColor];
        [self addSubview:_dimView];
    }
    return _dimView;
}

- (UIView *)baseView{
    if (!_baseView) {
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(kWidth(75), kWidth(400), kScreenWidth-2*kWidth(75), kWidth(400))];
        _baseView.alpha = 1.0f;
        _baseView.layer.cornerRadius = kWidth(6);
        _baseView.layer.masksToBounds = YES;
        
        _baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_baseView];
    }
    return _baseView;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWSelectAlarmTimeViewCell *cell = [tableView dequeueReusableCellWithIdentifier:selectAlarmTimeViewCellReusedID];
    cell.titleStr = self.dataArray[indexPath.row];
    cell.timeStr = [self getCurrentTime];
    if (indexPath.row == 0) {
        cell.detail = self.beginTime;
    }else{
        cell.detail = self.endTime;
    }
    return cell;
}

- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    UIView *headView = [[UIView alloc]init];
    UILabel *tipLab = [UILabel LabelWithFont:kSystemDefauletFont(36) andColor:COLORWITHHEX(kColor_5490EB) andTextAlignment:left andString:@"自定义时间段"];
    [headView addSubview:tipLab];
    [tipLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(headView).offset(kWidth(30));
        make.centerY.equalTo(headView);
    }];
    return headView;
}

- (void)cancelClick:(UIButton *)sender{
    [self dismiss];
}
- (void)comfirmClick:(UIButton *)sender{
    if (self.comfirmBlock) {
        self.comfirmBlock();
    }
    [self dismiss];
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section{
    UIView *footerView = [[UIView alloc]init];
    UIButton *cancelBtn = [[UIButton alloc]init];
    cancelBtn.layer.cornerRadius = kWidth(10);
    cancelBtn.layer.masksToBounds = YES;
    [cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
    [cancelBtn setTitleColor:COLORWITHHEX(kColor_FFFFFF) forState:UIControlStateNormal];
    [cancelBtn setBackgroundColor:COLORWITHHEX(kColor_D9DCE3)];
    [cancelBtn addTarget:self action:@selector(cancelClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *comfirmBtn = [[UIButton alloc]init];
    comfirmBtn.layer.cornerRadius = kWidth(10);
    comfirmBtn.layer.masksToBounds = YES;
    [comfirmBtn setTitle:@"确定" forState:UIControlStateNormal];
    [comfirmBtn setTitleColor:COLORWITHHEX(kColor_FFFFFF) forState:UIControlStateNormal];
    [comfirmBtn setBackgroundColor:COLORWITHHEX(kColor_5490EB)];
    [comfirmBtn addTarget:self action:@selector(comfirmClick:) forControlEvents:UIControlEventTouchUpInside];

    [footerView addSubview:cancelBtn];
    [footerView addSubview:comfirmBtn];
    [comfirmBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(footerView.mas_right).offset(-kWidth(30));
        make.centerY.equalTo(footerView);
        make.size.mas_equalTo(CGSizeMake(kWidth(100), kWidth(70)));
    }];
    [cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(comfirmBtn.mas_left).offset(-kWidth(30));
        make.centerY.equalTo(footerView);
        make.size.mas_equalTo(CGSizeMake(kWidth(100), kWidth(70)));
    }];

    return footerView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(100);
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return kWidth(100);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.selectedTimeBlock) {
        self.selectedTimeBlock(indexPath.row);
    }
}
- (void)dismiss{
    self.hidden = YES;
    self.dimView.hidden = YES;
    self.baseView.hidden = YES;
}

- (void)show{
    self.hidden = NO;
    self.dimView.hidden = NO;
    self.baseView.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.baseView.frame = CGRectMake(kWidth(75), kWidth(400), kScreenWidth-2*kWidth(75), kWidth(400));
    }];
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}
@end
