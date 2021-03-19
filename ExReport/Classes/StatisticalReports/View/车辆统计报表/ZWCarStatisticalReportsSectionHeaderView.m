//
//  ZWCarStatisticalReportsSectionHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarStatisticalReportsSectionHeaderView.h"

@interface ZWCarStatisticalReportsSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *rankLab;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *licenseLab;
@property (weak, nonatomic) IBOutlet UILabel *onlineRateLab;
@property (weak, nonatomic) IBOutlet UILabel *onlineTimeLab;



@end

@implementation ZWCarStatisticalReportsSectionHeaderView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [rTools getCellWithName:NSStringFromClass([self class])];
    }
    return self;
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.rankLab.font = kSystemFont(28);
    self.companyLab.font = kSystemFont(28);
    self.licenseLab.font = kSystemFont(28);
    self.onlineRateLab.font = kSystemFont(28);
    self.onlineTimeLab.font = kSystemFont(28);
    
    self.rankLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.companyLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.licenseLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.onlineRateLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.onlineTimeLab.textColor = COLORWITHHEX(kColor_3A3D44);
}

@end
