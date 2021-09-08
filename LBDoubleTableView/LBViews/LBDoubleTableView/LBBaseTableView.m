//
//  LBBaseTableView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/7.
//

#import "LBBaseTableView.h"

@interface LBBaseTableView() <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)NSMutableArray* baseData;
@property(nonatomic, strong)NSIndexPath* selectedIndex;

@end

@implementation LBBaseTableView

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
    return self.baseData.count==0?0:self.baseData.count;
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
    if (self.didSelectCellCallback) {
        self.didSelectCellCallback(indexPath,cell);
    }
    self.selectedIndex = indexPath;
    
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
