//
//  NSString+transformPY.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import <Foundation/Foundation.h>

@interface NSString (transformPY)

+ (NSString *)transform:(NSString *)chinese;

+ (NSString *)FirstCharactor:(NSString *)pString;

- (BOOL)includeChinese;//判断是否含有汉字
@end

