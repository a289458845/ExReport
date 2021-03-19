//
//  ZWCompanyViolationStatisticalDetailCell.m
//  Muck
//
//  Created by 张威 on 2018/8/11.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCompanyViolationStatisticalDetailCell.h"
#import "ZWAreaViolationRankModel.h"

@interface ZWCompanyViolationStatisticalDetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *lab1;
@property (weak, nonatomic) IBOutlet UILabel *lab2;
@property (weak, nonatomic) IBOutlet UILabel *lab3;

@end

@implementation ZWCompanyViolationStatisticalDetailCell

- (instancetype)initWithType:(ZWCompanyViolationStatisticalDetailCellType)type reuseIdentifier:(NSString *)reuseIdentifier
{
    if (self = [super initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:reuseIdentifier]) {
        self = [rTools getCellWithName:NSStringFromClass([self class])];
        self.type = type;
    }
    return self;
}

- (void)setRankModel:(ZWAreaViolationRankModel *)rankModel{
    _rankModel = rankModel;
    self.lab1.text = [NSString stringWithFormat:@"车辆总数(辆)：%.1f",[rankModel.TotalVeh floatValue]];
    self.lab2.text = [NSString stringWithFormat:@"违规时长(分钟)：%.1f",[rankModel.TotalMins floatValue]];
    self.lab3.text = [NSString stringWithFormat:@"里程(公里)：%.1f",[rankModel.TotalMileage floatValue]];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    self.lab1.font = kSystemFont(28);
    self.lab1.textColor = COLORWITHHEX(kColor_3A3D44);
    self.lab2.font = kSystemFont(28);
    self.lab2.textColor = COLORWITHHEX(kColor_3A3D44);
    self.lab3.font = kSystemFont(28);
    self.lab3.textColor = COLORWITHHEX(kColor_3A3D44);
    
    self.contentView.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    
}

- (void)setType:(ZWCompanyViolationStatisticalDetailCellType)type
{
    _type = type;
    
    switch (type) {
        case ZWCompanyViolationStatisticalDetailCellUnCloseness:
            self.lab1.text = @"车辆总数(辆)：";
            self.lab2.text = @"违规时长(分钟)：";
            self.lab3.text = @"里程(公里)：";
            break;
        case ZWCompanyViolationStatisticalDetailCellOverspeed:
            self.lab1.text = @"车辆总数(辆)：";
            self.lab2.text = @"超速时长(分钟)：";
            self.lab3.text = @"里程(公里)：";
            break;
            
        default:
            break;
    }
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
