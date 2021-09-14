//
//  LBUserDefaultTool.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/14.
//

#import <Foundation/Foundation.h>

@interface LBUserDefaultTool : NSObject

+ (void)historyDefaultsWithText:(NSString*)text;

+ (void)saveCityData:(NSMutableArray *)array;
+ (void)saveHotSelectedData:(NSInteger)hotSelected;

+ (NSMutableArray *)getCityData;
+ (NSMutableArray *)getHistoryData;

+ (void)removeHotSelected;
@end

