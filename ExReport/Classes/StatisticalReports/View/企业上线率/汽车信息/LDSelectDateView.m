//
//  LDSelectDateView.m
//  LogisticsDriver
//
//  Created by WTM on 2018/1/17.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "LDSelectDateView.h"
#import "LDDateModel.h"
@interface LDSelectDateView ()<UIPickerViewDataSource,UIPickerViewDelegate>

@property (nonatomic,strong)UIPickerView *pickerView;//日期选择器
//@property (nonatomic,strong)UIView *contentView;//内容视图
//@property (nonatomic,strong)UIView *bgView;//背影视图
@property (nonatomic,strong)UIButton *cancelButton;//取消按钮
@property (nonatomic,strong)UIButton *confirmButton;//确认按钮
@property (nonatomic,strong)UILabel *tipLabel;//提示文字

@property (nonatomic,strong)NSArray *yearArr;
@property (nonatomic,strong)NSArray *monthArr;
@property (nonatomic,strong)NSArray *dayArr;

@property (nonatomic,copy)NSString *yearStr;
@property (nonatomic,copy)NSString *monthStr;
@property (nonatomic,copy)NSString *dayStr;
@property (nonatomic,copy)NSString *dateStr;

@property (nonatomic,strong)UIView *dimView;
@property (nonatomic,strong)UIView *baseView;

@end
@implementation LDSelectDateView
- (UIView *)dimView
{
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
        _baseView = [[UIView alloc] initWithFrame:CGRectMake(0, kScreenHeight, kScreenWidth, kWidth(480))];
        _baseView.alpha = 1.0f;
        _baseView.backgroundColor = [UIColor whiteColor];
        [self addSubview:_baseView];
    }
    return _baseView;
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
        
        UIView *lineView = [UIView new];
        lineView.backgroundColor = COLORWITHHEX(@"#EEEEEE");
        [self.baseView addSubview:lineView];
        [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.right.mas_equalTo(self.baseView);
            make.top.mas_equalTo(self.baseView).offset(kWidth(80));
            make.height.mas_equalTo(kWidth(1));
        }];
        [self setupUI];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
}



- (void)setupUI
{
    _pickerView = [[UIPickerView alloc] initWithFrame:CGRectMake(0, kWidth(80), kScreenWidth, kWidth(400))];
    _pickerView.dataSource = self;
    _pickerView.delegate = self;
    [self.baseView addSubview:_pickerView];
    
    _tipLabel = [UILabel LabelWithFont:kSystemFont(32) andColor:COLORWITHHEX(@"#333333") andTextAlignment:center andString:@"出生年月"];
    [self.baseView addSubview:_tipLabel];
    
    //取消按钮
    _cancelButton = [[UIButton alloc] init];
    [_cancelButton setTitle:@"取消" forState:UIControlStateNormal];
    _cancelButton.titleLabel.font = kSystemFont(36);
    [_cancelButton setTitleColor:[UIColor colorWithHexString:@"#07C055"] forState:UIControlStateNormal];
    [_cancelButton addTarget:self action:@selector(clickCancelAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseView addSubview:_cancelButton];
    //确认按钮
    _confirmButton = [[UIButton alloc] init];
    [_confirmButton setTitle:@"保存" forState:UIControlStateNormal];
    _confirmButton.titleLabel.font = kSystemFont(36);
    [_confirmButton setTitleColor:[UIColor colorWithHexString:@"#07C055"] forState:UIControlStateNormal];
    [_confirmButton addTarget:self action:@selector(clickConfirmAction:) forControlEvents:UIControlEventTouchUpInside];
    [self.baseView addSubview:_confirmButton];
    
    [_tipLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.height.mas_equalTo(kWidth(40));
        make.centerY.equalTo(self.baseView.mas_top).offset(kWidth(40));
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
    
//    [self.pickerView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.left.right.bottom.mas_equalTo(self.baseView);
//        make.height.mas_equalTo(kWidth(200));
//    }];


}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismiss];
}





