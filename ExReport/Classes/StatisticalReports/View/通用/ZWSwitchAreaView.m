//
//  ZWSwitchAreaView.m
//  Muck
//
//  Created by 张威 on 2018/8/5.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWSwitchAreaView.h"

@interface ZWSwitchAreaView ()

@property (weak, nonatomic) IBOutlet UILabel *lastLabel;
@property (weak, nonatomic) IBOutlet UILabel *currentLabel;
@property (weak, nonatomic) IBOutlet UILabel *nextLabel;

@property (nonatomic) NSInteger index;

@end

@implementation ZWSwitchAreaView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self = [rTools getCellWithName:NSStringFromClass([self class])];
        self.index = 0;
    }
    return self;
}


- (void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    
    self.lastLabel.font = kSystemFont(32);
    self.currentLabel.font = kSystemFont(32);
    self.nextLabel.font = kSystemFont(32);
    
    self.lastLabel.textColor = COLORWITHHEX(kColor_AFB4C0);
    self.nextLabel.textColor = COLORWITHHEX(kColor_AFB4C0);
    self.currentLabel.textColor = COLORWITHHEX(kColor_3A62AC);
    
//    [self updateIndex];
}

- (void)setDataSource:(NSArray *)dataSource
{
    if (dataSource.count == 0) {
        return;
    }
    self.currentLabel.text = dataSource.firstObject;
    if (dataSource.count == 1) {
        self.lastLabel.hidden = YES;
        self.nextLabel.hidden = YES;
    }
    if (dataSource.count == 2) {
        self.lastLabel.hidden = NO;
        self.nextLabel.hidden = NO;
        self.lastLabel.text = dataSource.lastObject;
        self.nextLabel.text = dataSource.lastObject;
    }
    if (dataSource.count > 2) {
        self.lastLabel.hidden = NO;
        self.nextLabel.hidden = NO;
        self.lastLabel.text = dataSource.lastObject;
        self.nextLabel.text = dataSource[1];
    }
    _dataSource = dataSource;
    
}



- (void)setSelectedIndex:(NSInteger)selectedIndex
{
    if (selectedIndex > self.dataSource.count-1) {
        return;
    }
    _selectedIndex = selectedIndex;
    self.index = selectedIndex;
    [self updateIndex];
}

- (IBAction)lastAction:(id)sender {
    
    self.index--;
    if (self.index == -1) {
        self.index--;
    }
    
    [self updateIndex];
    
    if ([self.delegate respondsToSelector:@selector(switchAreaView:didClickLastWithCurrentIndex:currentTitle:)]) {
        [self.delegate switchAreaView:self didClickLastWithCurrentIndex:self.currentLabel.tag currentTitle:self.dataSource[self.currentLabel.tag]];
    }
    
}
- (IBAction)nextAction:(id)sender {
    
    self.index++;
    if (self.index == -1) {
        self.index++;
    }
    
    [self updateIndex];
    
    if ([self.delegate respondsToSelector:@selector(switchAreaView:didClickNextWithCurrentIndex:currentTitle:)]) {
        [self.delegate switchAreaView:self didClickNextWithCurrentIndex:self.currentLabel.tag currentTitle:self.dataSource[self.currentLabel.tag]];
    }
}

- (void)updateIndex
{
    self.lastLabel.tag = self.index%self.dataSource.count-1;
    self.currentLabel.tag = self.index%self.dataSource.count;
    self.nextLabel.tag = self.index%self.dataSource.count+1;
    
    
    if (self.index%self.dataSource.count == self.dataSource.count-1) {
        self.nextLabel.tag = 0;
    }
    if (self.index%self.dataSource.count == 0) {
        self.lastLabel.tag = self.dataSource.count - 1;
    }
    
    self.lastLabel.text = self.dataSource[self.lastLabel.tag];
    self.currentLabel.text = self.dataSource[self.currentLabel.tag];
    self.nextLabel.text = self.dataSource[self.nextLabel.tag];
}

/*
0   0
-1  0
-2  16
-3  15
*/

@end
