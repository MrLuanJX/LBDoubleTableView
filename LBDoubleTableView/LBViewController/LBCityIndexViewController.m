//
//  LBCityIndexViewController.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import "LBCityIndexViewController.h"
#import "LBCityIndexView.h"
#import "LBSearchBtnView.h"
#import "LBSearchView.h"

@interface LBCityIndexViewController ()

@property(nonatomic, strong)LBSearchBtnView* searchBtnView;
@property(nonatomic, strong)LBCityIndexView* cityIndexView;
@property(nonatomic, strong)NSMutableArray* dataArray;      // 城市数据
@property(nonatomic, strong)NSMutableArray* pyArray;        // 拼音首字母数据
@property(nonatomic, strong)NSMutableArray* allArray;       // 所有数据
@property(nonatomic, strong)NSMutableArray* historyArray;   // 历史数据

@end

@implementation LBCityIndexViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"CityIndexView";
    self.view.backgroundColor = [UIColor whiteColor];

    [self createUI];
    [self setupSearchBtnView];
    [self setupSelectCallback];
    
    // 取cityData
    NSMutableArray* cityData = [LBUserDefaultTool getCityData];
    if (cityData.count==0) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self setData];
        });
    } else {
        [self getDefaultData:cityData];
    }
    // 取历史筛选选中的数组
    NSMutableArray* historyArray = [LBUserDefaultTool getHistoryData];
    [self.historyArray addObjectsFromArray:historyArray];
}

- (void)createUI {
    [self.view addSubview:self.cityIndexView];
    [self.cityIndexView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}
// 选中的回调
- (void)setupSelectCallback {
    LBWeakSelf(self);
    self.cityIndexView.selectCallback = ^(NSString *selectText) {
        LBStrongSelf(self);
        // 更改上面搜索的btnTitle
        [self.searchBtnView setValue:selectText forKey:@"btnTitle"];
        // 列表页面选中返回
        [LBUserDefaultTool historyDefaultsWithText:selectText];
        // 弹出toast
        [LBTextHUD showIn:self.view Duration:1 Text:[NSString stringWithFormat:@"选中了: %@",selectText]];
        // popViewController
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [self.navigationController popViewControllerAnimated:YES];
        });
    };
}
// searchBtn的回调
- (void)setupSearchBtnView {
    [self.navigationItem.titleView sizeToFit];
    self.navigationItem.titleView = self.searchBtnView;
    
    LBWeakSelf(self);
    self.searchBtnView.searchAction = ^{
        LBStrongSelf(self);
        [LBSearchView showWithDataSource:self.allArray SearchCallback:^(NSString *searchText) {
            [LBSearchView dismiss];
            LBStrongSelf(self);
            // 搜索页面选中返回
            [LBTextHUD showIn:self.view Duration:1 Text:[NSString stringWithFormat:@"选中了: %@",searchText]];
            dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                [self.navigationController popViewControllerAnimated:YES];
            });
        }];
    };
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
}

- (void)setData {
    [self.pyArray enumerateObjectsUsingBlock:^(id object, NSUInteger pyIdx, BOOL *stop) {
        NSMutableDictionary* cityDict =object;
        NSMutableArray* dataArr = @[].mutableCopy;
        if (pyIdx == 0) {
            dataArr = self.historyArray;
        }
        if (pyIdx == 1) {
            dataArr =  @[@"北京市",@"上海市",@"广州市",@"深圳市",@"杭州市",@"苏州市",@"昆明市",@"西安市",@"郑州市",@"哈尔滨市",@"沈阳市",@"长春市",@"石家庄市",@"天津市",@"成都市",@"重庆市",@"武汉市",@"合肥市",@"长沙市",@"厦门市",@"南昌市"].mutableCopy;
        }
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
    
    // 移除section所在的cell个数为0的元素
    NSMutableArray* tempArr = [NSMutableArray arrayWithArray:self.allArray];
    [tempArr enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary* dict = object;
        NSMutableArray* arr = [NSMutableArray arrayWithArray:dict[@"cityName"]];
        if (arr.count == 0 && idx != 0) {
            [self.allArray removeObject:dict];
        }
    }];
    
    [self.cityIndexView setValue:self.allArray forKey:@"dataSource"];
    // 缓存cityData
    [LBUserDefaultTool saveCityData:self.allArray];
}

- (void)getDefaultData:(NSMutableArray *)cityData {
    // 替换历史数据（历史数据需要变换）缓存是错误的
    NSMutableDictionary* historyDict = @{}.mutableCopy;
    [cityData enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        if (idx == 0) {
            NSMutableDictionary* dict = object;
            NSMutableArray* array = @[].mutableCopy;
            NSArray* arr = dict[@"cityName"];
            [array addObjectsFromArray:arr];
            [array removeAllObjects];
            [array addObjectsFromArray:[LBUserDefaultTool getHistoryData]];
            historyDict[@"cityName"] = array;
        }
    }];
    historyDict[@"cityId"] = cityData.firstObject[@"cityId"];
    [cityData removeObjectAtIndex:0];
    [cityData insertObject:historyDict atIndex:0];
    // 给搜索赋值数据 allArray
    [self.allArray addObjectsFromArray:cityData];
    [self.cityIndexView setValue:cityData forKey:@"dataSource"];
}

- (LBCityIndexView *)cityIndexView {
    if (!_cityIndexView) {
        _cityIndexView = [LBCityIndexView new];
    }
    return _cityIndexView;
}

- (LBSearchBtnView *)searchBtnView {
    if (!_searchBtnView) {
        _searchBtnView = [[LBSearchBtnView alloc] initWithFrame:CGRectMake(0, 0, LBScreenW - 100, 35)];
    }
    return _searchBtnView;
}

- (NSMutableArray *)pyArray {
    if (!_pyArray) {
        _pyArray = @[].mutableCopy;
     NSArray* arr = @[@"历史",@"热门",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
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

- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = @[].mutableCopy;
    }
    return _historyArray;
}

@end
