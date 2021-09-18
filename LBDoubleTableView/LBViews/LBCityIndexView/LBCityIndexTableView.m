//
//  LBCityIndexTableView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/9.
//

#import "LBCityIndexTableView.h"
#import "LBIndexView.h"

@interface LBCollectionCell()

@property(nonatomic, strong)UILabel* title;
@property(nonatomic, copy)NSString * text;

@end

@implementation LBCollectionCell

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview:self.title];
    [self.title mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.right.offset(0);
    }];
}

- (void)setText:(NSString *)text {
    _text = text;
    self.title.text = text;
}

- (UILabel *)title {
    if (!_title) {
        _title = [UILabel new];
        _title.font = LBFontNameSize(Font_Regular, 13);
        _title.textAlignment = NSTextAlignmentCenter;
        _title.layer.cornerRadius = 5;
        _title.clipsToBounds = YES;
    }
    return _title;
}

@end

@interface LBHistoryCell() <UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic, strong)UICollectionView* collectionView;
@property(nonatomic, strong)NSIndexPath* index;
@property(nonatomic, strong)NSIndexPath* currentSelectedIndex;
@property(nonatomic, strong)NSMutableArray* dataArray;
@property(nonatomic, copy)NSString* selectedHotIndex;  // 热门
@property(nonatomic, strong)NSMutableArray* historyArray;  // 历史
+ (LBHistoryCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)cellId;

@end

@implementation LBHistoryCell

+ (LBHistoryCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)cellId {
    LBHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[LBHistoryCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createUI];
        // 取出上次选中的缓存index
        NSUserDefaults* defaults = [NSUserDefaults standardUserDefaults];
        self.selectedHotIndex = [defaults objectForKey:@"hotSelected"];
        NSMutableArray* historyData = [LBUserDefaultTool getHistoryData];
        [self.historyArray addObjectsFromArray:historyData];
    }
    return self;
}

- (void)createUI {
    [self.contentView addSubview:self.collectionView];
    [self.collectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.bottom.offset(0);
    }];
}

- (void)setIndex:(NSIndexPath *)index {
    _index = index;
}

- (void)setDataArray:(NSMutableArray *)dataArray {
    _dataArray = dataArray;
}

#pragma mark - <UICollectionViewDataSource>
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.dataArray.count>0 ?self.dataArray.count : 0;
}

#pragma mark - item宽高
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath {
    return CGSizeMake((self.collectionView.width - LBFit(60))/3, LBFit(40));
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    LBCollectionCell * collectionCell = [collectionView dequeueReusableCellWithReuseIdentifier:@"historyCell" forIndexPath:indexPath];
    [collectionCell setValue:self.dataArray[indexPath.item] forKey:@"text"];
    if (self.index.section==0) {
        collectionCell.title.textColor = indexPath.item==0?LBUIColorWithRGB(0x228B22, 1):LBUIColorWithRGB(0x130202, 1);
        collectionCell.title.backgroundColor = indexPath.item==0?LBUIColorWithRGB(0x3CB371, .5):LBUIColorWithRGB(0xF5F5F5, 1);
    } else if (self.index.section==1) {
        collectionCell.title.textColor = [self.historyArray.firstObject isEqualToString:self.dataArray[indexPath.item]]?LBUIColorWithRGB(0x228B22, 1):LBUIColorWithRGB(0x130202, 1);
        collectionCell.title.backgroundColor = [self.historyArray.firstObject isEqualToString:self.dataArray[indexPath.item]]?LBUIColorWithRGB(0x3CB371, .5):LBUIColorWithRGB(0xF5F5F5, 1);
    }
    return collectionCell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    LBCollectionCell * cell = (LBCollectionCell *)[collectionView cellForItemAtIndexPath:indexPath];
    LBCollectionCell * currentCell;
    if (self.index.section==0&&indexPath.row!=0) {
        currentCell = (LBCollectionCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    if (self.index.section==1&&indexPath.row!=[self.selectedHotIndex integerValue]) {
        currentCell = (LBCollectionCell *)[collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:[self.selectedHotIndex integerValue] inSection:0]];
    }
    cell.title.backgroundColor = LBUIColorWithRGB(0x3CB371, .5);
    cell.title.textColor = LBUIColorWithRGB(0x228B22, 1);
    currentCell.title.backgroundColor = LBUIColorWithRGB(0xF5F5F5, 1);
    currentCell.title.textColor = LBUIColorWithRGB(0x130202, 1);
    
    if (self.collectionCallback) {
        self.collectionCallback(self.dataArray[indexPath.item],indexPath.item,self.index);
    }
}

- (UICollectionView *)collectionView {
    if (!_collectionView) {
        UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
        //设置布局方向为垂直流布局
        layout.scrollDirection = UICollectionViewScrollDirectionVertical;
        // 行间距
        layout.minimumLineSpacing = LBFit(10);
        layout.minimumInteritemSpacing = LBFit(10);
        layout.sectionInset = UIEdgeInsetsMake(LBFit(10), LBFit(10), LBFit(10), LBFit(30)); //设置距离上 左 下 右
        _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
         [_collectionView registerClass:[LBCollectionCell class] forCellWithReuseIdentifier:@"historyCell"];
        _collectionView.backgroundColor = LBUIColorWithRGB(0xFFFFFF, 1.0);
    }
    return _collectionView;
}

- (NSMutableArray *)historyArray {
    if (!_historyArray) {
        _historyArray = @[].mutableCopy;
    }
    return _historyArray;
}

@end

@interface LBCityCell()

@property(nonatomic, strong)UILabel* cityLabel;
@property(nonatomic, strong)UIImageView* selectedImg;
+ (LBCityCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)cellId;

@end

@implementation LBCityCell

+ (LBCityCell *)tableView:(UITableView *)tableView dequeueReusableCellWithIdentifier:(NSString *)cellId {
    LBCityCell * cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (cell == nil) {
        cell = [[LBCityCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
        cell.textLabel.adjustsFontSizeToFitWidth = YES;
    }
    return cell;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self.contentView addSubview:self.cityLabel];
    [self.contentView addSubview:self.selectedImg];
    
    [self.cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.offset(LBFit(10));
        make.centerY.offset(0);
    }];
    [self.selectedImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.offset(-LBFit(30));
        make.centerY.offset(0);
    }];
}

