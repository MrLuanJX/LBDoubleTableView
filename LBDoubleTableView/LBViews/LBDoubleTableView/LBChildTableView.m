//
//  LBChildTableView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/7.
//

#import "LBChildTableView.h"
// 右边的tableView
@interface LBChildTableView() <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView* childTableView;
@property(nonatomic, strong)NSMutableArray* childData;

@end

@implementation LBChildTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        [self setRefresh];
    }
    return self;
}

- (void)createUI {
    [self addSubview: self.childTableView];
    
    [self.childTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.offset(0);
    }];
}

- (void)setRefresh {
    WeakSelf(weakSelf);
    LBRefresh* footFresh = [LBRefresh footerWithRefreshingBlock:^{
        StrongSelf(strongSelf);
        [strongSelf.childTableView.mj_footer endRefreshing];
        if (strongSelf.freshFinishCallback) {
            strongSelf.freshFinishCallback();
        }
    }];
    [self.childTableView setMj_footer:footFresh];
}

- (void)reload {
    [self.childTableView reloadData];
}

- (void)setChildData:(NSMutableArray *)childData {
    _childData = childData;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LBFit(60);
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.childData.count==0?0:self.childData.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"childCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    LBModel* model = self.childData[indexPath.row];
    cell.textLabel.text = model.name;
    cell.backgroundColor = LBUIColorWithRGB(0xF5F5F5, 1);

    return cell;
}

- (UITableView *)childTableView {
    if (!_childTableView) {
        _childTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _childTableView.delegate = self;
        _childTableView.dataSource = self;
        _childTableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            _childTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _childTableView;
}

@end
