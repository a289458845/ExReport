//
//  r_BaseViewController.m
//  ExReport
//
//  Created by exsun on 2021/3/15.
//

#import "rBaseViewController.h"
#import <ExReport/ExDefine.h>
@interface rBaseViewController ()

@end

@implementation rBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)setupUI{
}
- (void)setupConstraint{
}

-(void)setupNavigationTitleWithTitle:(NSString *)title{
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0,0, 200, 44)];
    titleLabel.backgroundColor = [UIColor clearColor];
    titleLabel.font = kSystemDefauletFont(36);
    titleLabel.textColor = COLORWITHHEX(kColor_3A3D44);
    titleLabel.textAlignment = NSTextAlignmentCenter;
    titleLabel.text = title;
    self.navigationItem.titleView = titleLabel;

}

@end
