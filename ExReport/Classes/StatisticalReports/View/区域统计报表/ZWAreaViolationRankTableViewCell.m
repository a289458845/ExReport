//
//  ZWAreaViolationRankTableViewCell.m
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWAreaViolationRankTableViewCell.h"
#import "ZWAreaViolationRankModel.h"

@interface ZWAreaViolationRankTableViewCell ()

@property (weak, nonatomic) IBOutlet UIImageView *rankIcon;
@property (weak, nonatomic) IBOutlet UILabel *rankLab;
@property (weak, nonatomic) IBOutlet UILabel *areaLab;
@property (weak, nonatomic) IBOutlet UILabel *dataLab;

@end

@implementation ZWAreaViolationRankTableViewCell

- (void)setModel:(ZWAreaViolationRankModel *)model{
    _model = model;
    
    self.areaLab.text = model.RegionName;
    CGFloat rate =  [model.Rate floatValue];
    self.dataLab.text = [NSString stringWithFormat:@"%.2f%%",rate];
    
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
    self.dataLab.font = kSystemFont(28);
    
    self.rankLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.areaLab.textColor = COLORWITHHEX(kColor_3A3D44);
    self.dataLab.textColor = COLORWITHHEX(kColor_FB5E52);
    
}

- (void)setRank:(NSInteger)rank
{
    _rank = rank;
    
    if (rank == 1) {
        self.rankLab.alpha = 0;
        self.rankIcon.alpha = 1;
        self.rankIcon.image = [rTools getResourceImageName:@"commonreport_thelowest_first_icon@3x"];
    } else if (rank == 2) {
        self.rankLab.alpha = 0;
        self.rankIcon.alpha = 1;
        self.rankIcon.image = [rTools getResourceImageName:@"commonreport_thelowest_second_icon@3x"];
    } else if (rank == 3) {
        self.rankLab.alpha = 0;
        self.rankIcon.alpha = 1;
        self.rankIcon.image = [rTools getResourceImageName:@"commonreport_thelowest_third_icon@3x"];
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
