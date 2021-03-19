//
//  ZWCommonTableViewCell.m
//  Muck
//
//  Created by 张威 on 2018/7/29.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCommonTableViewCell.h"
#import "ZWUnearthedDetailRankModel.h"
#import "ZWCompanyOnlineRateModel.h"
@interface ZWCommonTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *rankIcon;
@property (weak, nonatomic) IBOutlet UILabel *rankLab;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *onlineRateLab;



@end

@implementation ZWCommonTableViewCell

- (void)setRateModel:(ZWCompanyOnlineRateModel *)rateModel{
    _rateModel = rateModel;
    _areaLab.text = rateModel.DistName;
    _companyLab.text = rateModel.Name;
    _onlineRateLab.text = [NSString stringWithFormat:@"%@%%",rateModel.OnlineRate];
}

- (void)setModel:(ZWUnearthedDetailRankModel *)model{
    _model = model;
    
    _areaLab.text = model.DeptmentName;
    _companyLab.text = model.SiteName;
    _onlineRateLab.text = [NSString stringWithFormat:@"%.1lf",[model.Unearthed floatValue]];
}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self = [rTools getCellWithName:NSStringFromClass([self class])];
    }
    return self;
}



- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.rankLab.font = kSystemFont(28);
    self.areaLab.font = kSystemFont(28);
    self.companyLab.font = kSystemFont(28);
    self.onlineRateLab.font = kSystemFont(28);
    
    self.rankLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.areaLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.companyLab.textColor = COLORWITHHEX(kColor_3A62AC);
    self.onlineRateLab.textColor = COLORWITHHEX(kColor_FB5E52);
}

- (void)setRank:(NSInteger)rank
{
    _rank = rank;
    
    if (rank == 1) {
        self.rankLab.alpha = 0;
        self.rankIcon.alpha = 1;
        self.rankIcon.image = [rTools getResourceImageName:@"commonreport_thehighest_first_icon@3x"];
    } else if (rank == 2) {
        self.rankLab.alpha = 0;
        self.rankIcon.alpha = 1;
        self.rankIcon.image = [rTools getResourceImageName:@"commonreport_thehighest_second_icon@3x"];
    } else if (rank == 3) {
        self.rankLab.alpha = 0;
        self.rankIcon.alpha = 1;
        self.rankIcon.image = [rTools getResourceImageName:@"commonreport_thehighest_third_icon@3x"];
    } else {
        self.rankLab.alpha = 1;
        self.rankIcon.alpha = 0;
        self.rankLab.text = [NSString stringWithFormat:@"%ld",(long)rank];
    }
}
- (IBAction)companyClick:(id)sender {
    [self.delegate ZWCommonTableViewCellSelectedCompany:self];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
