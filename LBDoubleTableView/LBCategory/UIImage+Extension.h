//
//  UIImage+Extension.h
//  河科院微博
//
//  Created by 👄 on 15/6/4.
//  Copyright (c) 2015年 sczy. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef NS_ENUM(NSInteger, LBImageGradientType) {
    LBImageGradientFromTopToBottom = 1,            //从上到下
    LBImageGradientFromLeftToRight,                //从做到右
    LBImageGradientFromLeftTopToRightBottom,       //从上到下
    LBImageGradientFromLeftBottomToRightTop        //从上到下
};

@interface UIImage (LBGradient)

/**
 *  根据给定的颜色，生成渐变色的图片
 *  @param imageSize        要生成的图片的大小
 *  @param colorArr         渐变颜色的数组
 *  @param percents          渐变颜色的占比数组
 *  @param gradientType     渐变色的类型
 */
+ (UIImage *)lb_createImageWithSize:(CGSize)imageSize gradientColors:(NSArray *)colorArr percentage:(NSArray *)percents gradientType:(LBImageGradientType)gradientType;

@end

@interface UIImage (ChangeColor)

-(UIImage*)imageChangeColor:(UIColor*)color;

@end

@interface UIImage (Extension)

+ (UIImage *)imageWithColor:(UIColor *)color size:(CGSize)size;

+(UIImage *)resizableImage:(NSString *)name;

- (instancetype)circleImage;
+ (instancetype)circleImageNamed:(NSString *)name;

// 根据颜色生成一张尺寸为1*1的相同颜色图片
+ (UIImage *)imageWithColor:(UIColor *)color;

// 根据比例生成一张尺寸缩小的图片
+ (UIImage*)imageWithImage:(UIImage*)image scaledToSize:(CGSize)newSize;

+ (UIImage *)getImageStream:(CVImageBufferRef)imageBuffer;
+ (UIImage *)getSubImage:(CGRect)rect inImage:(UIImage*)image;

@end
