//
//  LBAllSectionChildTableView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import "LBAllSectionChildTableView.h"

@interface LBAllSectionChildTableView() <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView* childTableView;
@property(nonatomic, strong)NSMutableArray* childData;
@property(nonatomic, assign)NSInteger selectedIndex;
@property(nonatomic, assign)BOOL isScroll;
@property(nonatomic, assign)NSInteger lastSection;

@end

@implementation LBAllSectionChildTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
        self.isScroll = YES;
    }
    return self;
}

- (void)createUI {
    [self addSubview: self.childTableView];
    
    [self.childTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.offset(0);
    }];
}

- (void)setSelectedIndex:(NSInteger)selectedIndex {
    _selectedIndex = selectedIndex;
    self.isScroll = NO;
    //tableview滚动到指定的行：
    [self.childTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:selectedIndex] atScrollPosition:UITableViewScrollPositionTop animated:YES];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1* NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        self.isScroll = YES;
    });
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

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return LBFit(40);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    UILabel* sectionLabel = [UILabel new];
    sectionLabel.backgroundColor = LBUIColorWithRGB(0x4CB371, .9);
    LBModel* model = self.childData[section];
    sectionLabel.text = model.name;
    
    return sectionLabel;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // 去除row为0的section
    NSMutableArray* dataCount = @[].mutableCopy;
    for (int i = 0; i< self.childData.count; i++) {
        LBModel* model = self.childData[i];
        if (model.cityList.count > 0) {
            [dataCount addObject:model];
        }
    }
    return dataCount.count;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    LBModel* model = self.childData[section];
    return model.cityList.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"childCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    LBModel* model = self.childData[indexPath.section];
    LBModel* childModel = model.cityList[indexPath.row];
    cell.textLabel.text = childModel.name;
    cell.backgroundColor = LBUIColorWithRGB(0xF5F5F5, 1);

    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (self.isScroll == YES) {
        NSUInteger sectionNumber = [self.childTableView indexPathForCell:self.childTableView.visibleCells.firstObject].section;
        if (self.lastSection != sectionNumber) {
            self.lastSection = sectionNumber;
            if (self.scrollFinishCallback) {
                self.scrollFinishCallback(self.lastSection);
            }
        }
    }
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
