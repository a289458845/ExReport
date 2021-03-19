//
//  ZWCarBaseInfoOneCell.m
//  Muck
//
//  Created by 张威 on 2018/10/30.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarBaseInfoOneCell.h"
#import "ZWDevVehicleStateModel.h"
#import "ZWVehicleIconStatusModel.h"

@interface ZWCarBaseInfoOneCell ()
@property(nonatomic,strong)UILabel *titleTypeLab;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UIView *dottedlineView;//虚线
@property(nonatomic,strong)UILabel *currentStatusPlaceHoldLab;
@property(nonatomic,strong)UILabel *currentSpeedPlaceHoldLab;
@property(nonatomic,strong)UILabel *finalLocationPlaceHoldLab;
@property(nonatomic,strong)UILabel *finalTimePlaceHoldLab;

@end
@implementation ZWCarBaseInfoOneCell

- (void)setImgArray:(NSMutableArray *)imgArray{
    _imgArray = imgArray;
    if (imgArray.count == 0) {
        return;
    }
    //移除之前创建的
    for (UIImageView *imgView in self.imgBaseView.subviews) {
        [imgView removeFromSuperview];
    }

    CGFloat leftMarign = kWidth(56);
    CGFloat middleMarign = kWidth(40);
    CGFloat topMarign = kWidth(0);
    CGFloat marginH = kWidth(10);
    CGFloat imgW = kWidth(122);
    CGFloat imgH = kWidth(132);
    NSInteger maxCol = 4;
    
    for (NSInteger  i = 0; i < imgArray.count; i++) {
        UIImageView *imgView = [[UIImageView alloc]init];
        NSInteger col = i % maxCol; //列
        NSInteger row = i / maxCol; //行
        CGFloat x =  leftMarign + col * (imgW + middleMarign);
        CGFloat y = topMarign + row * (imgH + marginH);
        imgView.frame = CGRectMake(x, y, imgW, imgH);
        imgView.image = [UIImage imageNamed:imgArray[i]];
        [self.imgBaseView addSubview:imgView];
    }

}

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = COLORWITHHEX(kColor_FFFFFF);
        [self setupUI];
        [self setupConstraint];
    }
    return self;
}


- (void)setupUI{
    
    self.titleTypeLab = [UILabel LabelWithFont:kSystemFont(32) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"实时监控"];
    
    self.lineView = [[UIView alloc]init];
    self.lineView.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    
    self.imgBaseView = [[UIView alloc]init];

    //当前状态
    self.currentStatusPlaceHoldLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"当前状态:"];
    self.currentStatusLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_5490EB) andTextAlignment:left];
    //速度
    self.currentSpeedPlaceHoldLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"速      度:"];
    self.currentSpeedLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left];
    //最后位置
    self.finalLocationPlaceHoldLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"最后位置:"];
    self.finalLocationLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left];
     self.finalLocationLab.numberOfLines = 0;
    //最后定位时间
    self.finalTimePlaceHoldLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_3A3D44) andTextAlignment:left andString:@"最后定位时间:"];
    self.finalTimeLab = [UILabel LabelWithFont:kSystemFont(30) andColor:COLORWITHHEX(kColor_6D737F) andTextAlignment:left];
    self.finalTimeLab.numberOfLines = 0;
    
    [self addSubview:self.titleTypeLab];
    [self addSubview:self.lineView];
    [self addSubview:self.imgBaseView];
    
    [self addSubview:self.currentStatusPlaceHoldLab];
    [self addSubview:self.currentStatusLab];
    
    [self addSubview:self.currentSpeedPlaceHoldLab];
    [self addSubview:self.currentSpeedLab];
    
    [self addSubview:self.finalLocationPlaceHoldLab];
    [self addSubview:self.finalLocationLab];
    
    [self addSubview:self.finalTimePlaceHoldLab];
    [self addSubview:self.finalTimeLab];
}

- (void)setupConstraint{
    [self.titleTypeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(30));
        make.centerY.equalTo(self.mas_top).offset(kWidth(48));
    }];
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(self);
        make.top.equalTo(self.mas_top).offset(kWidth(96));
        make.height.mas_equalTo(kWidth(1));
    }];
    [self.imgBaseView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).offset(kWidth(25));
        make.left.right.equalTo(self);
        make.height.mas_equalTo(kWidth(274));
    }];
    
    [self.currentStatusPlaceHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(56));
        make.top.equalTo(self.imgBaseView.mas_bottom).offset(kWidth(35));
    }];
    [self.currentStatusLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentStatusPlaceHoldLab.mas_right).offset(kWidth(20));
        make.centerY.equalTo(self.currentStatusPlaceHoldLab);
    }];
    
    [self.currentSpeedPlaceHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(56));
        make.top.equalTo(self.currentStatusPlaceHoldLab.mas_bottom).offset(kWidth(24));
    }];
    [self.currentSpeedLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.currentStatusPlaceHoldLab.mas_right).offset(kWidth(20));
        make.centerY.equalTo(self.currentSpeedPlaceHoldLab);
    }];
    
    [self.finalLocationPlaceHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(56));
        make.top.equalTo(self.currentSpeedPlaceHoldLab.mas_bottom).offset(kWidth(24));
      
    }];
    [self.finalLocationLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.finalLocationPlaceHoldLab.mas_right).offset(kWidth(20));
        make.right.equalTo(self.mas_right).offset(kWidth(-30));
        make.top.equalTo(self.finalLocationPlaceHoldLab.mas_top);
    }];
    
    [self.finalTimePlaceHoldLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self).offset(kWidth(56));
        make.top.equalTo(self.finalLocationLab.mas_bottom).offset(kWidth(24));
          make.width.mas_equalTo(kWidth(200));
    }];
    [self.finalTimeLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.finalTimePlaceHoldLab.mas_right).offset(kWidth(20));
        make.right.equalTo(self.mas_right).offset(kWidth(-30));
        make.top.equalTo(self.finalTimePlaceHoldLab.mas_top);
    }];
}

- (void)drawRect:(CGRect)rect{
    CAShapeLayer *dotteShapeLayer = [CAShapeLayer layer];
    CGMutablePathRef dotteShapePath =  CGPathCreateMutable();
    //设置虚线颜色为blackColor
    [dotteShapeLayer setStrokeColor:COLORWITHHEX(kColor_EDF0F4).CGColor];
    //设置虚线宽度
    dotteShapeLayer.lineWidth = kWidth(1) ;
    //10=线的宽度 5=每条线的间距
    NSArray *dotteShapeArr = [[NSArray alloc] initWithObjects:[NSNumber numberWithInt:10],[NSNumber numberWithInt:5], nil];
    [dotteShapeLayer setLineDashPattern:dotteShapeArr];
    CGPathMoveToPoint(dotteShapePath, NULL, 0 ,CGRectGetMaxY(self.imgBaseView.frame)+kWidth(25));
    CGPathAddLineToPoint(dotteShapePath, NULL, self.bounds.size.width, CGRectGetMaxY(self.imgBaseView.frame)+kWidth(25));
    [dotteShapeLayer setPath:dotteShapePath];
    CGPathRelease(dotteShapePath);
    //把绘制好的虚线添加上来
    [self.layer addSublayer:dotteShapeLayer];

    
}


@end
