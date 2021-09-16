//
//  UIBezierPath+DrawIndicatorPath.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/16.
//

#import "UIBezierPath+DrawIndicatorPath.h"

@implementation UIBezierPath (DrawIndicatorPath)

#pragma mark - 绘制calloutView
+ (UIBezierPath *)drawIndicatorPath:(NSInteger)radiusw {
    CGFloat indicatorRadius = radiusw/2;
    CGFloat sinPI_4_Radius = sin(M_PI_4) * indicatorRadius;
    CGFloat margin = (sinPI_4_Radius * 2 - indicatorRadius);
    
    CGPoint startPoint = CGPointMake(margin + indicatorRadius + sinPI_4_Radius, indicatorRadius - sinPI_4_Radius);
    CGPoint trianglePoint = CGPointMake(4 * sinPI_4_Radius, indicatorRadius);
    CGPoint centerPoint = CGPointMake(margin + indicatorRadius, indicatorRadius);
    
    UIBezierPath *bezierPath = [UIBezierPath bezierPath];
    [bezierPath moveToPoint:startPoint];
    [bezierPath addArcWithCenter:centerPoint radius:indicatorRadius startAngle:-M_PI_4 endAngle:M_PI_4 clockwise:NO];
    [bezierPath addLineToPoint:trianglePoint];
    [bezierPath addLineToPoint:startPoint];
    [bezierPath closePath];
    return bezierPath;
}

@end
