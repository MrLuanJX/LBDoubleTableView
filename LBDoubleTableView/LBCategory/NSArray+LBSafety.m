//
//  NSArray+LBSafety.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/10/18.
//

#import "NSArray+LBSafety.h"
#import <objc/runtime.h>

@implementation NSArray (LBSafety)

+(void)load{
    [super load];
    //获取要替换的系统方法
    Method sysMethod1 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndex:));
    Method sysMethod2 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(objectAtIndexedSubscript:));
    //添加自己的方法
    Method selfMethod1 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(lb_objectAtIndex:));
    Method selfMethod2 = class_getInstanceMethod(objc_getClass("__NSArrayI"), @selector(lb_objectAtIndexedSubscript:));
    
    //实现方法交换
    method_exchangeImplementations(sysMethod1, selfMethod1);
    method_exchangeImplementations(sysMethod2, selfMethod2);
}

#pragma mark - Action && Notification
- (id)lb_objectAtIndex:(NSInteger)index {
    if (self.count - 1 < index) {
        @try {
            return [self lb_objectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"---------- %s Crash Because Method %s ----------\n",class_getName(self.class),__func__);
            NSLog(@"---------- %@",[exception callStackSymbols]);
            return nil;
        } @finally {
            NSLog(@"nothing to do");
        }
    }else{
        return [self lb_objectAtIndex:index];
    }
}

- (id)lb_objectAtIndexedSubscript:(NSInteger)index {
    if (self.count - 1 < index) {
        @try {
            return [self lb_objectAtIndex:index];
        } @catch (NSException *exception) {
            NSLog(@"---------- %s Crash Because Method %s ----------\n",class_getName(self.class),__func__);
            NSLog(@"---------- %@",[exception callStackSymbols]);
            return nil;
            
        } @finally {
            NSLog(@"nothing to do");
        }
    }else{
        return [self lb_objectAtIndex:index];
    }
}


@end
