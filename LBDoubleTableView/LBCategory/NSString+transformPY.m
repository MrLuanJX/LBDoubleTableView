//
//  NSString+transformPY.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import "NSString+transformPY.h"

@implementation NSString (transformPY)

+ (NSString *)transform:(NSString *)chinese {
    NSMutableString *pinyin = [chinese mutableCopy];
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformMandarinLatin, NO);
    CFStringTransform((__bridge CFMutableStringRef)pinyin, NULL, kCFStringTransformStripCombiningMarks, NO);
    /*多音字处理*/
    if ([[(NSString *)chinese substringToIndex:1] compare:@"长"] == NSOrderedSame) {
        [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    if ([[(NSString *)chinese substringToIndex:1] compare:@"沈"] == NSOrderedSame) {
        [pinyin replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    }
    if ([[(NSString *)chinese substringToIndex:1] compare:@"厦"] == NSOrderedSame) {
        [pinyin replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    }
    if ([[(NSString *)chinese substringToIndex:1] compare:@"地"] == NSOrderedSame) {
        [pinyin replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
    }
    if ([[(NSString *)chinese substringToIndex:1] compare:@"重"] == NSOrderedSame) {
        [pinyin replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
//    NSLog(@"%@", pinyin);
    return [pinyin uppercaseString];
}

//获取拼音首字母(传入汉字字符串, 返回大写拼音首字母)
+(NSString *)FirstCharactor:(NSString *)pString {
    //转成了可变字符串
    NSMutableString *pStr = [NSMutableString stringWithString:pString];
    //先转换为带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformMandarinLatin,NO);
    //再转换为不带声调的拼音
    CFStringTransform((CFMutableStringRef)pStr,NULL, kCFStringTransformStripDiacritics,NO);
    /*多音字处理*/
    if ([[(NSString *)pString substringToIndex:1] compare:@"长"] == NSOrderedSame) {
        [pStr replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chang"];
    }
    if ([[(NSString *)pString substringToIndex:1] compare:@"沈"] == NSOrderedSame) {
        [pStr replaceCharactersInRange:NSMakeRange(0, 4) withString:@"shen"];
    }
    if ([[(NSString *)pString substringToIndex:1] compare:@"厦"] == NSOrderedSame) {
        [pStr replaceCharactersInRange:NSMakeRange(0, 3) withString:@"xia"];
    }
    if ([[(NSString *)pString substringToIndex:1] compare:@"地"] == NSOrderedSame) {
        [pStr replaceCharactersInRange:NSMakeRange(0, 3) withString:@"di"];
    }
    if ([[(NSString *)pString substringToIndex:1] compare:@"重"] == NSOrderedSame) {
        [pStr replaceCharactersInRange:NSMakeRange(0, 5) withString:@"chong"];
    }
    
    //转化为大写拼音
    NSString *pPinYin = [pStr uppercaseString];
    //获取并返回首字母
    return [pPinYin substringToIndex:1];
}

- (BOOL)includeChinese {
    for(int i=0; i< [self length];i++) {
        int a =[self characterAtIndex:i];
        if( a >0x4e00&& a <0x9fff){
            return YES;
        }
    }
    return NO;
}

@end
