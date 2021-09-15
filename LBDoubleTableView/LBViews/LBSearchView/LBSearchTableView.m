//
//  LBSearchTableView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/13.
//

#import "LBSearchTableView.h"
#import "LBSearchView.h"

@interface LBSearchTableView() <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView* searchTableView;
@property(nonatomic, strong)NSMutableArray* dataSource;

@end

@implementation LBSearchTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.searchTableView];
    [self.searchTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.offset(0);
    }];
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    [self.searchTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count>0?self.dataSource.count:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableDictionary* dict = self.dataSource[section];
    NSMutableArray* arr = dict[@"cityName"];
    return arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return LBFit(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LBFit(60);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    NSMutableDictionary* dict = self.dataSource[section];
    UIView* sectionView = [UIView new];
    sectionView.backgroundColor = LBUIColorWithRGB(0xCDCDCD, 1);
    
    UILabel* cityLabel = [UILabel new];
    cityLabel.text = dict[@"cityId"];
    cityLabel.textColor = LBUIColorWithRGB(0x228B22, 1);
    [sectionView addSubview:cityLabel];
    [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.left.offset(10);
    }];
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"searchCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    if (self.dataSource.count>0) {
        NSMutableDictionary* dict = self.dataSource[indexPath.section];
        NSMutableArray* cellArr = dict[@"cityName"];
        cell.textLabel.text = cellArr[indexPath.row];
    }
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray* sectionArr = @[].mutableCopy;
    [self.dataSource enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary* dict = object;
        [sectionArr addObject:dict[@"cityId"]];
    }];
    
    return sectionArr;
}

- (NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    NSMutableDictionary* dict = self.dataSource[indexPath.section];
    NSString* selectRow = dict[@"cityName"][indexPath.row];
    if (self.selectCallback) {
        self.selectCallback(selectRow);
    }
}

- (UITableView *)searchTableView {
    if (!_searchTableView) {
        _searchTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _searchTableView.delegate = self;
        _searchTableView.dataSource = self;
        _searchTableView.tableFooterView = [UIView new];
        _searchTableView.sectionIndexColor = LBUIColorWithRGB(0x228B22, 1);
        _searchTableView.sectionIndexBackgroundColor = [UIColor clearColor];  //背景颜色
        if (@available(iOS 11.0, *)) {
            _searchTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _searchTableView;
}

@end
