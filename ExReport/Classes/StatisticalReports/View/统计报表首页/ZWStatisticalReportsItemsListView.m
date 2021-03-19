//
//  ZWStatisticalReportsItemsListView.m
//  Muck
//
//  Created by 张威 on 2018/7/25.
//  Copyright © 2018年 张威. All rights reserved.
//

#import "ZWStatisticalReportsItemsListView.h"
#import "UIButton+WebCache.h"

@interface ZWStatisticalReportsItemsListView ()

@property (strong, nonatomic) NSArray *imgs_normal;
@property (nonatomic, strong) NSArray *imgs_selected;
@property (nonatomic, strong) UIView *line;
@property (nonatomic, weak) UIButton *selectedItem;

@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) NSDictionary *menuIcon;

@end

@implementation ZWStatisticalReportsItemsListView

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
//        [self setupUI];
    }
    return self;
}

- (void)setMenus:(NSArray *)Menus{
    _Menus = Menus;
    
    self.buttons = @[].mutableCopy;
    for (int i = 0; i < Menus.count; i++) {
        UIButton *btn = [[UIButton alloc] init];

        [btn sd_setImageWithURL:[NSURL URLWithString:[rTools appendNetworkImageUrl:Menus[i][@"IconClass"]]] forState:0];
        btn.tag = i;
        [btn addTarget:self action:@selector(clickAction:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:btn];
        [self.buttons addObject:btn];
        if (i == 0) {
            btn.selected = YES;
            self.selectedItem = btn;
        }
    }
    self.line = [[UIView alloc] init];
    self.line.backgroundColor = COLORWITHHEX(kColor_EDF0F4);
    [self addSubview:self.line];
}


- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat sideMargin = 30;
    CGSize size = CGSizeMake(36, 36);
//    CGFloat margin = (kScreenWidth-sideMargin*2-self.buttons.count*size.width)/(self.buttons.count-1);
    CGFloat margin = (kScreenWidth-sideMargin*2-6*size.width)/5;
    for (int i = 0; i < self.buttons.count; i++) {
        UIButton *btn = self.buttons[i];
        btn.frame = CGRectMake(sideMargin+i*(size.width+margin), (CGRectGetHeight(self.frame)-size.height)/2, size.width, size.height);
    }
    self.line.frame = CGRectMake(0, CGRectGetHeight(self.frame)-1, CGRectGetWidth(self.frame), 1);
}

- (void)setSelectIndex:(NSInteger)selectIndex{
    _selectIndex = selectIndex;
    self.selectedItem.selected = NO;
    UIButton *btn = self.buttons[selectIndex];
    btn.selected = YES;
    self.selectedItem = btn;
}

- (void)clickAction:(UIButton *)sender{
    if ([self.delegate respondsToSelector:@selector(ZWStatisticalReportsItemsListView:didSelectIndex:)]) {
        [self.delegate ZWStatisticalReportsItemsListView:self didSelectIndex:sender.tag];
        sender.selected = YES;
        self.selectedItem.selected = NO;
        self.selectedItem = sender;
    }

}

- (NSString *)normalIconStringWithUrl:(NSString *)url{
    return self.menuIcon[url][@"normal"];
}

- (NSString *)selectedIconStringWithUrl:(NSString *)url{
    return self.menuIcon[url][@"selected"];
}

- (NSDictionary *)menuIcon{
    if (!_menuIcon) {
        NSString *path = [[NSBundle mainBundle] pathForResource:@"MenuState.plist" ofType:nil];
        _menuIcon = [[NSDictionary alloc] initWithContentsOfFile:path];
    }
    return _menuIcon;
}


@end
