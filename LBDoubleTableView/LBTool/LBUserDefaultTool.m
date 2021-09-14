//
//  LBUserDefaultTool.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/14.
//

#import "LBUserDefaultTool.h"

@implementation LBUserDefaultTool

+ (void)historyDefaultsWithText:(NSString*)text {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* arr = [defaults objectForKey:@"history"];
    NSMutableArray* array = [NSMutableArray arrayWithArray:arr];
    [array enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        if ([object isEqualToString:text]) {
            [array removeObject:object];
        }
    }];
    [array insertObject:text atIndex:0];
    if (array.count > 21) {
        [array removeLastObject];
    }
    [defaults setValue:array forKey:@"history"];
    [defaults synchronize];
}

+ (NSMutableArray *)getHistoryData {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* arr = [defaults objectForKey:@"history"];
    NSMutableArray* array = [NSMutableArray arrayWithArray:arr];
    
    return array;
}

+ (void)saveCityData:(NSMutableArray *)array {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    if (array.count>0) {
        [defaults setValue:array forKey:@"cityData"];
    }
    [defaults synchronize];
}

+ (void)saveHotSelectedData:(NSInteger)hotSelected {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    [defaults setValue:@(hotSelected) forKey:@"hotSelected"];
    [defaults synchronize];
}

+ (NSMutableArray *)getCityData {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSArray* arr = [defaults objectForKey:@"cityData"];
    NSMutableArray* array = [NSMutableArray arrayWithArray:arr];
    
    return array;
}

// 清空热门区选中的缓存
+ (void)removeHotSelected {
    NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
    NSDictionary* defDict = [defaults dictionaryRepresentation];
    for (id key in defDict) {
        if ([key isEqualToString:@"hotSelected"]) {
            [defaults removeObjectForKey:key];
            [defaults synchronize];
        }
    }
}

@end
