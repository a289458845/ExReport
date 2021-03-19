//
//  ZWKeykeyMonitoringTableViewCell.m
//  Muck
//
//  Created by 张威 on 2018/8/16.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWKeykeyMonitoringTableViewCell.h"
#import "ZWkeyMonitoringModel.h"
@interface ZWKeykeyMonitoringTableViewCell ()
@property (weak, nonatomic) IBOutlet UILabel *lab;

@end


@implementation ZWKeykeyMonitoringTableViewCell
- (void)setModel:(ZWkeyMonitoringModel *)model{
    _model = model;
    _lab.text = model.Name;
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
    
    self.lab.font =kSystemFont(32);
    self.lab.textColor = COLORWITHHEX(kColor_6D737F);
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
