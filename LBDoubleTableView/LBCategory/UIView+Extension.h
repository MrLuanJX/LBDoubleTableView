//
//  UIView+Extension.h
//  01-黑酷
//
//  Created by apple on 14-6-27.
//  Copyright (c) 2014年 heima. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef enum :NSInteger{
    LJXShadowPathLeft,
    LJXShadowPathRight,
    LJXShadowPathTop,
    LJXShadowPathBottom,
    LJXShadowPathNoTop,
    LJXShadowPathAllSide
} LJXShadowPathSide;

@interface UIView (Extension)

@property (nonatomic, assign) CGFloat x;
@property (nonatomic, assign) CGFloat y;
@property (nonatomic, assign) CGFloat centerX;
@property (nonatomic, assign) CGFloat centerY;
@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, assign) CGSize size;

@property (nonatomic, assign) CGFloat maxY;

/**
 *  获取最大的y
 */
- (CGFloat)maxY;

/** 控件最左边那根线的位置(minX的位置) */
@property (nonatomic, assign) CGFloat left;
/** 控件最右边那根线的位置(maxX的位置) */
@property (nonatomic, assign) CGFloat right;
/** 控件最顶部那根线的位置(minY的位置) */
@property (nonatomic, assign) CGFloat top;
/** 控件最底部那根线的位置(maxY的位置) */
@property (nonatomic, assign) CGFloat bottom;

//添加一根线
+ (UIView *)addLineWithFrame:(CGRect)frame WithView:(UIView *)view;

//创建一个view的对象
+(UIView*)CreateViewWithFrame:(CGRect)frame BackgroundColor:(UIColor*)color InteractionEnabled:(BOOL)enabled;

// 渐变色
+ (void)getGradientWithFirstColor:(UIColor *)firstColor SecondColor:(UIColor *)secondColor WithView:(UIView *)view;

// 插入一个背景
+ (void)addRefreshBGView:(UIView *)BGView ColorArray:(NSArray *)colorArray Locations:(NSArray *)locations startPoint:(CGPoint)startPoint endPoint:(CGPoint)endPoint;

/*
 * shadowColor 阴影颜色
 *
 * shadowOpacity 阴影透明度，默认0
 *
 * shadowRadius  阴影半径，默认3
 *
 * shadowPathSide 设置哪一侧的阴影，
 
 * shadowPathWidth 阴影的宽度，
 
 */

+ (void)LJX_AddShadowToView:(UIView *)theView SetShadowPathWith:(UIColor *)shadowColor shadowOpacity:(CGFloat)shadowOpacity shadowRadius:(CGFloat)shadowRadius shadowSide:(LJXShadowPathSide)shadowPathSide shadowPathWidth:(CGFloat)shadowPathWidth;

// view显示动画 放大缩小
+ (void)shakeToShow:(UIView*)aView;


+ (void)view:(UIView *)view WitchCorner:(UIRectCorner)corner WithCornerRadii:(CGSize)radSize;

- (void)borderGradientColorWithColors:(NSArray *)colors radius:(CGFloat)radius lineWidth:(CGFloat)lineWidth percentages:(NSArray *)percentages;

@end
