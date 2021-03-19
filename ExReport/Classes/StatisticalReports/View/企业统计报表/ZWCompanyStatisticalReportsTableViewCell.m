//
//  ZWCompanyStatisticalReportsTableViewCell.m
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCompanyStatisticalReportsTableViewCell.h"
#import "ZWCompanyBaseDataRankModel.h"
#import "ZWAreaViolationRankModel.h"
#import "ZWCarUnClosenessModel.h"
#import "ZWSingleMonitoringModel.h"
@interface ZWCompanyStatisticalReportsTableViewCell ()

@property (weak, nonatomic) IBOutlet UILabel *rankLab;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;
@property (weak, nonatomic) IBOutlet UIImageView *rankIcon;
@property (weak, nonatomic) IBOutlet UIButton *companyTap;

@end

@implementation ZWCompanyStatisticalReportsTableViewCell
- (void)setSingleMonitoringModel:(ZWSingleMonitoringModel *)singleMonitoringModel{
    _singleMonitoringModel = singleMonitoringModel;
    _areaLab.text = singleMonitoringModel.CmpName;
    _companyLab.text = singleMonitoringModel.VehicleNo;
    _dataLab.text = singleMonitoringModel.Count;
}

- (void)setClosenessModel:(ZWCarUnClosenessModel *)closenessModel{
    _closenessModel = closenessModel;
    _areaLab.text = closenessModel.CmpName;
    _dataLab.text = [NSString stringWithFormat:@"%.2f",[closenessModel.Mins floatValue]];
    _companyLab.text = closenessModel.VehicleNo;
}

- (void)setModel:(ZWCompanyBaseDataRankModel *)model{
    _model = model;
    _areaLab.text = model.DistName;
    _companyLab.text = model.Name;
    _dataLab.text = [NSString stringWithFormat:@"%.1f",[model.Cube floatValue]];
}


- (void)setRankModel:(ZWAreaViolationRankModel *)rankModel{
    _rankModel = rankModel;
    _areaLab.text = rankModel.RegionName;
    _companyLab.text = rankModel.EnterpriseName;
    _dataLab.text = [NSString stringWithFormat:@"%.1f%%",[rankModel.Rate floatValue]];
}

- (void)setUnearthedModel:(ZWAreaViolationRankModel *)unearthedModel{
    _unearthedModel = unearthedModel;
    _areaLab.text = unearthedModel.RegionName;
    _companyLab.text = unearthedModel.SiteName;
    _dataLab.text = [NSString stringWithFormat:@"%.1f",[unearthedModel.Rate floatValue]];
}


- (instancetype)initWithType:(ZWCompanyStatisticalReportsTableViewCellType)type reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self = [rTools getCellWithName:NSStringFromClass([self class])];
        self.type = type;

    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.rankLab.font = kSystemFont(28);
    self.areaLab.font = kSystemFont(28);
    self.companyLab.font = kSystemFont(28);
    self.dataLab.font = kSystemFont(28);
    
    self.rankLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.areaLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.companyLab.textColor = COLORWITHHEX(kColor_3A62AC);
    self.dataLab.textColor = COLORWITHHEX(kColor_FB5E52);
    
    
}




- (void)setRank:(NSInteger)rank{
    _rank = rank;
    UIImage *image1;
    UIImage *image2;
    UIImage *image3;
    
    
    if (self.type == ZWCompanyStatisticalReportsTableViewCellUnearthed) {
        image1 = [rTools getResourceImageName:@"commonreport_thehighest_first_icon@3x"];
        image2 = [rTools getResourceImageName:@"commonreport_thehighest_second_icon@3x"];
        image3 = [rTools getResourceImageName:@"commonreport_thehighest_third_icon@3x"];
    }
    if (self.type == ZWCompanyStatisticalReportsTableViewCellUnCloseness) {
        
        image1 = [rTools getResourceImageName:@"commonreport_thelowest_first_icon@3x"];
        image2 = [rTools getResourceImageName:@"commonreport_thelowest_second_icon@3x"];
        image3 = [rTools getResourceImageName:@"commonreport_thelowest_third_icon@3x"];
        
    }
    if (self.type == ZWCompanyStatisticalReportsTableViewCellOverspeed) {
        image1 = [rTools getResourceImageName:@"commonreport_thehighest_first_icon@3x"];
        image2 = [rTools getResourceImageName:@"commonreport_thehighest_second_icon@3x"];
        image3 = [rTools getResourceImageName:@"commonreport_thehighest_third_icon@3x"];
    }
    if (rank == 1) {
        self.rankLab.alpha = 0;
        self.rankIcon.alpha = 1;
        self.rankIcon.image = image1;
    } else if (rank == 2) {
        self.rankLab.alpha = 0;
        self.rankIcon.alpha = 1;
        self.rankIcon.image = image2;
    } else if (rank == 3) {
        self.rankLab.alpha = 0;
        self.rankIcon.alpha = 1;
        self.rankIcon.image = image3;
    } else {
        self.rankLab.alpha = 1;
        self.rankIcon.alpha = 0;
        self.rankLab.text = [NSString stringWithFormat:@"%ld",(long)rank];
    }
}

- (void)setType:(ZWCompanyStatisticalReportsTableViewCellType)type
{
    _type = type;
    
    if (self.type == ZWCompanyStatisticalReportsTableViewCellUnearthed) {
        self.companyTap.enabled = NO;
    }
    if (self.type == ZWCompanyStatisticalReportsTableViewCellUnCloseness) {
        self.companyTap.enabled = YES;
    }
    if (self.type == ZWCompanyStatisticalReportsTableViewCellOverspeed) {
        self.companyTap.enabled = YES;
    }
}
- (IBAction)companyAction:(id)sender {
    
    if (self.type == ZWCompanyStatisticalReportsTableViewCellUnCloseness || self.type == ZWCompanyStatisticalReportsTableViewCellOverspeed) {
        if ([self.delegate respondsToSelector:@selector(companyStatisticalReportsTableViewCellDidSelectCompany:)]) {
            [self.delegate companyStatisticalReportsTableViewCellDidSelectCompany:self];
        }
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
