//
//  LBModel.h
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/7.
//

#import <Foundation/Foundation.h>

@interface LBModel : NSObject

@property(nonatomic, copy)NSArray *cityList;
@property(nonatomic, copy)NSArray *areaList;
/// 市
@property(nonatomic, copy)NSString *name;
@property(nonatomic, copy)NSString *code;

/// 字典转模型的对象方法
/// @param dict 字典
- (instancetype)initWithDict:(NSDictionary *)dict;

/// 字典转模型的类方法
/// @param dict 字典
+(instancetype)cityWithDict:(NSDictionary *)dict;

@end

