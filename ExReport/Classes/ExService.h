//
//  ExService.h
//  ExReport
//
//  Created by exsun on 2021/2/4.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface ExService : NSObject
+(ExService *)manager;

-(void)print;
@end

NS_ASSUME_NONNULL_END
