//
//  ZWStatisticalReportsCardView.m
//  Muck
//
//  Created by 张威 on 2018/7/24.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWStatisticalReportsCardView.h"
#import "ZWCompanyOnlineRateModel.h"
@interface ZWStatisticalReportsCardView ()

@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *onlineRateLab;


@end


@implementation ZWStatisticalReportsCardView

- (void)setModel:(ZWCompanyOnlineRateModel *)model{
    _model = model;
    _areaLab.text = model.DistName;
    _companyLab.text = model.Name;
    CGFloat onlineRate = [model.OnlineRate floatValue];
    _onlineRateLab.text = [NSString stringWithFormat:@"%.1f%%",onlineRate];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        self = [rTools getCellWithName:NSStringFromClass([self class])];
        self = [rTools getCellWithName:NSStringFromClass([self class])];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.titleLab.font = kSystemFont(28);
    self.areaLab.font = kSystemFont(28);
    self.companyLab.font = kSystemFont(28);
    self.onlineRateLab.font = kSystemFont(28);
    
    self.titleLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.areaLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.companyLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.onlineRateLab.textColor = COLORWITHHEX(kColor_3A3D44);
    
}
- (IBAction)clickAciton:(id)sender {
    [self.delegate ZWStatisticalReportsCardViewDidClick:self];
}

@end
