//
//  LBAllSectionView.m
//  LBDoubleTableView
//
//  Created by 理享学 on 2021/9/8.
//

#import "LBAllSectionView.h"
#import "LBAllSectionTableView.h"

@interface LBAllSectionView()

@property(nonatomic, strong)NSMutableArray* dataSource;
@property(nonatomic, strong)LBAllSectionTableView* allSectionView;

@end

@implementation LBAllSectionView

- (instancetype)initWithFrame:(CGRect)frame {
    if (self = [super initWithFrame:frame]) {
        self.backgroundColor = [UIColor whiteColor];
        [self createUI];
    }
    return self;
}

- (void)createUI {
    [self addSubview: self.allSectionView];
    
    [self.allSectionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.bottom.left.right.offset(0);
        make.top.mas_equalTo(LBkWindow.safeAreaInsets.top>0 ?88:64);
    }];
}

- (void)setDataSource:(NSMutableArray *)dataSource {
    _dataSource = dataSource;
    [self.allSectionView setValue:dataSource forKey:@"dataSource"];
}

- (LBAllSectionTableView *)allSectionView {
    if (!_allSectionView) {
        _allSectionView = [LBAllSectionTableView new];
    }
    return _allSectionView;
}

@end
