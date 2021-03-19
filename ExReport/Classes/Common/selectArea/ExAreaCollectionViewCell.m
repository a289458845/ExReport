//
//  ExAreaCollectionViewCell.m
//  ExCheckCar
//
//  Created by exsun on 2021/1/21.
//

#import "ExAreaCollectionViewCell.h"
#import "ZWRegionModel.h"
#import "ExDefine.h"
@implementation ExAreaCollectionViewCell
- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupUI];
        [self setupConstaint];
    }
    return self;
}

- (void)setupUI{
    self.areaBtn = [[UIButton alloc]init];
    self.areaBtn.userInteractionEnabled = NO;
    self.areaBtn.titleLabel.font = kSystemFont(28);
    [self.areaBtn setTitleColor:COLORWITHHEX(kColor_6D737F) forState:UIControlStateNormal];
    self.areaBtn.layer.borderColor = COLORWITHHEX(kColor_3A62AC).CGColor;
    self.areaBtn.layer.borderWidth = kWidth(2);
    self.areaBtn.layer.cornerRadius = kWidth(6);
    self.areaBtn.clipsToBounds = YES;
    [self addSubview:self.areaBtn];
}

- (void)setupConstaint{
    [self.areaBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.top.bottom.equalTo(self);
    }];
}
@end
