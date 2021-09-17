//
//  UIColor+GetRGBA.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/16.
//

#import "UIColor+GetRGBA.h"

@implementation UIColor (GetRGBA)

// 获取颜色值的RGBA
+ (NSArray *)getRGBWithColor:(UIColor *)color {
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}

@end
