//
//  NSObject+GetIP.h
//  ZHLoanClient
//
//  Created by zhph on 2018/7/6.
//  Copyright © 2018年 小飞鸟. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSObject (GetIP)

/*外网的IP*/
+(NSString *)localIPAddress;
/**蜂窝网络*/
+ (NSString *)getIPAddress:(BOOL)preferIPv4;
/*获取广告追踪权限 1 代表 能获取 0 代表不能获取*/
+(BOOL)AdvertisingTrackingEnabled;
/* iphone名称*/
+ (NSString *)getIPhoneName;
/* app版本号 */
+ (NSString *)getAppVersion;
/* 电池电量 */
+ (CGFloat)getPhoneBatteryLevel;
/* localizedModel */
+ (NSString *)getLocalizedModel;
/* 系统名称 */
+ (NSString *)getSystemName;
/* 系统版本号 */
+ (NSString *)getSystemVersion;

@end
