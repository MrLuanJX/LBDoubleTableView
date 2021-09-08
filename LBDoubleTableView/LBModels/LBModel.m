//
//  LBModel.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/7.
//

#import "LBModel.h"

@implementation LBModel

- (instancetype)initWithDict:(NSDictionary *)dict {
    self = [super init];
    if (self) {
        [self setValuesForKeysWithDictionary:dict];
    }
    return self;
}

+ (instancetype)cityWithDict:(NSDictionary *)dict {
    return [[self alloc] initWithDict:dict];
}

- (void)setValue:(id)value forUndefinedKey:(NSString *)key {}

- (NSArray *)cityList {
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < _cityList.count; i++) {
        LBModel *model = [LBModel cityWithDict:_cityList[i]];
        [arrayM addObject:model];
    }
    return arrayM;
}

- (NSArray *)areaList {
    NSMutableArray *arrayM = [NSMutableArray array];
    for (int i = 0; i < _areaList.count; i++) {
        LBModel *model = [LBModel cityWithDict:_areaList[i]];
        [arrayM addObject:model];
    }
    return arrayM;
}

@end
