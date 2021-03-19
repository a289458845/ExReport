//
//  ZWCarStatisticalReportsTableViewCell.m
//  Muck
//
//  Created by 张威 on 2018/8/12.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarStatisticalReportsTableViewCell.h"
#import "ZWCarOnlineModel.h"
@interface ZWCarStatisticalReportsTableViewCell ()


@property (weak, nonatomic) IBOutlet UILabel *rankLab;
@property (weak, nonatomic) IBOutlet UIImageView *rankIcon;
@property (weak, nonatomic) IBOutlet UILabel *companyLab;
@property (weak, nonatomic) IBOutlet UILabel *licenseLab;
@property (weak, nonatomic) IBOutlet UILabel *onlineRateLab;
@property (weak, nonatomic) IBOutlet UILabel *onlineTimeLab;

@end

@implementation ZWCarStatisticalReportsTableViewCell

- (void)setModel:(ZWCarOnlineModel *)model{
    _model = model;
    _companyLab.text = model.Name;
    _licenseLab.text = model.VehicleNo;
    _onlineRateLab.text = model.OnLineRate;
    _onlineTimeLab.text = [NSString stringWithFormat:@"%.2f",[model.Hour floatValue]];
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
    self.companyLab.font = kSystemFont(28);
    self.licenseLab.font = kSystemFont(28);
    self.onlineRateLab.font = kSystemFont(28);
    self.onlineTimeLab.font = kSystemFont(28);
    
    self.rankLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.companyLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.licenseLab.textColor = COLORWITHHEX(kColor_3A62AC);
    self.onlineRateLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.onlineTimeLab.textColor = COLORWITHHEX(kColor_FB5E52);
}

- (void)setRank:(NSInteger)rank
{
    _rank = rank;
    UIImage *image1;
    UIImage *image2;
    UIImage *image3;
    
    image1 = [rTools getResourceImageName:@"commonreport_thehighest_first_icon@3x"];
    image2 = [rTools getResourceImageName:@"commonreport_thehighest_second_icon@3x"];
    image3 = [rTools getResourceImageName:@"commonreport_thehighest_third_icon@3x"];
    
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


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