- (void)setCurrentDate:(NSDate *)currentDate
{
    _currentDate = currentDate;
    _yearArr   =  [LDDateModel getYearArrayWithCurrentDate:self.currentDate];
    _monthArr   = [LDDateModel getMonthArrayWithCurrentDate:self.currentDate];
    _dayArr   = [LDDateModel getDayArrayWithCurrentDate:self.currentDate];
    if (_currentDate) {
        _yearStr = [_yearArr lastObject];
        _monthStr = [_monthArr lastObject];
        _dayStr = [_dayArr lastObject];
        [self.pickerView reloadAllComponents];
        [self.pickerView selectRow:self.yearArr.count-1 inComponent:0 animated:YES];
        [self.pickerView selectRow:self.monthArr.count-1 inComponent:1 animated:YES];
        [self.pickerView selectRow:self.dayArr.count-1 inComponent:2 animated:YES];
        _dateStr = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld",(long)[_yearStr integerValue],(long)[_monthStr integerValue],(long)[_dayStr integerValue]];
//        if (self.confirmAction) {
//            _confirmAction(_dateStr);
//        }
    }
}





#pragma mark- UIPickerViewDataSource && UIPickerViewDelegate

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 3;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return self.yearArr.count;
            break;
        case 1:
            return self.monthArr.count;
            break;
        case 2:
            return self.dayArr.count;
            break;
        default:
            return 0;
            break;
    }
}

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%@",self.yearArr[row]];
            break;
        case 1:
            return [NSString stringWithFormat:@"%@",self.monthArr[row]];
            break;
        case 2:
            return [NSString stringWithFormat:@"%@",self.dayArr[row]];
            break;
        default:
            return 0;
            break;
    }
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    switch (component) {
        case 0:{
            _yearStr = _yearArr[row];
            _monthArr = [LDDateModel getCurrentMonthWithCurrentYear:_yearStr CurrentDate:self.currentDate];
            _monthStr = [_monthArr lastObject];
            _dayArr = [LDDateModel getCurrentDayWithCurrentYear:_yearStr CurrentMonth:_monthStr CurrentDate:self.currentDate];
            _dayStr = [_dayArr lastObject];
            [self.pickerView reloadComponent:1];
            [self.pickerView selectRow:_monthArr.count-1 inComponent:1 animated:YES];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:_dayArr.count-1 inComponent:2 animated:YES];
            break;
        }
        case 1:{
            _monthStr = _monthArr[row];
            _dayArr = [LDDateModel getCurrentDayWithCurrentYear:_yearStr CurrentMonth:_monthStr CurrentDate:self.currentDate];
            _dayStr = [_dayArr lastObject];
            [self.pickerView reloadComponent:2];
            [self.pickerView selectRow:_dayArr.count- 1 inComponent:2 animated:YES];
            break;
        }
        case 2:{
            _dayStr = _dayArr[row];
            break;
        }
        default:
            break;
    }
}

#pragma mark- Action
- (void)clickConfirmAction:(UIButton *)sender
{
    [self dismiss];
    NSString *dateStr = [NSString stringWithFormat:@"%ld-%.2ld-%.2ld",(long)[_yearStr integerValue],(long)[_monthStr integerValue],(long)[_dayStr integerValue]];
    if (self.confirmAction) {
        _confirmAction(dateStr);
    }
}
- (void)clickCancelAction:(UIButton *)sender
{
    [self dismiss];
    if (_cancelAction) {
        _cancelAction();
    }
    
}
- (void)show
{
    self.hidden = NO;
    self.dimView.hidden = NO;
    self.baseView.hidden = NO;
    [UIView animateWithDuration:0.3f animations:^{
        self.baseView.frame = CGRectMake(0, kScreenHeight-kWidth(480)-ExNavigationHeight- 44, kScreenWidth, kWidth(480));
    }];
}
- (void)dismiss
{
    
    [UIView animateWithDuration:0.3f animations:^{
        self.baseView.frame = CGRectMake(0, kScreenHeight, kScreenWidth, kWidth(480));
    }completion:^(BOOL finished) {
        self.hidden = YES;
        self.dimView.hidden = YES;
        self.baseView.hidden = YES;
    }];
}

- (void)setTipString:(NSString *)tipString
{
    _tipString = tipString;
    _tipLabel.text = tipString;
}
@end
