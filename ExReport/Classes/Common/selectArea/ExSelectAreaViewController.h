//
//  ExSelectAreaViewController.h
//  ExCheckCar
//
//  Created by exsun on 2021/1/21.
//

#import "rBaseViewController.h"
#import "ZWRegionModel.h"
NS_ASSUME_NONNULL_BEGIN
@protocol ExelectAreaViewControllerDelegate<NSObject>
@required
- (void)selectAreaViewControllerDelegateItemClick:(ZWRegionModel *)model;
@end
@interface ExSelectAreaViewController : rBaseViewController
@property (weak, nonatomic) id<ExelectAreaViewControllerDelegate>delegate;
@end

NS_ASSUME_NONNULL_END
