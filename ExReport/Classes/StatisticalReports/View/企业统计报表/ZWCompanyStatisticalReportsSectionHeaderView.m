//
//  ZWCompanyStatisticalReportsSectionHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCompanyStatisticalReportsSectionHeaderView.h"

@interface ZWCompanyStatisticalReportsSectionHeaderView ()
@property (weak, nonatomic) IBOutlet UILabel *rankLab;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;



@end

@implementation ZWCompanyStatisticalReportsSectionHeaderView

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
    self.areaLab.font = kSystemFont(28);
    self.companyLab.font = kSystemFont(28);
    self.dataLab.font = kSystemFont(28);
    
    self.rankLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.areaLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.companyLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.dataLab.textColor = COLORWITHHEX(kColor_3A3D44);
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _areaLab.text = titleStr;
}

- (void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
    _dataLab.text = contentStr;
}

- (void)setTypeStr:(NSString *)typeStr{
    _typeStr = typeStr;
    _companyLab.text = typeStr;
}

@end
