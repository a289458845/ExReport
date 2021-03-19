//
//  ZWTrackDetailBottomView.m
//  Muck
//
//  Created by 邵明明 on 2018/8/30.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWTrackDetailBottomView.h"
#import "NSString+StringSize.h"
#import "ZWHisLocStatModel.h"
@interface ZWTrackDetailBottomView()
@property (nonatomic,strong)UIButton *playBtn;
@property (nonatomic,strong)UIButton *popBtn;
@property (nonatomic,strong)UISlider *slider;
@property (nonatomic,strong)UILabel *starHourLabel;
@property (nonatomic,strong)UILabel *endHourLabel;
@property (nonatomic,assign)NSInteger sliderIndex;
@end

@implementation ZWTrackDetailBottomView


- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, kScreenHeight-ExNavigationHeight-kWidth(88)-ExSafeAreaBottom, kScreenWidth, kWidth(88)+ExSafeAreaBottom);
        self.backgroundColor = COLORWITHHEX(@"#EDF0F4");
        _sliderIndex = 0;
        [self setupUI];
        [self setupConstraint];
    }
    return self;
}
- (void)setupUI{
    
    _playBtn = [UIButton new];
    _playBtn.selected = NO;
    [_playBtn addTarget:self action:@selector(startButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"trackdetails_vedio_play"] forState:UIControlStateNormal];
    [_playBtn setBackgroundImage:[UIImage imageNamed:@"trackdetails_vedio_pause"] forState:UIControlStateSelected];
    [self addSubview:_playBtn];
    
    _popBtn = [UIButton new];
    [_popBtn addTarget:self action:@selector(PopButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [_popBtn setTitle:@"气泡" forState:UIControlStateNormal];
    [_popBtn setTitleColor:COLORWITHHEX(@"#FFFFFF") forState:UIControlStateNormal];
    _popBtn.titleLabel.font = kSystemFont(24);
    [_popBtn setBackgroundImage:[UIImage imageNamed:@"trackdetails_tips"] forState:UIControlStateNormal];
    [_popBtn setBackgroundImage:[UIImage imageNamed:@"trackdetails_tips"] forState:UIControlStateSelected];
    [self addSubview:_popBtn];
    
    _starHourLabel = [UILabel LabelWithFont:kSystemFont(16) andColor:COLORWITHHEX(@"#6D737F") andTextAlignment:left andString:@"00:00:00"];
    [self addSubview:_starHourLabel];
    
    _endHourLabel = [UILabel LabelWithFont:kSystemFont(16) andColor:COLORWITHHEX(@"#6D737F") andTextAlignment:right andString:@"00:00:00"];
    [self addSubview:_endHourLabel];
    
    _slider = [UISlider new];
    _slider.thumbTintColor = COLORWITHHEX(@"#37A4FA");
    _slider.maximumTrackTintColor = COLORWITHHEX(@"#D9DCE3");
    _slider.minimumTrackTintColor = COLORWITHHEX(@"#37A4FA");
    [_slider addTarget:self action:@selector(sliderValueChanged:) forControlEvents:UIControlEventValueChanged];
    [_slider addTarget:self action:@selector(sliderTouchDown:) forControlEvents:UIControlEventTouchDown];
    [_slider addTarget:self action:@selector(sliderTouchUpInSide:) forControlEvents:UIControlEventTouchUpInside];
    
    [self addSubview:_slider];
}

- (void)setupConstraint{

    [_starHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self).offset(kWidth(110));
        make.centerY.mas_equalTo(self);
    }];
    
    [_endHourLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.mas_equalTo(self).offset(kWidth(-110));
        make.centerY.mas_equalTo(self);
    }];
    
    [_playBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.left.mas_equalTo(self).offset(kWidth(20));
    }];
    
    [_popBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.mas_equalTo(self);
        make.right.mas_equalTo(self).offset(kWidth(-20));
    }];
    
    [_slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.centerX.mas_equalTo(self);
        make.width.mas_equalTo(kWidth(400));
    }];
}


- (void)setCount:(NSInteger)count
{
    _count = count;
    _slider.maximumValue = _count;
    _slider.minimumValue = 0;
}

- (void)setProgress:(CGFloat)progress
{
    _progress = progress;
    _slider.maximumValue = _count;
    _slider.minimumValue = 0;
    _slider.value = _count*_progress;
}

- (void)setStartTime:(NSString *)startTime
{
    _startTime = startTime;
    _starHourLabel.text = _startTime;
}
- (void)setEndTime:(NSString *)endTime
{
    _endTime = endTime;
    _endHourLabel.text = _endTime;
}
- (void)   setPlayButtonSelected:(BOOL)playButtonSelected
{
    _playButtonSelected = playButtonSelected;
    self.playBtn.selected = playButtonSelected;
}

- (void)PopButtonDidClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    [_delegate zWTrackDetailBottomViewDidClickPopButtonWithisShow:!sender.selected];
}
- (void)startButtonDidClick:(UIButton *)sender
{
    sender.selected = !sender.selected;
    if (!sender.selected) {//暂停
        [_delegate zWTrackDetailBottomViewDidClickEndButtonWithIndex:_sliderIndex];
    }else{
        [_delegate zWTrackDetailBottomViewDidClickStartButtonWithIndex:_sliderIndex];
    }
}

- (void)sliderTouchUpInSide:(UISlider *)slider
{
    [_delegate zWTrackDetailBottomViewDidSlidingToIndex:(NSInteger)slider.value];
}
- (void)sliderTouchDown:(UISlider *)slider
{
    [_delegate zWTrackDetailBottomViewBeginSliding];
}
- (void)sliderValueChanged:(UISlider *)slider
{
    if ((NSInteger)slider.value >= _count) {
        [_delegate zWTrackDetailBottomViewDidSlidingToIndex:(NSInteger)slider.value];
    }
}



@end
