//
//  ViewController.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/7.
//

#import "ViewController.h"
#import "LBBaseView.h"
#import "LBDoubleTableViewController.h"
#import "LBAllSectionViewController.h"
#import "LBFoldViewController.h"
#import "LBCityIndexViewController.h"

@interface ViewController ()

@property(nonatomic, strong)LBBaseView* baseView;
@property(nonatomic, strong)NSMutableArray* dataArray;
/* 索引数据 */
@property(nonatomic, strong)NSMutableArray* pyArray;
@property(nonatomic, strong)NSMutableArray* allArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"LBDoubleTableView";
    [self loadData];
    [self createUI];
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [self setData];
//    });
}

- (void)createUI {    
    [self.view addSubview:self.baseView];
    [self.baseView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.mas_equalTo(0);
    }];
    
    WeakSelf(weakSelf);
    self.baseView.didSelectCellCallback = ^(NSIndexPath *indexPath,NSString* title) {
        StrongSelf(strongSelf);
        UIViewController* vc = [UIViewController new];
        if (indexPath.row == 0) {
            vc = [LBDoubleTableViewController new];
        }
        if (indexPath.row == 1) {
            vc = [LBAllSectionViewController new];
        }
        if (indexPath.row == 2) {
            vc = [LBFoldViewController new];
        }
        if (indexPath.row == 3) {
            vc = [LBCityIndexViewController new];
        }
        [vc setValue:strongSelf.dataArray forKey:@"dataArray"];
        [strongSelf.navigationController pushViewController:vc animated:YES];
    };
}

- (LBBaseView *)baseView {
    if (!_baseView) {
        _baseView = [LBBaseView new];
    }
    return _baseView;
}

- (NSMutableArray *)dataArray {
    if (!_dataArray) {
        _dataArray = @[].mutableCopy;
    }
    return _dataArray;
}

#pragma mark 加载地址数据
- (void)loadData {
    // 1.获取沙盒路径
    NSString *docDir = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
    NSString *filePath = [docDir stringByAppendingPathComponent:@"cityList.plist"];
    // 2.加载 data
    NSData *data = [NSData dataWithContentsOfFile:filePath];
    // 3.判断沙盒中是否存在 cityList.plist 文件，存在则不需要从网络上获取，否则，发送请求。
    if (data == nil) {
        // 4.从网络上加载'全国地址大全信息'
        NSString *jsonPath = [NSBundle.mainBundle pathForResource:@"cityList.json" ofType:nil];
        data = [NSData dataWithContentsOfFile:jsonPath];
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:nil];
        // 获取沙盒路径
        NSString *docDir1 = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES).firstObject;
        NSString *plistPath = [docDir1 stringByAppendingPathComponent:@"cityList.plist"];
        // 5.将'全国地址大全信息'存到沙盒中。
        [array writeToFile:plistPath atomically:YES];
    }
    // 6.字典转模型
    // 反序列化成数组
    NSArray *cityArr = [NSArray arrayWithContentsOfFile:filePath];
    // 字典数组转模型数组
    for (int i = 0; i < cityArr.count; i++) {
        LBModel *model = [LBModel cityWithDict:cityArr[i]];
        [self.dataArray addObject:model];
    }
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
//    [self.cityIndexView setValue:self.allArray forKey:@"dataSource"];
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
