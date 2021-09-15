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
    /*去空格*/
    NSString *ciytString = [NSString stringWithFormat:@"%@",pinyin];
    NSString *cityName = [ciytString stringByReplacingOccurrencesOfString:@" " withString:@""];
     
    return cityName;//[pinyin uppercaseString];
}

// 汉字转拼音并去空格
+ (NSString *)chChangePin:(NSString *)str {
    // NSString 转换成 CFStringRef 型
    CFStringRef string1 = (CFStringRef)CFBridgingRetain(str);
    //  汉字转换成拼音
    CFMutableStringRef string = CFStringCreateMutableCopy(NULL, 0, string1);
    //  拼音（带声调的）
    CFStringTransform(string, NULL, kCFStringTransformMandarinLatin, NO);
    //  去掉声调符号
    CFStringTransform(string, NULL, kCFStringTransformStripDiacritics, NO);
    //  CFStringRef 转换成 NSString
    NSString *strings = (NSString *)CFBridgingRelease(string);
    //  去掉空格
    NSString *cityString = [strings stringByReplacingOccurrencesOfString:@" " withString:@""];
    
    return cityString;
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
    //转化为大写拼音     // lowercaseString 转小写
    NSString *pPinYin = [pStr uppercaseString];
    //获取并返回首字母
    return [pPinYin substringToIndex:1];
}
// 是否包含汉字
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
