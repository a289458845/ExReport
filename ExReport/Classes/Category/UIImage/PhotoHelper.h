//
//  PhotoHelper.h
//  photo
//
//  Created by admin on 2017/5/26.
//  Copyright © 2017年 Shenzhen Xinwo Transport. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void (^PhotoHelperBlock) (id data);

@interface PhotoHelper : UIImagePickerController

+ (instancetype)shareHelper;

- (void)showImageViewSelcteWithResultBlock:(PhotoHelperBlock)selectImageBlock;
@end
