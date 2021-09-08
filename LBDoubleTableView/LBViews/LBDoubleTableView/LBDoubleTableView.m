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

- (void)baseTableViewCallback {
    WeakSelf(weakSelf);
    self.baseTableView.didSelectCellCallback = ^(NSIndexPath *indexPath, UITableViewCell *currentBaseCell) {
        StrongSelf(strongSelf);
        LBModel* model = strongSelf.dataSource[indexPath.row];
        [strongSelf.childTableView setValue:model.cityList forKey:@"childData"];
        [strongSelf.childTableView reload];
        strongSelf.currentIndex = indexPath;
    };
}

- (void)childTableCallback {
    WeakSelf(weakSelf);
    self.childTableView.freshFinishCallback = ^ {
        StrongSelf(strongSelf);
        [strongSelf setCurrentIndexWithRow:strongSelf.currentIndex.row+1];
        [strongSelf.baseTableView reload];
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
    [self.baseTableView tableView:self.baseTableView.baseTableView didSelectRowAtIndexPath:currentIndex];
    self.currentIndex = currentIndex;
    [self.baseTableView setValue:self.currentIndex forKey:@"selectedIndex"];
    
    [self.baseTableView.baseTableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:row inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:YES];
}

@end
