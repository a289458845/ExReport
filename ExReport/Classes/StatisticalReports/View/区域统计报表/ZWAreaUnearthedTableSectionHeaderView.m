//
//  ZWAreaUnearthedTableSectionHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/3.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWAreaUnearthedTableSectionHeaderView.h"

@interface ZWAreaUnearthedTableSectionHeaderView ()



@property (weak, nonatomic) IBOutlet UILabel *label1;//排名
@property (weak, nonatomic) IBOutlet UILabel *label2;//区域
@property (weak, nonatomic) IBOutlet UILabel *label3;//工地
@property (weak, nonatomic) IBOutlet UILabel *label4;//数据


@end

@implementation ZWAreaUnearthedTableSectionHeaderView

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
    
    self.label1.font = kSystemFont(28);
    self.label2.font = kSystemFont(28);
    self.label3.font = kSystemFont(28);
    self.label4.font = kSystemFont(28);
    
    self.label1.textColor = COLORWITHHEX(kColor_3A3D44);
    self.label2.textColor = COLORWITHHEX(kColor_3A3D44);
    self.label3.textColor = COLORWITHHEX(kColor_3A3D44);
    self.label4.textColor = COLORWITHHEX(kColor_3A3D44);    
}

- (void)setContentStr:(NSString *)contentStr{
    _contentStr = contentStr;
    _label4.text = contentStr;
}

- (void)setTypeStr:(NSString *)typeStr{
    _typeStr = typeStr;
    _label3.text = typeStr;
}

- (void)setTitleStr:(NSString *)titleStr{
    _titleStr = titleStr;
    _label2.text = titleStr;
}
@end



