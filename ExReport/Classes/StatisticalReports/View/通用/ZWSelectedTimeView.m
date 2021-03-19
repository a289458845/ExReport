//
//  ZWSelectedTimeView.m
//  Muck
//
//  Created by 张威 on 2018/8/9.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWSelectedTimeView.h"
#import "ZWSelectedTimeCell.h"

static NSString *const SelectedTimeCellReusedID = @"SelectedTimeCellReusedID";
@interface  ZWSelectedTimeView ()<UITableViewDataSource,UITableViewDelegate>


@property (nonatomic,strong)UIButton *cancelButton;//取消按钮
@property (nonatomic,strong)UIButton *confirmButton;//确认按钮
@property (nonatomic,strong)UILabel *tipLabel;//提示文字
@property (nonatomic,strong)UIView *dimView;//阴影
@property (nonatomic,strong)UIView *baseView;//内容视图
@property (nonatomic,strong)UIView *lineView;

@property (strong, nonatomic)NSArray *dataArray;

@end
@implementation ZWSelectedTimeView

- (UIView *)dimView{
    if (!_dimView) {
        _dimView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreenWidth, kScreenHeight)];
        _dimView.alpha = 0.3;
        _dimView.backgroundColor = [UIColor blackColor];
        [self addSubview:_dimView];
    }
    return _dimView;
}
- (UIView *)baseView
{
    if (!_baseView) {
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kWidth(264))];
        _baseView.alpha = 1.0f;
        _baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_baseView];
    }
    return _baseView;
}

-(NSArray *)dataArray{
    if (!_dataArray) {
        _dataArray = @[@{@"title":@"开始时间",@"placeHolder":@"请选择"},
                       @{@"title":@"结束时间",@"placeHolder":@"请选择"},
                       ];
    }
    return _dataArray;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreenWidth, kScreenHeight);
        self.backgroundColor = [UIColor colorWithRed:1.00f green:1.00f blue:1.00f alpha:0.00f];
        
        self.hidden = NO;
        self.dimView.hidden = NO;
        self.baseView.hidden = NO;
 
        [self setupUI];
        [self setupConstraint];
    }
    return self;
}

- (void)setupUI{
    self.tableView = [[UITableView alloc]initWithFrame:CGRectMake(0, kWidth(88), kScreenWidth, kWidth(176)) style:UITableViewStylePlain];
    self.tableView.delegate = self;
    self.tableView.dataSource = self;
    self.tableView.showsVerticalScrollIndicator = NO;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerClass:[ZWSelectedTimeCell class] forCellReuseIdentifier:SelectedTimeCellReusedID];
    
    _tipLabel = [UILabel LabelWithFont:kSystemFont(32) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:center andString:@" "];
    //取消按钮
    _cancelButton = [[UIButton alloc] init];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = kSystemFont(32);
    [_cancelButton setTitleColor:COLORWITHHEX(kColor_FB5E52) forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(clickCancelAction:) forControlEvents:UIControlEventTouchUpInside];

    //确认按钮
    _confirmButton = [[UIButton alloc] init];
    [_confirmButton setTitle:@"确定" forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = kSystemFont(32);
    [_confirmButton setTitleColor:COLORWITHHEX(kColor_FB5E52) forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(clickConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = COLORWITHHEX(kColor_D9DCE3);
    
    [self.baseView addSubview:self.lineView];
    [self.baseView addSubview:_cancelButton];
    [self.baseView addSubview:_confirmButton];
    [self.baseView addSubview:_tipLabel];
    [self.baseView addSubview:self.tableView];
    [self.baseView addSubview:self.lineView];
}

- (void)setupConstraint{
 
    
    [self.tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kWidth(40));
        make.centerY.equalTo(self.baseView.mas_top).offset(kWidth(44));
        make.centerX.mas_equalTo(self.baseView);
    }];
    
    [self.cancelButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.baseView.mas_left);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(self.baseView);
    }];
    
    [self.confirmButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.baseView.mas_right);
        make.height.mas_equalTo(40);
        make.width.mas_equalTo(100);
        make.top.mas_equalTo(self.baseView);
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.mas_equalTo(self.baseView);
        make.top.mas_equalTo(self.baseView).offset(kWidth(88));
        make.height.mas_equalTo(kWidth(1));
    }];
}

- (NSString *)getCurrentTime{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd"];
    NSString *dateTime = [formatter stringFromDate:[NSDate date]];
    return dateTime;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [self dismiss];
}

- (void)setTipString:(NSString *)tipString{
    _tipString = tipString;
    _tipLabel.text = tipString;
}

- (void)clickCancelAction:(UIButton *)sender{
    [self dismiss];
    if (_cancelAction) {
        _cancelAction();
    }
    
}

- (void)clickConfirmAction:(UIButton *)sender{
    [self dismiss];
    if (self.confirmAction) {
        self.confirmAction();
    }
}

- (void)show{
    self.hidden = NO;
    self.dimView.hidden = NO;
    self.baseView.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.baseView.frame = CGRectMake(0, kScreenHeight-kWidth(240), kScreenWidth, kWidth(240));
    }];
}
- (void)dismiss
{
    
    [UIView animateWithDuration:0.3f animations:^{
        self.baseView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kWidth(240));
    }completion:^(BOOL finished) {
        self.hidden = YES;
        self.dimView.hidden = YES;
        self.baseView.hidden = YES;
    }];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZWSelectedTimeCell *cell = [tableView dequeueReusableCellWithIdentifier:SelectedTimeCellReusedID];
    cell.titleString = self.dataArray[indexPath.row][@"title"];
    cell.timeString = self.dataArray[indexPath.row][@"placeHolder"];
    if (indexPath.row == 0) {
        cell.detail = self.startTime;
    }else{
        cell.detail = self.endTime;
    }
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return kWidth(88);
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return 0.01f;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return kWidth(10);
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    if (self.didSelectAction) {
        self.didSelectAction(indexPath.row);
    }
}


@end