- (UILabel *)cityLabel {
    if (!_cityLabel) {
        _cityLabel = [UILabel new];
        _cityLabel.font = LBFontNameSize(Font_Regular, 15);
    }
    return _cityLabel;
}

- (UIImageView *)selectedImg {
    if (!_selectedImg) {
        _selectedImg = [UIImageView new];
        _selectedImg.image = [UIImage imageNamed:@"duihao"];
    }
    return _selectedImg;
}

@end

@interface LBCityIndexTableView() <UITableViewDelegate,UITableViewDataSource,LBIndexViewDataSource,LBIndexViewDelegate>

@property(nonatomic, strong)UITableView* cityTableView;
@property(nonatomic, strong)NSMutableArray* dataSource;
@property(nonatomic, strong)UIActivityIndicatorView* activity;
@property(nonatomic, strong)NSIndexPath* currentSelectedIndex;
@property(nonatomic, strong)LBIndexView* indexView;

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
    [self addSubview:self.indexView];

    [self.activity mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.offset(0);
        make.width.height.mas_equalTo(LBFit(100));
    }];
    [self.cityTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.right.top.bottom.left.offset(0);
    }];
    
    [self.indexView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.centerY.offset(0);
        make.right.offset(0);
        make.height.mas_equalTo(LBScreenH/3*2);
        make.width.mas_equalTo(LBFit(30));
    }];
    
    //菊花开始
    [self.activity startAnimating];
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    
    [self.activity stopAnimating];
    [self.cityTableView reloadData];
    
    [self.indexView reloadIndexView];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return self.dataSource.count>0?self.dataSource.count:0;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSMutableDictionary* dict = self.dataSource[section];
    NSMutableArray* arr = dict[@"cityName"];
    return section==0||section==1?1:arr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section {
    return section==0||section==1?LBFit(50):LBFit(30);
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSMutableDictionary* dict = self.dataSource.firstObject;
    NSMutableArray* arr = dict[@"cityName"];
    CGFloat sectionZeroFloat = ceil(arr.count/3.0)*LBFit(40)+(ceil(arr.count/3.0)+1)*LBFit(10)<=50?50:ceil(arr.count/3.0)*LBFit(40)+(ceil(arr.count/3.0)+1)*LBFit(10);

    return indexPath.section==0?sectionZeroFloat:indexPath.section==1?LBFit(360):LBFit(60);
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
   return [self sectionView:section];
}
#pragma mark - tableViewDataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.section == 0 || indexPath.section == 1) {
        static NSString *cellId = @"historyCellID";
        LBHistoryCell* cell = [LBHistoryCell tableView:tableView dequeueReusableCellWithIdentifier:cellId];
        NSMutableDictionary* dict = self.dataSource[indexPath.section];
        NSMutableArray* cellArr = dict[@"cityName"];
        cell.dataArray = cellArr;
        cell.index = indexPath;
        // callback回调
        [self historyAndHotCellCallback:cell];
        
        return cell;
    }
    static NSString *cellId = @"cityIndexCellID";
    LBCityCell * cell = [LBCityCell tableView:tableView dequeueReusableCellWithIdentifier:cellId];
    // 取出历史区的数据，第一个为当前选中的
    NSMutableArray* arr = [LBUserDefaultTool getHistoryData];
    // cell赋值
    NSMutableDictionary* dict = self.dataSource[indexPath.section];
    NSMutableArray* cellArr = dict[@"cityName"];
    // 得到当前选中的indexPath并记录
    if ([arr.firstObject isEqualToString:cellArr[indexPath.row]]) {
        self.currentSelectedIndex = [NSIndexPath indexPathForRow:indexPath.row inSection:indexPath.section];
    }
 
    cell.cityLabel.text = cellArr[indexPath.row];
    cell.cityLabel.textColor = [arr.firstObject isEqualToString:cellArr[indexPath.row]]?LBUIColorWithRGB(0x228B22, 1):LBUIColorWithRGB(0x130202, 1);
    cell.selectedImg.alpha = [arr.firstObject isEqualToString:cellArr[indexPath.row]]?1:0;
    
    return cell;
}
#pragma mark - 历史和热门cell点击的回调--historyAndHotCellCallback
- (void)historyAndHotCellCallback:(LBHistoryCell *)cell {
    LBWeakSelf(self);
    cell.collectionCallback = ^(NSString *selectText,NSInteger collectionSelectIndex,NSIndexPath *index) {
        LBStrongSelf(self);
        if (index.section==1) { // 热门回调，存入缓存
            [LBUserDefaultTool saveHotSelectedData:collectionSelectIndex];
        } else {                // 历史回调
            NSMutableDictionary* dict = self.dataSource[1];
            NSMutableArray* cellArr = dict[@"cityName"];
            // 清热门选中缓存，重新存
            [LBUserDefaultTool removeHotSelected];
            // 查找热门中的数据与历史里选中的数据相同
            [cellArr enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
                if ([object isEqualToString:selectText]) {
                    [LBUserDefaultTool saveHotSelectedData:idx];
                }
            }];
        }
        if (self.selectCallback) {
            self.selectCallback(selectText);
        }
    };
}

