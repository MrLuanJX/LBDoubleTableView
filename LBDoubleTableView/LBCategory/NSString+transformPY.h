//
//  NSString+transformPY.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import <Foundation/Foundation.h>

@interface NSString (transformPY)

// 汉字转拼音未去掉空格
+ (NSString *)transform:(NSString *)chinese;

// 汉字转拼音返回首字母
+ (NSString *)FirstCharactor:(NSString *)pString;

// 汉字转拼音并去掉空格
+ (NSString *)chChangePin:(NSString *)str;

//判断是否含有汉字
- (BOOL)includeChinese;


@end

