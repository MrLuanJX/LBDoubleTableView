//
//  LBCityIndexViewController.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import "LBCityIndexViewController.h"
#import "LBCityIndexView.h"

@interface LBCityIndexViewController ()

@property(nonatomic, strong)LBCityIndexView* cityIndexView;
@property(nonatomic, strong)NSMutableArray* dataArray;
@property(nonatomic, strong)NSMutableArray* pyArray;
@property(nonatomic, strong)NSMutableArray* allArray;

@end

@implementation LBCityIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];

    [self createUI];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [self setData];
    });
}

- (void)createUI {
    [self.view addSubview:self.cityIndexView];
    
    [self.cityIndexView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
    
  
}

- (void)setData {
    [self.pyArray enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary* cityDict =object;
        NSMutableArray* dataArr = @[].mutableCopy;
        [self.dataArray enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
            LBModel* model = object;
            [model.cityList enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
                LBModel* cityModel = object;
                if ([[NSString FirstCharactor:cityModel.name] isEqualToString:cityDict[@"cityId"]]) {
                    [dataArr addObject:cityModel.name];
                }
            }];
        }];
        cityDict[@"cityName"] = dataArr;
        [self.allArray addObject:cityDict];
    }];
    [self.cityIndexView setValue:self.allArray forKey:@"dataSource"];
}

- (LBCityIndexView *)cityIndexView {
    if (!_cityIndexView) {
        _cityIndexView = [LBCityIndexView new];
    }
    return _cityIndexView;
}

- (NSMutableArray *)pyArray {
    if (!_pyArray) {
        _pyArray = @[].mutableCopy;
     NSArray* arr = @[@"🔍",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
        [arr enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
            NSMutableDictionary* dict = @{}.mutableCopy;
            dict[@"cityId"] = arr[idx];
            dict[@"cityName"] = @[].mutableCopy;
            [_pyArray addObject:dict];
        }];
    }
    return _pyArray;
}

- (NSMutableArray *)allArray {
    if (!_allArray) {
        _allArray = @[].mutableCopy;
    }
    return _allArray;
}
@end