#pragma mark - tableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    // 下面tableView点击
    if (indexPath.section!=0&&indexPath.section!=1) {
        [LBUserDefaultTool removeHotSelected];
        NSMutableDictionary* dict = self.dataSource[indexPath.section];
        NSString* selectText = dict[@"cityName"][indexPath.row];
        if (self.selectCallback) {
            self.selectCallback(selectText);
        }
    }
    // cell选中的标记符变化和titleLabel颜色变化
    LBCityCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    LBCityCell *currentCell = [tableView cellForRowAtIndexPath:self.currentSelectedIndex];
    currentCell.cityLabel.textColor = LBUIColorWithRGB(0x130202, 1);
    currentCell.selectedImg.alpha = 0;
    cell.selectedImg.alpha = 1;
    cell.cityLabel.textColor = LBUIColorWithRGB(0x228B22, 1);
}

#pragma mark - LBIndexViewDataSource
- (NSInteger)numberOfItemViewForSectionIndexView:(LBIndexView *)sectionIndexView {
    return self.cityTableView.numberOfSections;
}
- (NSString *)sectionIndexView:(LBIndexView *)sectionIndexView titleForSection:(NSInteger)section {
    NSMutableArray* sectionArr = @[].mutableCopy;
    [self.dataSource enumerateObjectsUsingBlock:^(id object, NSUInteger idx, BOOL *stop) {
        NSMutableDictionary* dict = object;
        [sectionArr addObject:dict[@"cityId"]];
    }];
    
    return sectionArr[section];
}
#pragma mark - LBIndexViewDelegate
- (void)sectionIndexView:(LBIndexView *)sectionIndexView didSelectSection:(NSInteger)section {
    // section滚动到顶部
    [self.cityTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:section] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if (scrollView.isTracking || scrollView.isDecelerating) {
        NSInteger firstVisibleSection = self.cityTableView.indexPathsForVisibleRows.firstObject.section;
        [self.indexView setupTitleBGView:firstVisibleSection];
    } else {
        return;  // 不是用手指滚动的，不需要处理
    }
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView {
    [self.indexView setupTitleBGView:0];
}

- (UIView *)sectionView:(NSInteger)section {
    NSMutableDictionary* dict = self.dataSource[section];
    UIView* sectionView = [UIView new];
    sectionView.backgroundColor = section==0||section==1?LBUIColorWithRGB(0xFFFFFF, 1):LBUIColorWithRGB(0xF5F5F5, 1);
        
    UILabel* cityLabel = [UILabel new];
    cityLabel.text = dict[@"cityId"];
    cityLabel.textColor = LBUIColorWithRGB(0x130202, 1);
    cityLabel.font = section==0||section==1?LBFontNameSize(Font_Bold, 17):LBFontNameSize(Font_Bold, 14);
    [sectionView addSubview:cityLabel];
    [cityLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.right.offset(0);
        make.left.offset(10);
    }];
    return sectionView;
}

#pragma mark - lazy load
- (UITableView *)cityTableView {
    if (!_cityTableView) {
        _cityTableView = [[UITableView alloc] initWithFrame:[UIScreen mainScreen].bounds style:UITableViewStylePlain];
        _cityTableView.delegate = self;
        _cityTableView.dataSource = self;
        _cityTableView.tableFooterView = [UIView new];
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

- (LBIndexView *)indexView {
    if (!_indexView) {
        _indexView = [LBIndexView new];
        _indexView.dataSource = self;
        _indexView.delegate = self;
        /*设置indexView的属性*/
//        _indexView.schemeColor = LBUIColorWithRGB(0x228B22, 1);
//        _indexView.calloutViewType = 2;
//        _indexView.titleBGViewType = 1;
//        _indexView.isShowCallout = NO;
    }
    return _indexView;
}

@end
