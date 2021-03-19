//
//  ZWCarInstallDeviceOtherListCell.m
//  Muck
//
//  Created by 张威 on 2018/8/31.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWCarInstallDeviceOtherListCell.h"
#import "ZWChildDataModel.h"
@interface ZWCarInstallDeviceOtherListCell ()

@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *companyNameLab;
@property (weak, nonatomic) IBOutlet UILabel *countLab;

@end
@implementation ZWCarInstallDeviceOtherListCell

-(void)setModel:(ZWChildDataModel *)model{
    _model = model;
    _companyNameLab.text = model.Name;
    _countLab.text = [NSString stringWithFormat:@"%@台",model.VehCount];
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
  
    
    self.companyNameLab.font = kSystemFont(30);
    self.companyNameLab.textColor = COLORWITHHEX(kColor_3A3D44);
    
    self.countLab.font = kSystemFont(36);
    self.countLab.textColor = COLORWITHHEX(kColor_5490EB);
    
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}



@end
