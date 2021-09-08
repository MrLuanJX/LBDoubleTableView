//
//  LBAllSectionTableView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import "LBAllSectionTableView.h"
#import "LBAllSectionBaseTableView.h"
#import "LBAllSectionChildTableView.h"

@interface LBAllSectionTableView()

@property(nonatomic, strong)LBAllSectionBaseTableView* baseTableView;
@property(nonatomic, strong)LBAllSectionChildTableView* childTableView;
@property(nonatomic, strong)NSMutableArray* dataSource;

@end

@implementation LBAllSectionTableView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor redColor];
        [self createUI];
        [self baseTableViewCallback];
        [self childTableViewCallback];
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

- (void)baseTableViewCallback {
    WeakSelf(weakSelf);
    self.baseTableView.didSelectCellCallback = ^(NSIndexPath *indexPath, UITableViewCell *currentBaseCell) {
        StrongSelf(strongSelf);
        LBModel* model = strongSelf.dataSource[indexPath.row];
        if (model.cityList.count>0) {
            [strongSelf.childTableView setValue:@(indexPath.row) forKey:@"selectedIndex"];
        }
    };
}

- (void)childTableViewCallback {
    WeakSelf(weakSelf);
    self.childTableView.scrollFinishCallback = ^(NSInteger scrollIndex) {
        StrongSelf(strongSelf);
        NSIndexPath* currentIndex = [NSIndexPath indexPathForRow:scrollIndex inSection:0];
        [strongSelf.baseTableView scrollwithIndex:currentIndex];
    };
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    [self.baseTableView setValue:dataSource forKey:@"baseData"];
    [self.childTableView setValue:dataSource forKey:@"childData"];
}

- (LBAllSectionBaseTableView *)baseTableView {
    if (!_baseTableView) {
        _baseTableView = [LBAllSectionBaseTableView new];
    }
    return _baseTableView;
}

- (LBAllSectionChildTableView *)childTableView {
    if (!_childTableView) {
        _childTableView = [LBAllSectionChildTableView new];
    }
    return _childTableView;
}

@end
