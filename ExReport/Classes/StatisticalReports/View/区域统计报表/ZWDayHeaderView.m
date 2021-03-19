//
//  ZWDayHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWDayHeaderView.h"


@interface ZWDayHeaderView ()<ZWDayWeekMonthViewDelegate>

@property (strong, nonatomic) ZWDayWeekMonthView *dayWeekMonthView;
@property (nonatomic, strong) UILabel *dateLab;
@property (nonatomic, weak) UIImageView *imgView;


@end

@implementation ZWDayHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self initUI];
//        self.type = ZWDayWeekMonth;
    }
    return self;
}

- (void)setTimeString:(NSString *)timeString{
    _timeString = timeString;
    _dateLab.text = timeString;
}
- (void)setType:(ZWDayWeekMonthType)type
{
    _type = type;
    [self initWithType:type];
}

- (void)initWithType:(ZWDayWeekMonthType)type
{
    self.backgroundColor = COLORWITHHEX(kColor_3A62AC);
    
    self.dayWeekMonthView = [[ZWDayWeekMonthView alloc] initWithFrame:CGRectMake(0, 0, self.frame.size.width, kWidth(100)) type:type];
    self.dayWeekMonthView.delegate = self;
    
    [self addSubview:self.dayWeekMonthView];
    
    self.dateLab = [[UILabel alloc] init];
    self.dateLab.font = kSystemFont(28);
    self.dateLab.textColor = [UIColor whiteColor];
    [self addSubview:self.dateLab];
    
    UIImageView *img = [[UIImageView alloc] init];
    img.image = [UIImage imageNamed:@"commonreport_optiondate_pulldown_icon"];
    [self addSubview:img];
    self.imgView = img;
    
//    [self.dayWeekMonthView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.equalTo(self).offset(kWidth(20));
//        make.left.right.equalTo(self);
//        make.height.mas_offset(kWidth(100));
//    }];

    [img mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self).offset(-kWidth(30));
        //        make.top.equalTo(self).offset(kWidth(30));
    }];

    [self.dateLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.dayWeekMonthView.mas_bottom).offset(kWidth(10));
        make.right.equalTo(img.mas_left).offset(-kWidth(6));
        make.centerY.equalTo(img);
        make.bottom.equalTo(self).offset(-kWidth(30));
    }];
    
   
}

- (void)ZWDayWeekMonthViewSegmentedControlClick:(NSInteger )index{
    if (self.delegate && [self.delegate respondsToSelector:@selector(dayHeaderViewSelectedIndex:)]) {
        [self.delegate dayHeaderViewSelectedIndex:index];
    }
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    CGPoint point = [touches.anyObject locationInView:self];
    if (point.y >= kWidth(110) && point.y < kWidth(110)+11) {
        if (self.didSelectTimeBlock) {
            self.didSelectTimeBlock();
        }
    }
}





@end
