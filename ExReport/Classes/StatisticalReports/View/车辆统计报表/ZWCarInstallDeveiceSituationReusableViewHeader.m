//
//  ZWCarInstallDeveiceSituationReusableViewHeader.m
//  Muck
//
//  Created by 张威 on 2018/8/30.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarInstallDeveiceSituationReusableViewHeader.h"
#import "ZWDataItemsModel.h"
@interface ZWCarInstallDeveiceSituationReusableViewHeader ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (weak, nonatomic) IBOutlet UILabel *carPlateLab;
@property (weak, nonatomic) IBOutlet UILabel *timeLab;

@end

@implementation ZWCarInstallDeveiceSituationReusableViewHeader

- (void)setModel:(ZWDataItemsModel *)model{
    _carPlateLab.text = model.VehicleNo;
    _timeLab.text = model.InstallTime;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [rTools getCellWithName:NSStringFromClass([self class])];
    }
    return self;
}


- (void)awakeFromNib {
    [super awakeFromNib];
    
    self.bgView.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    
    self.lineView.backgroundColor = COLORWITHHEX(kColor_D9DCE3);
    self.carPlateLab.font = kSystemFont(30);
    self.carPlateLab.textColor = COLORWITHHEX(kColor_6D737F);
    
    self.timeLab.font = kSystemFont(24);
    self.timeLab.textColor = COLORWITHHEX(kColor_AFB4C0);
}
@end
