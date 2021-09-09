//
//  LBCityIndexTableView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import "LBCityIndexTableView.h"

@interface LBSearchCell()

@property(nonatomic, strong)UISearchBar* searchBar;

@end

@implementation LBSearchCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.searchBar];
    [self.searchBar mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.offset(0);
    }];
}

- (UISearchBar *)searchBar {
    if (!_searchBar) {
        _searchBar = [UISearchBar new];
        _searchBar.barStyle = UIBarStyleDefault;
        _searchBar.placeholder = @"搜索你想要的";
    }
    return _searchBar;
}

@end

@interface LBCityIndexTableView() <UITableViewDelegate,UITableViewDataSource>

@property(nonatomic, strong)UITableView* cityTableView;
@property(nonatomic, strong)NSMutableArray* dataSource;
@property(nonatomic, strong)UIActivityIndicatorView* activity;
@end

@implementation LBCityIndexTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        
        [self createUI];
    }
    return self;
}
- (void)createUI {
    [self addSubview:self.cityTableView];
    [self addSubview:self.activity];
    [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.height.mas_equalTo(LBFit(100));
    }];
    [self.cityTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.offset(0);
    }];
    //菊花开始
    [self.activity startAnimating];
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    
    [self.activity stopAnimating];
    [self.cityTableView reloadData];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count>0?self.dataSource.count:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableDictionary* dict = self.dataSource[section];
    NSMutableArray* arr = dict[@"cityName"];
    if (section == 0) {
        if (arr.count==0) {
            [arr addObject:@""];
        }
    }
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
    [sectionView addSubview:cityLabel];
    [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.left.offset(10);
    }];
    
    return sectionView;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0) {
        static NSString *cellId = @"searchCellID";
        LBSearchCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (cell == nil) {
            cell = [[LBSearchCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell.textLabel.adjustsFontSizeToFitWidth = YES;
        }
        return cell;
    }
    static NSString *cellId = @"cityIndexCellID";
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    
    NSMutableDictionary* dict = self.dataSource[indexPath.section];
    NSMutableArray* cellArr = dict[@"cityName"];
    cell.textLabel.text = cellArr[indexPath.row];
    
    return cell;
}

- (NSArray<NSString *> *)sectionIndexTitlesForTableView:(UITableView *)tableView {
    return @[@"🔍",@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z"];
}

- (NSInteger) tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index {
    return index;
}

- (UITableView *)cityTableView {
    if (!_cityTableView) {
        _cityTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        _cityTableView.tableFooterView = [UIView new];
        _cityTableView.sectionIndexColor = [UIColor blackColor];
        _cityTableView.sectionIndexBackgroundColor = [UIColor clearColor];  //背景颜色
        if (@available(iOS 11.0, *)) {
            _cityTableView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
        }
    }
    return _cityTableView;
}

- (UIActivityIndicatorView *)activity {
    if (!_activity) {
        _activity = [[UIActivityIndicatorView alloc]init];
        _activity.activityIndicatorViewStyle = UIActivityIndicatorViewStyleGray;
    }
    return _activity;
}

@end
