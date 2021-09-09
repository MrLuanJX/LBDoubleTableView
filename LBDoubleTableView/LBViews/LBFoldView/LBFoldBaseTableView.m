//
//  LBFoldBaseTableView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import "LBFoldBaseTableView.h"

@interface LBFoldBaseTableView() <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView* foldTableView;
@property(nonatomic, strong)NSMutableArray* dataSource;
@property(nonatomic, assign)BOOL isFlod;
@property(nonatomic, assign)NSInteger currentFlod;

@end

@implementation LBFoldBaseTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview: self.foldTableView];
    [self.foldTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.offset(0);
    }];
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count>0?self.dataSource.count:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.currentFlod == section) {
        LBModel* childModel = self.dataSource[section];
        return self.isFlod==YES?childModel.cityList.count:0;
    }
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return LBFit(80);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return LBFit(50);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    LBModel* baseModel = self.dataSource[section];
    UIView* sectionView = [UIView new];
    sectionView.backgroundColor = LBUIColorWithRGB(0xFFFFFF, 1);
    // 线
    UIView* lineView = [UIView new];
    lineView.backgroundColor = LBUIColorWithRGB(0xF5F5F5, 1);
    // 按钮
    UIButton* sectionBtn = [UIButton new];
    [sectionBtn setTitle:baseModel.name forState:UIControlStateNormal];
    [sectionBtn setTitleColor:LBUIColorWithRGB(0x130202, 1) forState:UIControlStateNormal];
    [sectionBtn setTitleColor:LBUIColorWithRGB(0xFFFFFF, 1) forState:UIControlStateSelected];
    [sectionBtn setImage:[UIImage imageNamed:@"xiajiantou"] forState:UIControlStateNormal];
    [sectionBtn setImage:[UIImage imageNamed:@"shangjiantou"] forState:UIControlStateSelected];
    [sectionBtn addTarget:self action:@selector(sectionSelect:) forControlEvents:UIControlEventTouchUpInside];
    sectionBtn.titleLabel.font = LBFontNameSize(Font_Regular, 16);
    sectionBtn.selected = self.currentFlod==section&&self.isFlod==YES?YES:NO;
    sectionBtn.backgroundColor = sectionBtn.selected?LBUIColorWithRGB(0x3CB371, 1):LBUIColorWithRGB(0xCDCDCD, 1);
    //使图片在右边，文字在左边（正常情况下是文字在右边，图片在左边）
    [sectionBtn setSemanticContentAttribute:UISemanticContentAttributeForceRightToLeft];
    //设置图片和文字之间的间隙
    sectionBtn.imageEdgeInsets = UIEdgeInsetsMake(0, 10, 0, 0);
    sectionBtn.tag = section;
    [sectionView addSubview:sectionBtn];
    [sectionView addSubview:lineView];
    [lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.right.left.offset(0);
        make.height.mas_equalTo(1);
    }];
    [sectionBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.right.left.offset(0);
        make.bottom.offset(-1);
    }];

    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *cellId = @"baseCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    LBModel* baseModel = self.dataSource[indexPath.section];
    LBModel* childModel = baseModel.cityList[indexPath.row];
    cell.textLabel.text = childModel.name;
    cell.backgroundColor = LBUIColorWithRGB(0xF0F0F0, 1);
    cell.textLabel.textAlignment = NSTextAlignmentCenter;

    return cell;
}

- (void)sectionSelect:(UIButton*)sender {
    self.currentFlod = sender.tag;
    sender.selected = !sender.selected;
    self.isFlod = sender.selected;
    [self.foldTableView reloadData];
}

- (UITableView *)foldTableView {
    if (!_foldTableView) {
        _foldTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _foldTableView.delegate = self;
        _foldTableView.dataSource = self;
        _foldTableView.tableFooterView = [UIView new];
        if (@available(iOS 11.0, *)) {
            _foldTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _foldTableView;
}

@end
