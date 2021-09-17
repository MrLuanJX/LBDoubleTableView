//
//  LBDoubleTableView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import "LBDoubleTableView.h"
#import "LBBaseTableView.h"
#import "LBChildTableView.h"

@interface LBDoubleTableView()

@property(nonatomic, strong)LBBaseTableView* baseTableView;
@property(nonatomic, strong)LBChildTableView* childTableView;
@property(nonatomic, strong)NSMutableArray* dataSource;
@property(nonatomic, strong)NSIndexPath* currentIndex;

@end

@implementation LBDoubleTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
        [self baseTableViewCallback];
        [self childTableCallback];
    }
    return self;
}

- (void)createUI {
    [self addSubview: self.baseTableView];
    [self addSubview: self.childTableView];
    
    [self.baseTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.bottom.left.offset(0);
        make.width.mas_equalTo(LBScreenW/3);
    }];
    [self.childTableView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.top.right.bottom.offset(0);
        make.left.mas_equalTo(LBScreenW/3);
    }];
}
#pragma mark - leftTableView点击回调
- (void)baseTableViewCallback {
    LBWeakSelf(self);
    self.baseTableView.didSelectCellCallback = ^(NSIndexPath *indexPath, UITableViewCell *currentBaseCell) {
        LBStrongSelf(self);
        LBModel* model = self.dataSource[indexPath.row];
        // 数据源传给rightTableView
        [self.childTableView setValue:model.cityList forKey:@"childData"];
        // 刷新rightTableView
        [self.childTableView reload];
        self.currentIndex = indexPath;
    };
}
#pragma mark - rightTableView刷新回调
- (void)childTableCallback {
    LBWeakSelf(self);
    self.childTableView.freshFinishCallback = ^ {
        LBStrongSelf(self);
        [self setCurrentIndexWithRow:self.currentIndex.row+1];
    };
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    [self.baseTableView setValue:dataSource forKey:@"baseData"];
    
    [self setCurrentIndexWithRow:0];
}

- (LBChildTableView *)childTableView {
    if (!_childTableView) {
        _childTableView = [LBChildTableView new];
    }
    return _childTableView;
}

- (LBBaseTableView *) baseTableView{
    if (!_baseTableView) {
        _baseTableView = [LBBaseTableView new];
    }
    return _baseTableView;
}

- (void)setCurrentIndexWithRow:(NSInteger)row {
    NSIndexPath *currentIndex = [NSIndexPath indexPathForRow:row inSection:0];
    // 调用leftTableView的didSelectRowAtIndexPath方法实现选中下一个indexPathRow
    [self.baseTableView tableView:self.baseTableView.baseTableView didSelectRowAtIndexPath:currentIndex];
    // 记录当前选中的indexPath
    self.currentIndex = currentIndex;
    [self.baseTableView setValue:self.currentIndex forKey:@"selectedIndex"];
    
    [self.baseTableView.baseTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
