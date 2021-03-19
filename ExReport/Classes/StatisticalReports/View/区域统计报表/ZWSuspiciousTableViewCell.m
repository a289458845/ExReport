//
//  ZWSuspiciousTableViewCell.m
//  Muck
//
//  Created by 张威 on 2018/8/10.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWSuspiciousTableViewCell.h"
#import "ZWSusUnearthedDetailRankModel.h"
#import "ZWInadvanceSiteRegionModel.h"
#import "ZWSiteStaticModel.h"
#import "ZWBlackSiteRegionModel.h"
@interface ZWSuspiciousTableViewCell ()
@property (weak, nonatomic) IBOutlet UIView *bgView;
@property (weak, nonatomic) IBOutlet UILabel *itemNameLab;
@property (weak, nonatomic) IBOutlet UILabel *numberLab;
@property (weak, nonatomic) IBOutlet UILabel *unitLab;


@end

@implementation ZWSuspiciousTableViewCell

- (void)setModel:(ZWSusUnearthedDetailRankModel *)model{
    _model = model;
    _itemNameLab.text = model.UnLoadName;
    _numberLab.text = model.Unearthed;
}

- (void)setRegionModel:(ZWInadvanceSiteRegionModel *)regionModel{
    _regionModel = regionModel;
    _itemNameLab.text = regionModel.RegionName;
    _numberLab.text = regionModel.SiteCount;
}


- (void)setSiteStaticModel:(ZWSiteStaticModel *)siteStaticModel{
    _siteStaticModel = siteStaticModel;
    _itemNameLab.text = siteStaticModel.Name;
    _numberLab.text = siteStaticModel.Unearthed;
}

- (void)setBlackModel:(ZWBlackSiteRegionModel *)blackModel{
    _blackModel = blackModel;
    _itemNameLab.text = blackModel.RegionName;
    _numberLab.text = blackModel.TotalCount;
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
    
    self.itemNameLab.font = kSystemFont(30);
    self.itemNameLab.textColor = COLORWITHHEX(kColor_3A3D44);
    
    self.numberLab.font = kSystemFont(36);
    self.numberLab.textColor = COLORWITHHEX(kColor_5490EB);
    
    self.unitLab.font = kSystemFont(20);
    self.unitLab.textColor = COLORWITHHEX(kColor_AFB4C0);
    
    self.bgView.layer.cornerRadius = 3;
    self.bgView.layer.masksToBounds = YES;
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
