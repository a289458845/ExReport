
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (StringSize)
/**
 *  简单计算textsize
 *
 *  @param width 传入特定的宽度
 *  @param font  字体
 */
- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font;
- (CGFloat)heightWithLabelWidth:(CGFloat)width font:(UIFont *)font;
- (CGFloat)widthWithLabelWidth:(CGFloat)width font:(UIFont *)font;

@end
