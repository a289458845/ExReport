//
//  r_BaseViewController.h
//  ExReport
//
//  Created by exsun on 2021/3/15.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface rBaseViewController : UIViewController
- (void)setupUI;
- (void)setupConstraint;
-(void)setupNavigationTitleWithTitle:(NSString *)title;
@end

NS_ASSUME_NONNULL_END
