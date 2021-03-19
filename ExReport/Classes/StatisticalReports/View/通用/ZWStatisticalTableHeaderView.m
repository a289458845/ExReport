//
//  ZWStatisticalTableHeaderView.m
//  Muck
//
//  Created by 张威 on 2018/8/7.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWStatisticalTableHeaderView.h"
#import <ExReport/ExDefine.h>
@interface ZWStatisticalTableHeaderView ()

@property (weak, nonatomic) IBOutlet UILabel *numLabel;
@property (weak, nonatomic) IBOutlet UILabel *numTypeLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeIntervalLabel;


@end

@implementation ZWStatisticalTableHeaderView

- (void)setNumCount:(NSString *)numCount{
    _numCount = numCount;
    _numLabel.text = numCount;
}

- (void)setTimeInterval:(NSString *)timeInterval{
    _timeInterval = timeInterval;
    _timeIntervalLabel.text = timeInterval;
}


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
    
    self.numLabel.font = kSystemFont(72);
    self.numTypeLabel.font = kSystemFont(24);
    self.timeIntervalLabel.font = kSystemFont(24);
    
    self.numLabel.textColor = COLORWITHHEX(kColor_FB6A5E);
    self.numTypeLabel.textColor = COLORWITHHEX(kColor_AFB4C0);
    self.timeIntervalLabel.textColor = COLORWITHHEX(kColor_6D737F);
    
 
}

-(void)setControllerType:(rSuspiciousViewControllerType)controllerType{
    _controllerType = controllerType;
    if (controllerType == rSuspiciousViewControllerWorkSite) {
        self.numTypeLabel.text = @"可疑工地(个)";
    }else if(controllerType == rSuspiciousViewControllerTypeAbsorptive){
        self.numTypeLabel.text = @"可疑消纳点(个)";
    }else if (controllerType == rSuspiciousViewControllerTypeAheadUnearth){
        self.numTypeLabel.text = @"提前出土工地(个)";
    }else if (controllerType == rSuspiciousViewControllerTypeBlackSite){
        self.numTypeLabel.text = @"黑土地(个)";
    }else{
        
    }
}


@end
