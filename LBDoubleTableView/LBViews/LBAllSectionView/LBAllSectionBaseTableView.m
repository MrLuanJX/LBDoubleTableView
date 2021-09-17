//
//  LBAllSectionBaseTableView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import "LBAllSectionBaseTableView.h"

@interface LBAllSectionBaseTableView() <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)NSMutableArray* baseData;
@property(nonatomic, strong)NSIndexPath* selectedIndex;

@end

@implementation LBAllSectionBaseTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview: self.baseTableView];
    [self.baseTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.offset(0);
    }];
}

- (void)setBaseData:(NSMutableArray *)baseData {
    _baseData = baseData;
}

- (void)setSelectedIndex:(NSIndexPath *)selectedIndex {
    _selectedIndex = selectedIndex;
}

- (void)reload {
    [self.baseTableView reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LBFit(60);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // 去除row为0的section
    NSMutableArray* dataCount = @[].mutableCopy;
    for (int i = 0; i< self.baseData.count; i++) {
        LBModel* model = self.baseData[i];
        if (model.cityList.count > 0) {
            [dataCount addObject:model];
        }
    }
    return dataCount.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"baseCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    LBModel* baseModel = self.baseData[indexPath.row];
    cell.textLabel.text = baseModel.name;
    cell.backgroundColor = self.selectedIndex.row ==indexPath.row ? LBUIColorWithRGB(0x4CB371, .9) : LBUIColorWithRGB(0xFFFFFF, 1);

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell* cell = [self tableView:tableView cellForRowAtIndexPath:indexPath];
    self.selectedIndex = indexPath;
    [self.baseTableView reloadData];
    if (self.didSelectCellCallback) {
        self.didSelectCellCallback(indexPath,cell);
    }
}
#pragma mark - rightTableView滚动监听回调
- (void)scrollwithIndex:(NSIndexPath *)index {
    self.selectedIndex = index;
    //tableview滚动到指定的行：
    [self.baseTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:index.row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    [self.baseTableView reloadData];
}
    
- (UITableView *)baseTableView {
    if (!_baseTableView) {
        _baseTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _baseTableView.delegate = self;
        _baseTableView.dataSource = self;
        _baseTableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            _baseTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _baseTableView;
}


@end
