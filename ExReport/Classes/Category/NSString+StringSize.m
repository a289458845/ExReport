//
//  NSString+StringSize.m
//  最简单的动态行高
//

#import "NSString+StringSize.h"

@implementation NSString (StringSize)



- (CGSize)sizeWithLabelWidth:(CGFloat)width font:(UIFont *)font{
    NSDictionary *dict=@{NSFontAttributeName : font};
    CGRect rect=[self boundingRectWithSize:CGSizeMake(width, MAXFLOAT) options:(NSStringDrawingUsesLineFragmentOrigin) attributes:dict context:nil];
    CGFloat sizeWidth=ceilf(CGRectGetWidth(rect));
    CGFloat sizeHieght=ceilf(CGRectGetHeight(rect));
    return CGSizeMake(sizeWidth, sizeHieght);
}

- (CGFloat)heightWithLabelWidth:(CGFloat)width font:(UIFont *)font{
    CGSize size = [self sizeWithLabelWidth:width font:font];
    return fabs(size.height);
}
- (CGFloat)widthWithLabelWidth:(CGFloat)width font:(UIFont *)font{
    CGSize size = [self sizeWithLabelWidth:width font:font];
    return size.width;
}
@end
