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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.title = @"LBDoubleTableView";
    
    [self loadData];
    [self createUI];
}

- (void)createUI {    
    [self.view addSubview:self.baseView];
    [self.baseView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.right.bottom.offset(0);
        make.top.mas_equalTo(0);
    }];
    
    NSArray* vcArray = @[[LBDoubleTableViewController new],[LBAllSectionViewController new],[LBFoldViewController new],[LBCityIndexViewController new]];
    
    WeakSelf(weakSelf);
    self.baseView.didSelectCellCallback = ^(NSIndexPath *indexPath,NSString* title) {
        StrongSelf(strongSelf);
        [vcArray[indexPath.row] setValue:strongSelf.dataArray forKey:@"dataArray"];
        [strongSelf.navigationController pushViewController:vcArray[indexPath.row] animated:YES];
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

@end
